//
//  BreakableObstacle.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 25.10.25.
//
import Foundation

struct BreakableObstacle: Obstacle  {
    var id: UUID
    var position: CGPoint
    var size: CGSize
    var imageName: String
    var angel: Double = 0
    var damagedTexture: String
    var tolerance: Int
    
    var code: String {
            """
                            LBreakable(rect: CGRect(x: \(position.x), y:\(position.y), width: \(size.width), height: \(size.height)),
                                                    mass: 0.8,
                                                    texture: "\(imageName)",
                                                    damagedTexture: "\(damagedTexture))",
                                                    fragments: ["glass_scratch_01", "glass_scratch_02", "glass_scratch_03", "glass_scratch_01", "glass_scratch_02"],
                                                    fragmentsSize: CGSize(width: 0.8, height: 0.9),
                                                    tolerance: \(tolerance))),
            """
    }
    
    init(position: CGPoint, size: CGSize, imageName: String, damagedTexture: String) {
        self.position = position
        self.size = size
        self.imageName = imageName
        self.damagedTexture = damagedTexture
        self.tolerance = 200
    }
    
    
}
