
//
//  CodeGenerator.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 22.08.25.
//

import Foundation

//struct LevelData: Codable {
//    let size: CGSize
//    let balls: [LBubble]
//    var gasCyls: [LFireGasCyl]? = nil
//    var ceilingItems: [LCeilingItem]? = nil
//    var pinnedBalls: [LLeatherBall]? = nil
//    var tracedShapes: [LTracedShape]? = nil
//    var lampXCoords: [CGFloat]? = nil
//    var boxedObjects: [LBoxedObject]? = nil
//    var tubes: [LTube]? = nil
//    var breakables: [LBreakable]? = nil
//    var lGens: [LLGen]? = nil
//    var bombs: [LBomb]? = nil
//    var topPipes: [LTopPipe]? = nil
//    var electricBoxes: [LElectricBox]? = nil
//}

class CodeGenerator {
    
    var gameMap: GameMap!
    
    init(gameMap: GameMap!) {
        self.gameMap = gameMap
    }
    func electricBoxesCodeGenerator() -> String {
        var codString = ""
        let electricBoxes = gameMap.obstacles.filter { $0.type == .electricBoxes }
        for electricBox in electricBoxes {
            codString += "\(electricBox.code) \n"
        }
        return codString
    }
    
    func topPipesCodeGenerator() -> String {
        var codString = ""
        let topPipes = gameMap.obstacles.filter { $0.type == .topPipes }
        for topPipe in topPipes {
            codString += "\(topPipe.code) \n"
        }
        return codString
    }
    
    func bombsCodeGenerator() -> String {
        var codString = ""
        let bombs = gameMap.obstacles.filter { $0.type == .bombs }
        for bomb in bombs {
            codString += "\(bomb.code) \n"
        }
        return codString
    }
    
    func iGensCodeGenerator() -> String {
        var codString = ""
        let iGens = gameMap.obstacles.filter { $0.type == .lGens }
        for iGen in iGens {
            codString += "\(iGen.code) \n"
        }
        return codString
    }
    
    func breakablesCodeGenerator() -> String {
        var codString = ""
        let breakables = gameMap.obstacles.filter { $0.type == .breakables }
        for breakable in breakables {
            codString += "\(breakable.code) \n"
        }
        return codString
    }
    
    func tubesCodeGenerator() -> String {
        var codString = ""
        let tubes = gameMap.obstacles.filter { $0.type == .tubes }
        for tube in tubes {
            codString += "\(tube.code) \n"
        }
        return codString
    }
    
    func boxesCodeGenerator() -> String {
        var codString = ""
        let boxes = gameMap.obstacles.filter { $0.type == .boxedObjects }
        for box in boxes {
            codString += "\(box.code) \n"
        }
        return codString
    }
    
    func lampsCodeGenerator() -> String {
        var codString = ""
        let lamps = gameMap.obstacles.filter { $0.type == .lampXCoords }
        
        for lamp in lamps {
            codString += "\(lamp.code) \n"
        }
        return codString
    }
    
    func tracedShapesCodeGenerator() -> String {
        var codString = ""
        let tracedShapes = gameMap.obstacles.filter { $0.type == .tracedShapes }
        let newTracedShapes = tracedShapes.compactMap { obstacle in
            var obs = obstacle
            obs.position.y = (CGFloat(gameMap.width) - obstacle.position.y).rounded(decimals: 2)
            return obs
        }
        for shape in newTracedShapes {
            codString += "\(shape.code) \n"
        }
        return codString
    }
    
    func pinnedBallsCodeGenerator() -> String {
        var codString = ""
        let pinnedBalls = gameMap.obstacles.filter { $0.type == .pinnedBalls }
        let newPinnedBalls = pinnedBalls.compactMap { obstacle in
            var obs = obstacle
            obs.position.y = (CGFloat(gameMap.width) - obstacle.position.y).rounded(decimals: 2)
            return obs
        }
        for ball in newPinnedBalls {
            codString += "\(ball.code) \n"
        }
        return codString
    }
    
    func gasCylsCodeGenerator() -> String {
        var codString = ""
        let gasCyls = gameMap.obstacles.filter { $0.type == .gasCyls }
        let newGasCyls = gasCyls.compactMap { obstacle in
            var obs = obstacle
            obs.position.y = (CGFloat(gameMap.width) - obstacle.position.y).rounded(decimals: 2)
            return obs
        }
        for gasCyl in newGasCyls {
            codString += "\(gasCyl.code) \n"
        }
        return codString
    }
    
    func lceilingItemsCodeGenerator() -> String {
        var codString = ""
        let lCeiling = gameMap.obstacles.filter { $0.type == .ceilingItems }
        let newLceiling = lCeiling.compactMap { obstacle in
            var obs = obstacle
            obs.position.y = (CGFloat(gameMap.height) - obstacle.position.y).rounded(decimals: 2)
            return obs
        }
        for item in newLceiling {
            codString += "\(item.code) \n"
        }
        return codString
    }
    
    func codeGeneratorByType(type: Obstacle.ObstacleType) -> String {
        var codString = ""
        let item = gameMap.obstacles.filter { $0.type == type }
        let newItem = item.compactMap { obstacle in
            var obs = obstacle
            obs.position.x = obs.position.x.rounded(decimals: 2)
            obs.position.y = (CGFloat(gameMap.height) - obstacle.position.y).rounded(decimals: 2)
            return obs
        }
        for item in newItem {
            codString += "\(item.code) \n"
        }
        return codString
    }
    
    func codeGenerator() -> String {
        let codString =
        """
        case 1:
        levelData = LevelData(
            size: CGSize(width: \(gameMap.width), height: 10),
            balls: [
                LBubble(tintColor: UIColor.bc(\(Int.random(in: 0...7))), radius: 0.4),
                LBubble(tintColor: UIColor.bc(\(Int.random(in: 0...7))), radius: 0.3),
                LBubble(tintColor: UIColor.bc(\(Int.random(in: 0...7))), radius: 0.25)
            ],
            gasCyls: [
                \(codeGeneratorByType(type: .gasCyls))
                ],
            ceilingItems: [
                \(codeGeneratorByType(type: .ceilingItems))
                ],
            pinnedBalls: [
                \(codeGeneratorByType(type: .pinnedBalls))
                ],
            tracedShapes: [
                \(codeGeneratorByType(type: .tracedShapes))
                ],
            lampXCoords: [
                \(codeGeneratorByType(type: .lampXCoords))
                ],
            boxedObjects: [
                \(codeGeneratorByType(type: .boxedObjects))
                ],
            tubes: [
                \(codeGeneratorByType(type: .tubes))
                ],
            breakables: [
                \(codeGeneratorByType(type: .breakables))
                ],
            lGens: [
                \(codeGeneratorByType(type: .lGens))
                ],
            bombs: [
                \(codeGeneratorByType(type: .bombs))
                ],
            topPipes: [
                \(codeGeneratorByType(type: .topPipes))
                ],
            electricBoxes: [
                \(codeGeneratorByType(type: .electricBoxes))
                ],
            hoods: [
                \(codeGeneratorByType(type: .hood))
                ],
            lightnings: [
                \(codeGeneratorByType(type: .lightnings))
                ],
            magnets: [
                \(codeGeneratorByType(type: .magnets))
                ],
            labyrinths: [
                LLabyrinth(elements: [
                    \(codeGeneratorByType(type: .labyrinths))
                ])],
            toxics: [
                \(codeGeneratorByType(type: .toxics))
                ]
        )
"""
       return codString
    }
}
