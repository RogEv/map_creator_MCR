//
//  ContentView.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 15.08.25.
//

import SwiftUI

struct MapEditorView: View {
    private let sizeStep = 30.0
    @State private var gameMap: GameMap = GameMap(width: 30, height: 9, obstacles: [])
    @State private var selectedObstacleType: Obstacle.ObstacleObject = .gasCyls_gas
    @State private var showingExportDialog: Bool = false
    @State private var obstaclePrewiew: Obstacle? = nil
    private let scale = 30.0
    var body: some View {
        
        VStack {
            HStack(spacing: 16) {
                Button("Отмена последнего", systemImage: "arrow.uturn.backward") {
                    guard !gameMap.obstacles.isEmpty else { return }
                    gameMap.obstacles.removeLast()
                }
                .disabled(gameMap.obstacles.isEmpty)
                .buttonStyle(.bordered)
                
                Label(
                    title: {
                        if let preview = obstaclePrewiew {
                            Text("x: \(preview.position.x, specifier: "%.1f"), y: \(9 - preview.position.y, specifier: "%.1f")")
                        } else {
                            Text("Не выбрано")
                        }
                    },
                    icon: {
                        Image(systemName: "location.circle.fill")
                    }
                )
                .font(.subheadline.monospacedDigit())
            }
            .padding()
            .background(.regularMaterial)
            .cornerRadius(12)
            
            HStack {
                Picker("Тип препятствия", selection: $selectedObstacleType)
                {
                    ForEach(Obstacle.ObstacleObject.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }
                Stepper(
                    value: $gameMap.width,
                    in: 20...50,
                    step: 1
                ) {
                    Text("Ширина карты: \(gameMap.width)")
                }
                Button("Экспорт кода"){
                    exportMap()
                    showingExportDialog = true
                }
                Button("Очистить карту"){
                    gameMap.obstacles.removeAll()
                    obstaclePrewiew = nil
                }
            }
            HStack{
                Table(gameMap.obstacles) {
                    TableColumn("#") { item in
                        Text("\(gameMap.obstacles.firstIndex(where: { $0.id == item.id })! + 1)")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .width(20)
                    
                    TableColumn("Общая информация") { (obstacle: Obstacle) in
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("**Тип:** \(obstacle.type.rawValue)")
                                .font(.subheadline)
                            HStack{
                                if let index = gameMap.obstacles.firstIndex(where: { $0.id == obstacle.id }){
                                    Text("Позиция: \(obstacle.position.x.formatted())×\((9 - obstacle.position.y).formatted())")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Stepper("X", value: Binding(
                                        get: { gameMap.obstacles[index].position.x },
                                        set: { gameMap.obstacles[index].position.x = $0 }
                                    ), in: 0...1000, step: 0.1)
                                    Stepper("Y", value: Binding(
                                        get: { gameMap.obstacles[index].position.y },
                                        set: { gameMap.obstacles[index].position.y = $0 }
                                    ), in: 0...1000, step: 0.1)
                                    Button("Удалить"){
                                        gameMap.obstacles.remove(at: index)
                                    }
                                }
                            }
                            
                            HStack{
                                Text("Размер: X:\(obstacle.size.width.formatted())× Y:\(obstacle.size.height.formatted())")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                            }
                        }
                    }
                    
                }
                .frame(width: 350)
                
                VStack{
                    ScrollView(.horizontal){
                        ZStack{
                            Rectangle()
                                .fill(Color.white.opacity(0.3))
                                .frame(
                                    width: CGFloat(gameMap.width) * scale,
                                    height: CGFloat(gameMap.height) * scale)
                                .border(Color.black, width: 2)
                            
                            ForEach(gameMap.obstacles) { obstacle in
                                ObstacleView(obstacle: obstacle)
                                    .frame(width: obstacle.size.width * scale,
                                           height: obstacle.size.height * scale)
                                    .position(positionForObstacle(obstacle))
                            }
                            
                            if let obstacle = obstaclePrewiew {
                                ObstacleView(obstacle: obstacle)
                                    .frame(width: obstacle.size.width * scale,
                                           height: obstacle.size.height * scale)
                                    .position(
                                        positionForObstacle(obstacle)
                                    )
                            }
                            
                            Rectangle()
                                .fill(Color.clear)
                                .contentShape(Rectangle())
                                .frame(width: CGFloat(gameMap.width) * scale,
                                       height: CGFloat(gameMap.height) * scale)
                                .gesture(
                                    DragGesture(minimumDistance: 0)
                                        .onChanged { value in
                                            updateObstaclePreview(at: value.location)
                                        }
                                        .onEnded{ value in
                                            addObstacle(at: value.location)
                                            obstaclePrewiew = nil
                                        }
                                )
                        }
                        .frame(width: CGFloat(gameMap.width) * scale, height: CGFloat(gameMap.height) * scale)
                    }
                    ScrollView {
                        Text("КОД УРОВНЯ")
                        Text(codGenerator())
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
    
    func codGenerator() -> String {
        let codeGeneratot = CodeGenerator(gameMap: gameMap)
       return codeGeneratot.codeGenerator()
    }
    
    func positionForObstacle(_ obstacle: Obstacle) -> CGPoint {
        
        if obstacle.type == .ceilingItems {
            CGPoint(x: (obstacle.position.x * scale),
                    y: ((CGFloat(gameMap.height) - obstacle.position.y) * scale)
            )
        }
        else {
            CGPoint(x: ((obstacle.position.x + obstacle.size.width / 2) * scale),
                    y: ((CGFloat(gameMap.height) - (obstacle.position.y - obstacle.size.height / 2)) * scale)
            )
        }
        
    }
    
    private func updateObstaclePreview(at location: CGPoint) {
        let relativeX = location.x / scale
        var relativeY = (CGFloat(gameMap.height) * scale - location.y) / scale
        
        // Проверка, что точка внутри карты
        guard relativeX >= 0, relativeX <= CGFloat(gameMap.width),
              relativeY >= 0, relativeY <= CGFloat(gameMap.height)
        else {
            obstaclePrewiew = nil
            return }
        
        // Прверка, что нет коллизии
        
        guard checkCollision(at: CGPoint(x: relativeX, y: relativeY), size: selectedObstacleType.obstacle.size )
        else {
            obstaclePrewiew = nil
            return
        }
        
        
        obstaclePrewiew = selectedObstacleType.obstacle
        if relativeY - (obstaclePrewiew?.size.height)! < 0.3 {
            relativeY = (obstaclePrewiew?.size.height)! - 0
        }
        obstaclePrewiew?.position = CGPoint(x: relativeX, y: relativeY).rounded(decimals: 2)
        
        
    }
    
    func checkCollision(at location: CGPoint, size: CGSize) -> Bool {
        !gameMap.obstacles.contains { $0.collides(at: location, size: size) }
    }
    
    private func addObstacle(at location: CGPoint) {
        let relativeX = location.x / scale
        var relativeY = (CGFloat(gameMap.height) * scale - location.y) / scale
        
        // Проверка, что точка внутри карты
        guard relativeX >= 0, relativeX <= CGFloat(gameMap.width),
              relativeY >= 0, relativeY <= CGFloat(gameMap.height) else { return }
        var newObstacle = selectedObstacleType.obstacle
        if relativeY - (obstaclePrewiew?.size.height)! < 0.3 {
            relativeY = (obstaclePrewiew?.size.height)! - 0
        }
        newObstacle.position = CGPoint(x: relativeX, y: relativeY).rounded(decimals: 2)
        gameMap.obstacles.append(newObstacle)
    }
    private func exportMap() {
        
    }
}

struct ObstacleView: View {
    let obstacle : Obstacle
    var body: some View {
        Group {
            Rectangle()
                .fill(Color.clear)
                .background(
                    Image(obstacle.image!)
                        .resizable()
                        .scaledToFit()
                )
        }
        .overlay(
            RoundedRectangle(cornerRadius: 2)
                .stroke(Color.black, lineWidth: 1))
    }
}
//#Preview {
//    MapEditorView()
//}
