//
//  MapController.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 2.09.25.
//

import Foundation
import SwiftUI

class MapController: ObservableObject {
    
    @Published var selectedObstacleType: Obstacle.ObstacleObject = .gasCyls_gas
    @Published var gameMap: GameMap
    private let scale = Constant.scale
    
    init() {
        self.gameMap = GameMap(width: 30, height: 9, obstacles: [])
    }
    
    func codeGenerator() -> String {
        let codeGeneratot = CodeGenerator(gameMap: gameMap)
        return codeGeneratot.codeGenerator()
    }
    
    func positionForObstacle(_ obstacle: Obstacle) -> CGPoint {
        if obstacle.type == .ceilingItems || obstacle.type == .pinnedBalls || obstacle.type == .magnets || obstacle.type == .hood {
            CGPoint(x: (obstacle.position.x * scale),
                    y: ((CGFloat(gameMap.height) - obstacle.position.y) * scale))
        } else {
            CGPoint(x: ((obstacle.position.x + obstacle.size.width / 2) * scale),
                    y: ((CGFloat(gameMap.height) - (obstacle.position.y - obstacle.size.height / 2)) * scale))
        }
    }
    
    func checkCollision(at location: CGPoint) -> Bool {
        let size = selectedObstacleType.obstacle.size
        //return !gameMap.obstacles.contains { $0.collides(with: selectedObstacleType.obstacle)}
        let res = !gameMap.obstacles.contains { $0.collides(at: location, size: size) }
        if !res {
            //print("location: \(location); sise \(size)" )
            
        }
        print("location \(location)" )
        return res
    }
    
    func deleteLastObstacle() {
        guard !gameMap.obstacles.isEmpty else { return }
        gameMap.obstacles.removeLast()
    }
    
    func addObstacle(at location: CGPoint, obstaclePrewiew: Obstacle) {
        let relativeX = location.x / scale
        var relativeY = (CGFloat(gameMap.height) * scale - location.y) / scale
        
        // Проверка, что точка внутри карты
        guard relativeX >= 0, relativeX <= CGFloat(gameMap.width),
              relativeY >= 0, relativeY <= CGFloat(gameMap.height) else { return }
        var newObstacle = selectedObstacleType.obstacle
        
        if relativeY - obstaclePrewiew.size.height < 0.3 {
            relativeY = obstaclePrewiew.size.height - 0
        }
        newObstacle.position = CGPoint(x: relativeX, y: relativeY).rounded(decimals: 2)
        gameMap.obstacles.append(newObstacle)
    }
    
    func settingObstacle() {
        
    }
    
    func saveTextToFile(_ text: String, fileName: String = "level_MCR.txt") {
        let savePanel = NSSavePanel()
        savePanel.allowedContentTypes = [.plainText]
        savePanel.nameFieldStringValue = fileName
        
        savePanel.begin { response in
            guard response == .OK, let url = savePanel.url else { return }
            
            do {
                try text.write(to: url, atomically: true, encoding: .utf8)
                NSSound(named: "Glass")?.play()
            } catch {
                print("Ошибка: \(error.localizedDescription)")
            }
        }
    }
}

