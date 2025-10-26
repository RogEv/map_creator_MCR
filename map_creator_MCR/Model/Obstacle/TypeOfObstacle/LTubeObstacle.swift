//
//  LTubeObstacle.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 25.10.25.
//
import Foundation

struct LTubeObstacle: Obstacle, Codable {
    var id: UUID = UUID()
    var position: CGPoint
    var size: CGSize
    var imageName: String
    var angel: Double = 0
    var type: TubeType
    var code: String {
        "LTube(id: \(type.rawValue), x: \(position.x)),"
    }
    
    enum TubeType: Int, CaseIterable, Codable, Hashable {
        case small = 0
        case big = 1
    }
    
    init(position: CGPoint, size: CGSize, type: TubeType) {
        self.position = position
        self.size = size
        self.imageName = ""
        self.type = type
    }
    
}
