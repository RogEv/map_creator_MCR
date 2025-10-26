//
//  BoxedObstacle.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 25.10.25.
//
import Foundation

struct BoxedObstacle: Obstacle {
    var id: UUID = UUID()
    var position: CGPoint
    var size: CGSize
    var imageName: String
    var angel: Double = 0
    var isKiller: Bool = false
    var code: String {
                    """
                                        LBoxedObject(spriteName: "\(imageName)",
                                                     rect: CGRect(x: \(position.x), y: \(position.y), width: \(size.width), height: \(size.height)),
                                                     mass: 0.5,
                                                     isKiller: \(isKiller),
                    """
    }
    
    init(position: CGPoint, size: CGSize, imageName: String, isKiller: Bool) {
        self.position = position
        self.size = size
        self.imageName = imageName
        self.isKiller = isKiller
    }
}
