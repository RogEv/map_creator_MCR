//
//  MagnetObstacle.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 26.10.25.
//
import Foundation

struct MagnetObstacle: Obstacle, Codable {
    var id: UUID = UUID()
    var position: CGPoint
    var size: CGSize
    var imageName: String
    var angel: Double = 0
    var range: Double
    var power: Int
    var mode: MagnetMode
    
    var code: String {
            """
                            LMagnet(
                                position: CGPoint(x: \(position.x), y: \(position.y)),
                                range: \(range),
                                power: \(power)),
                                mode: \(mode),                    
            """
    }
    
    enum MagnetMode: String, CaseIterable, Codable, Hashable {
        case repilent = ".repilent"
        case attractive = ".attractive"
    }
    
    init(position: CGPoint, size: CGSize, imageName: String) {
        self.position = position
        self.size = size
        self.imageName = imageName
        self.range = 2
        self.power = 100
        self.mode = .attractive
    }
}
