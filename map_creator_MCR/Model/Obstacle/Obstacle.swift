//
//  Obstacle.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 25.10.25.
//

import Foundation

protocol Obstacle: Codable, Identifiable {
    var id: UUID { get }
    var position: CGPoint { get set}
    var size: CGSize { get set }
    var imageName: String { get set }
    var angel: Double { get set }
    var code: String { get }
}

// MARK: - Timing & Animation
protocol TimedObstacle {
    var delay: Double { get set }
    var duration: Double { get set }
    var restTime: Double { get set }
}

protocol CyclicObstacle: TimedObstacle {
    var worksFor: Double { get set }
    var cycleCount: Int? { get set }
}

// MARK: - Physics & Forces
protocol ForceObstacle {
    var power: Double { get set }
}

// MARK: - Special Effects
protocol FireObstacle {
    var fireHeight: Double { get set }
    var gasTime: Double { get set }
}



// MARK: - Magnetic & Field Effects
protocol MagneticObstacle {
    var range: Double { get }
    var power: Double { get }
    var mode: MagnetMode { get }
}

enum MagnetMode {
    case attractive, repilent
}

// MARK: - Structural Elements

protocol TracedShapeObstacle {
    var traceImage: String { get }
}

protocol LabyrinthObstacle {
    var labyrinthType: String { get }
    var mufted: Bool { get }
}
