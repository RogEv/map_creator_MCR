//
//  LTracedShapeObstacle.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 25.10.25.
//
import Foundation

struct LTracedShapeObstacle: Obstacle {
    var id: UUID = UUID()
    var position: CGPoint
    var size: CGSize
    var imageName: String
    var angel: Double = 0
    var traceImage: String
    var isWin: Bool = false
    var code: String {
                    """
                                        LTracedShape(spriteName: "\(imageName)",
                                                     traceImage: "\(traceImage)",
                                                     topHoleUV: \(!isWin ? ".init(x1: 123 / 391, x2: 240 / 391)" : "nil"),
                                                     rect: CGRect(x: \(position.x), y: \(imageName == "go_flask_01" ? position.y - 1 : position.y), width: \(size.width), height: \(size.height))\(!isWin ? ".en(in: 1.1)" : ""),
                                                     zPosition: 18,
                                                     winObject: \(isWin),
                                                     density: 30),
                    """
    }
    
    init(position: CGPoint, size: CGSize, imageName: String, traceImage: String, isWin: Bool) {
        self.position = position
        self.size = size
        self.imageName = imageName
        self.traceImage = traceImage
        self.isWin = isWin
    }
    
}
