//
//  HoodObstacle.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 26.10.25.
//
import Foundation

struct HoodObstacle: Obstacle {
    var id: UUID = UUID()
    var position: CGPoint
    var size: CGSize
    var imageName: String
    var angel: Double = 0
    var workHeight: Int
    var power: Int
    var code: String {
            """
                            LHood(x: \(position.x), height: \(workHeight), power: \(power))),
            """
    }
    
    init(position: CGPoint, size: CGSize, imageName: String) {
        self.position = position
        self.size = size
        self.imageName = imageName
        self.workHeight = 5
        self.power = 100
    }
}
