//
//  Untitled.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 25.10.25.
//

import Foundation

struct GGasObstacle: Obstacle, TimedObstacle, FireObstacle {
   
    var id: UUID = UUID()
    var position: CGPoint
    var size: CGSize
    var imageName: String
    var angel: Double = 0
    
    var delay: Double = 1
    var duration: Double = 2
    var restTime: Double = 3
    var fireHeight: Double = 4
    var gasTime: Double = 2
    
    var code: String {
            """
                            LFireGasCyl(
                                sprite: "\(imageName)",
                                delay: \(delay),
                                gasTime: \(gasTime),
                                restTime: \(restTime),
                                fireHeight: \(fireHeight),
                                spriteFrame: CGRect(x: \(position.x), y: \(position.y), width: \(size.width), height: \(size.height))),
            """
        }
    
    init(position: CGPoint, size: CGSize, imageName: String, fireHeight: Double,) {
        self.position = position
        self.size = size
        self.imageName = imageName
        self.fireHeight = fireHeight
    }
}
