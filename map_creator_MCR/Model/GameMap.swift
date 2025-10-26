//
//  GameMap.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 15.08.25.
//

import Foundation
struct GameMap: Identifiable {
    var id = UUID()
    
    var width: Int
    var height: Int = 9
    var obstacles: [Obstacle]
}
