//
//  LampXObstacle.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 25.10.25.
//
import Foundation

struct LampXObstacle: Obstacle{
    var id: UUID = UUID()
    var position: CGPoint
    
    var size: CGSize
    
    var imageName: String = ""
    var angel: Double = 0
    var code: String {
        "\(position.x),"
    }
    
    init(position: CGPoint, size: CGSize, imageName: String) {
        self.position = position
        self.size = size
        self.imageName = imageName
    }
    
}

