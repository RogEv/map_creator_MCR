//
//  PinnedBallsObstacle.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 25.10.25.
//
import Foundation

struct PinnedBallsObstacle: Obstacle {
    var id: UUID = UUID()
    var position: CGPoint
    var size: CGSize
    var imageName: String
    var angel: Double = 0
    var gas: Int = 1000
    var code: String {
                    """
                                        LLeatherBall(spriteName: "\(imageName)",
                                                     radius: \(size.width/2),
                                                     center: CGPoint(x: \(position.x), y: \(position.y)),
                                                     gas: \(gas),
                    """
    }
    
    init(position: CGPoint, size: CGSize, imageName: String, gas: Int) {
        self.position = position
        self.size = size
        self.imageName = imageName
        self.gas = gas
    }
    
}
