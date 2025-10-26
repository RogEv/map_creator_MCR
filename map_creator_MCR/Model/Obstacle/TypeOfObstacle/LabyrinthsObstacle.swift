//
//  LabyrinthsObstacle.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 26.10.25.
//
import Foundation

struct LabyrinthsObstacle: Obstacle {
    var id: UUID = UUID()
    var position: CGPoint
    var size: CGSize
    var imageName: String
    var angel: Double = 0
    
    var code: String {
                        """
                                            .init(type: .\(imageName), position: CGPoint(x: \(position.x), y: \(position.y)), mufted: true),
                        """
    }
    
    init(position: CGPoint, size: CGSize, image: String) {
        self.position = position
        self.size = size
        self.imageName = image
    }
}
