//
//  TopPipeObstacle.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 26.10.25.
//
import Foundation

struct TopPipeObstacle: Obstacle {
    var id: UUID = UUID()
    var position: CGPoint
    var size: CGSize
    var imageName: String
    var angel: Double = 0
    var blowsFor: Double
    var force: Int
    var code: String {
            """
                                LTopPipe(
                                    x: \(position.x),
                                    blowsFor: \(blowsFor),
                                    delay: 1,
                                    rest: 2,
                                    force: \(force)),
            """
    }
    
    init(position: CGPoint, size: CGSize, imageName: String) {
        self.position = position
        self.size = size
        self.imageName = imageName
        self.blowsFor = 2
        self.force = 200
    }
}
