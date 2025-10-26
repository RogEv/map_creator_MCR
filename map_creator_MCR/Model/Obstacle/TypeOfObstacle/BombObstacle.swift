//
//  BombObstacle.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 25.10.25.
//
import Foundation

struct BombObstacle: Obstacle {
    var id: UUID = UUID()
    var position: CGPoint
    var size: CGSize
    var imageName: String
    var angel: Double = 0
    
    var code: String {
            """
                                    LBomb(rect: CGRect(x: \(position.x), y: \(position.y), width: \(size.width), height: \(size.height)), power: 1),
            """
    }
    
    init(position: CGPoint, size: CGSize, imageName: String) {
        self.position = position
        self.size = size
        self.imageName = imageName
    }
    
}
