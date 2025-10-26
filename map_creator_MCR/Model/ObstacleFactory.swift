//
//  ObstacleFactory.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 26.10.25.
//
import Foundation

enum ObstacleFactory {
    static func createObstacle(from objectType: ObstacleObject, position: CGPoint) -> any Obstacle {
        switch objectType {
        case .gasCyls_gas: return
            GGasObstacle(position: position, size: CGSize(width: 1.24, height: 1.24), imageName: "gas_burner", fireHeight: 4)
        case .gasCyls_goGas: return
            GGasObstacle(position: position, size: CGSize(width: 2, height: 2.1), imageName: "go_gas_cyl", fireHeight: 4)
        
        case .ceilingItems_hand: return
            CeilingIObstacle(position: position, size: CGSize(width: 1.5, height: 2), imageName: "hand", isKiller: false)
        case .ceilingItems_lamp: return
            CeilingIObstacle(position: position, size: CGSize(width: 1.5, height: 2), imageName: "lamp_fire", isKiller: false)
        case .ceilingItems_spikes_02: return
            CeilingIObstacle(position: position, size: CGSize(width: 2.3, height: 2.3), imageName: "spikes_02", isKiller: true)
        case .ceilingItems_spikes_01: return
            CeilingIObstacle(position: position, size: CGSize(width: 2.7, height: 2.7), imageName: "spikes_01", isKiller: true)
        case .ceilingItems_go_death_wheel: return
            CeilingIObstacle(position: position, size: CGSize(width: 2.1, height: 2.1), imageName: "go_death_wheel", isKiller: true)
        
        case .lLeatherBall_nailed_leather: return
            PinnedBallsObstacle(position: position, size: CGSize(width: 1, height: 1), imageName: "go_soft_round_1", gas: 1000)
        case .lLeatherBall_go_soft_round_1: return
            PinnedBallsObstacle(position: position, size: CGSize(width: 8, height: 8), imageName: "go_soft_round_2", gas: 1000)
        case .lLeatherBall_go_soft_round_05: return
            PinnedBallsObstacle(position: position, size: CGSize(width: 4, height: 4), imageName: "go_soft_round_3", gas: 1000)
            
        case .distiller_01: return
            LTracedShapeObstacle(position: position, size: CGSize(width: 3.5, height: 6), imageName: "distiller_01", traceImage: "distiller_01_body", isWin: false)
        case .distiller_02: return
            LTracedShapeObstacle(position: position, size: CGSize(width: 3, height: 5.5), imageName: "distiller_02", traceImage: "distiller_02", isWin: false)
        case .clock: return
            LTracedShapeObstacle(position: position, size: CGSize(width: 3, height: 3), imageName: "clock", traceImage: "clock", isWin: false)
            
        case .suitcases_1: return
            LTracedShapeObstacle(position: position, size: CGSize(width: 6, height: 3), imageName: "suitcases_1", traceImage: "suitcases_1_physics", isWin:  false)
        case .top_piping: return
            LTracedShapeObstacle(position: position, size: CGSize(width: 8, height: 2), imageName: "top_piping", traceImage: "top_piping", isWin: false)
        case .go_flask_01: return
            LTracedShapeObstacle(position: position, size: CGSize(width: 3.9, height: 3), imageName: "go_flask_01", traceImage: "go_flask_01_physics_shape", isWin: true )
       
        case .lamp: return
            LampXObstacle(position: position, size: CGSize(width: 1, height: 2), imageName: "lamp")
        
        case .knife_01: return
            BoxedObstacle(position: position, size: CGSize(width: 0.5, height: 2.35), imageName: "knife_01", isKiller: true)
        case .knife_02: return
            BoxedObstacle(position: position, size: CGSize(width: 0.4, height: 2.0), imageName: "knife_02", isKiller: true)
        case .pitcher: return
            BoxedObstacle(position: position, size: CGSize(width: 2.3, height: 3.0), imageName: "pitcher", isKiller: false)
        case .book_01: return
            BoxedObstacle(position: position, size: CGSize(width: 0.6, height: 1.8), imageName: "book_01", isKiller: false)
        case .book_02: return
            BoxedObstacle(position: position, size: CGSize(width: 0.75, height: 2.3), imageName: "book_02", isKiller: false)
        case .book_03: return
            BoxedObstacle(position: position, size: CGSize(width: 0.75, height: 2.3), imageName: "book_03", isKiller: false)
        case .book_05: return
            BoxedObstacle(position: position, size: CGSize(width: 0.65, height: 1.8), imageName: "book_05", isKiller: false)
        case .barbed_wire: return
            BoxedObstacle(position: position, size: CGSize(width: 2.5, height: 1.2), imageName: "barbed_wire", isKiller: true)
        
        case .tube_01_damaged: return
            LTubeObstacle(position: position, size: CGSize(width: 0.3, height: 2), type: .small)
        
        case .bombs: return
            BombObstacle(position: position, size: CGSize(width: 1.5, height: 1.78), imageName: "bomb_on")
        
        case .flask_01_damaged: return
            BreakableObstacle(position: position, size: CGSize(width: 2.1, height: 3.1), imageName: "flask_01", damagedTexture: "flask_01_damaged" )
        
        case .hood: return
            HoodObstacle(position: position, size: CGSize(width: 2.0, height: 1.0), imageName: "hood")
        
        case .topPipes: return
            TopPipeObstacle(position: position, size: CGSize(width: 2.0, height: 3.0), imageName: "pipe_01")
        
        case .el_wires_02: return
            ElectricBoxObstacle(position: position, size: CGSize(width: 2.5, height: 2.0), imageName: "wires_02")
            
        case .lightnings: return
            LightningObstacle(position: position, size: CGSize(width: 0.2, height: 5.0), imageName: "light_05")
        
        case .magnet: return
            MagnetObstacle(position: position, size: CGSize(width: 1, height: 1), imageName: "magnet")
        
        case .lgen_body: return
            LGenObstacle(position: position, size: CGSize(width: 8, height: 6.2), imageName: "lgen_body")
            
        case .h_l_2x1: return
            LabyrinthsObstacle(position: .zero, size: CGSize(width: 2, height: 1), image: "h_l_2x1")
        case .h_r_2x1: return
            LabyrinthsObstacle(position: position, size: CGSize(width: 2, height: 1), image: "h_r_2x1")
        case .h_3x1: return
            LabyrinthsObstacle(position: position, size: CGSize(width: 3, height: 1), image: "h_3x1")
        case .h_2x1: return
            LabyrinthsObstacle(position: position, size: CGSize(width: 2, height: 1), image: "h_2x1")
        case .r_h_5x4: return
            LabyrinthsObstacle(position: position, size: CGSize(width: 5, height: 4), image: "r_h_5x4")
        case .t_b_3x2: return
            LabyrinthsObstacle( position: position, size: CGSize(width: 3, height: 2), image: "t_b_3x2")
        case .t_u_3x2: return
            LabyrinthsObstacle( position: position, size: CGSize(width: 3, height: 2), image: "t_u_3x2")
        case .v_b_1x2: return
            LabyrinthsObstacle( position: position, size: CGSize(width: 1, height: 2), image: "v_b_1x2")
        case .v_t_1x2: return
            LabyrinthsObstacle( position: position, size: CGSize(width: 1, height: 2), image: "v_t_1x2")
        case .x_3x3: return
            LabyrinthsObstacle(position: position, size: CGSize(width: 3, height: 3), image: "x_3x3")
        case .с_l_b_2x2: return
            LabyrinthsObstacle(position: position, size: CGSize(width: 2, height: 2), image: "с_l_b_2x2")
        case .с_l_t_2x2: return
            LabyrinthsObstacle(position: position, size: CGSize(width: 2, height: 2), image: "с_l_t_2x2")
        case .с_r_b_2x2: return
            LabyrinthsObstacle(position: position, size: CGSize(width: 2, height: 2), image: "с_r_b_2x2")
        case .с_r_t_2x2: return
            LabyrinthsObstacle(position: position, size: CGSize(width: 2, height: 2), image: "с_r_t_2x2")
        
        case .toxic_1: return
            ToxicObstacle(position: .zero, size: CGSize(width: 1, height: 2.6), image: "color_toxic_1", type: 1)
        case .toxic_2: return
            ToxicObstacle( position: .zero, size: CGSize(width: 2, height: 2.4), image: "color_toxic_2", type: 2)
        case .toxic_3: return
            ToxicObstacle(position: .zero, size: CGSize(width: 1, height: 3), image: "color_toxic_3", type: 3)
        case .toxic_4: return
            ToxicObstacle( position: .zero, size: CGSize(width: 2, height: 3), image: "color_toxic_4", type: 4)
        case .toxic_5: return
            ToxicObstacle( position: .zero, size: CGSize(width: 2, height: 2), image: "color_toxic_5", type: 5)
            
        default:
            fatalError("Unknown obstacle type:")
        }
    }
}
