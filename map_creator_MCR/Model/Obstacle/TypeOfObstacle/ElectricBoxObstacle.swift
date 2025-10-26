//
//  ElectricBoxObstacle.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 26.10.25.
//
import Foundation

struct ElectricBoxObstacle: Obstacle {
    var id: UUID = UUID()
    var position: CGPoint
    var size: CGSize
    var imageName: String
    var angel: Double = 0
    var worksFor: Int
    var rest: Int
    var code: String {
            """
                            LElectricBox(x: \(position.x),
                                position: \(position.y < 1 ? ".top" : ".bottom"),
                                worksFor: \(worksFor)),
                                delay: 1,
                                rest: \(rest)),
            """
    }
    
    init(position: CGPoint, size: CGSize, imageName: String) {
        self.position = position
        self.size = size
        self.imageName = imageName
        self.worksFor = 20
        self.rest = 2
    }
}
