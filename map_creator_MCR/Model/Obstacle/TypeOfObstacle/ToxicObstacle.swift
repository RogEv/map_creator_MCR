//
//  ToxicObstacle.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 26.10.25.
//
import Foundation

struct ToxicObstacle: Obstacle {
    var id: UUID = UUID()
    
    var position: CGPoint
    
    var size: CGSize
    
    var imageName: String
    
    var angel: Double = 0
    
    var numberOfColor: Int
    
    var type: Int = 1
    
    var tolerance: Int = 150
    
    var code: String {
            """
                                LToxic(bottomCenter: CGPoint(x: \(position.x), y: \(position.y + size.height)), type: \(type), color: \(numberOfColor), mass: 0.8, tolerance: 150, smokeTTL: 6, scale: .init(dx: 4, dy: 2)),
            """
    }
    
    init(position: CGPoint, size: CGSize, image: String, type: Int) {
        self.position = position
        self.size = size
        self.imageName = image
        self.numberOfColor = Int.random(in: 1...5)
        self.type = type
        self.tolerance = 180
    }
    
}
