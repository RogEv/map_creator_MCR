//
//  Obstacle.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 15.08.25.
//

import Foundation
import SwiftUICore

struct Obstacle: Codable, Identifiable {
    var id = UUID()
    var object: ObstacleObject
    var position: CGPoint
    var size: CGSize
    var type: ObstacleType
    var image: String?
    var angel: Double = 0
    var boundingBox: CGRect {
        return CGRect(
            x: position.x - size.width/2,
            y: position.y - size.height/2,
            width: size.width,
            height: size.height
        )
    }
    func collides(with otherObstacle: Obstacle) -> Bool {
        let box = otherObstacle.boundingBox
        return self.boundingBox.intersects(box)
    }
    func collides(at location: CGPoint, size: CGSize) -> Bool {
        let newObstacleBox = CGRect(
            x: location.x - size.width/2,
            y: location.y - size.height/2,
            width: size.width,
            height: size.height
        )
        return self.boundingBox.intersects(newObstacleBox)
    }
    var code: String {
        
        switch type {
        case .size:
            ""
        case .balls:
            ""
        case .gasCyls:
            """
                                LFireGasCyl(
                                    sprite: "\(image!)",
                                    delay: 2,
                                    gasTime: 2,
                                    restTime: 3,
                                    fireHeight: 4,
                                    spriteFrame: CGRect(x: \(position.x), y: \(position.y), width: \(size.width), height: \(size.height))),
            """
        case .ceilingItems:
            """
                                LCeilingItem(spriteName: "\(image!)",
                                             ropeTexture: "rope",
                                             ropeX: \(position.x),
                                             ropeLength: \(position.y),
                                             itemSize: CGSize(width: \(size.width), height: \(size.height)),
                                             isKiller: \(isKiller())),
            """
        case .pinnedBalls:
            """
                                LLeatherBall(spriteName: "\(image!)",
                                             radius: \(size.width/2),
                                             center: CGPoint(x: \(position.x), y: \(position.y))),
            """
        case .tracedShapes:
            """
                                LTracedShape(spriteName: "\(image!)",
                                             traceImage: "\(object.rawValue)",
                                             topHoleUV: \(object == .go_flask_01 ? ".init(x1: 123 / 391, x2: 240 / 391)" : "nil"),
                                             rect: CGRect(x: \(position.x), y: \(object == .go_flask_01 ? position.y - 1 : position.y), width: \(size.width), height: \(size.height))\(object == .go_flask_01 ? ".en(in: 1.1)" : ""),
                                             zPosition: 18,
                                             winObject: \(object == .go_flask_01),
                                             density: 30),
            """
        case .lampXCoords:
            "\(position.x),"
        case .boxedObjects:
            """
                                LBoxedObject(spriteName: "\(image!)",
                                             rect: CGRect(x: \(position.x), y: \(position.y), width: \(size.width), height: \(size.height)),
                                             mass: 0.5,
                                             isKiller: \(isKiller())),
            """
        case .tubes:
            "LTube(id: \(Int.random(in: 0...1)), x: \(position.x)),"
        case .breakables:
            """
                            LBreakable(rect: CGRect(x: \(position.x), y:\(position.y), width: \(size.width), height: \(size.height)),
                                                    mass: 0.8,
                                                    texture: "flask_01",
                                                    damagedTexture: "flask_01_damaged",
                                                    fragments: ["glass_scratch_01", "glass_scratch_02", "glass_scratch_03", "glass_scratch_01", "glass_scratch_02"],
                                                    fragmentsSize: CGSize(width: 0.8, height: 0.9),
                                                    tolerance: 250),
            """
        case .lGens:
            """
                            LLGen(x: \(position.x), ballVelocity: 1, delay: 2, ballTTL: 5, ballFrequency: 6),
            """
        case .bombs:
            """
                                    LBomb(rect: CGRect(x: \(position.x), y: \(position.y), width: \(size.width), height: \(size.height)), power: 1),
            """
        case .topPipes:
            """
                                LTopPipe(
                                    x: \(position.x),
                                    blowsFor: 2,
                                    delay: 2,
                                    rest: 2,
                                    force: 200),
            """
        case .electricBoxes:
            """
                            LElectricBox(x: \(position.x),
                                position: \(position.y < 1 ? ".top" : ".bottom"),
                                worksFor: 30,
                                delay: 1,
                                rest: 1),
            """
        case .hood:
            """
                            LHood(x: \(position.x), height: 5, power: 100),
            """
        case .lightnings:
            """
                            LLightning(x: \(position.x),
                                worksFor: 3,
                                delay: 1,
                                rest: 2),
            """
        case .magnets:
            """
                            LMagnet(
                                position: CGPoint(x: \(position.x), y: \(position.y)),
                                range: 3,
                                power: 150,
                                mode: .attractive),                    
            """
            
        case .labyrinths:
                        """
                                            .init(type: .\(object), position: CGPoint(x: \(position.x), y: \(position.y)), mufted: true),
                        """
        case .toxics:
            """
                                LToxic(bottomCenter: CGPoint(x: \(position.x), y: \(position.y + size.height)), type: \(typeToxicAsSting(typeToxic: object)), color: \(Int.random(in: 1...5)), mass: 0.8, tolerance: 150, smokeTTL: 6, scale: .init(dx: 4, dy: 2)),
            """
            
        }
    }
    
    init(object: ObstacleObject, position: CGPoint, size: CGSize, type: ObstacleType, image: String? = nil) {
        self.object = object
        self.position = position.rounded(decimals: 1)
        self.size = size
        self.type = type
        self.image = image
        
    }
    private func typeToxicAsSting(typeToxic: ObstacleObject) -> String {
        switch typeToxic {
        case .toxic_1:
            return "1"
        case .toxic_2:
            return "2"
        case .toxic_3:
            return "3"
        case .toxic_4:
            return "4"
        case .toxic_5:
            return "5"
        default:
            return "1"
        }
    }
    
    private func isKiller() -> Bool {
        return object == .barbed_wire || object == .knife_01 || object == .knife_02 || object == .ceilingItems_go_death_wheel || object == .ceilingItems_spikes_01 || object == .ceilingItems_spikes_02
    }
    
    enum ObstacleType: String, CaseIterable, Codable {
        case size
        case balls
        case gasCyls
        case ceilingItems
        case pinnedBalls
        case tracedShapes
        case lampXCoords
        case boxedObjects
        case tubes
        case breakables
        case lGens
        case bombs
        case topPipes
        case electricBoxes
        case hood
        case lightnings
        case magnets
        case labyrinths
        case toxics
    }
    
    enum ObstacleObject: String, CaseIterable, Codable {
        case gasCyls_gas = "gas_burner"
        case gasCyls_goGas = "go_gas_cyl"
        case ceilingItems_hand = "hand"
        case ceilingItems_lamp = "lamp"
        case ceilingItems_spikes_01 = "spikes_01"
        case ceilingItems_spikes_02 = "spikes_02"
        case ceilingItems_go_death_wheel = "go_death_wheel"
        case lLeatherBall_nailed_leather = "nailed_leather"
        case lLeatherBall_go_soft_round_1 = "go_soft_round_1"
        case lLeatherBall_go_soft_round_05 = "go_soft_round_3"
        case clock = "clock"
        case distiller_01 = "distiller_01_body"
        case distiller_02 = "distiller_02"
        case suitcases_1 = "suitcases_1_physics"
        case top_piping = "top_piping"
        case go_flask_01 = "go_flask_01_physics_shape"
        case lamp = "lamp_lamp_on"
        case knife_01 = "knife_01"
        case knife_02 = "knife_02"
        case book_01 = "book_01"
        case book_02 = "book_02"
        case book_03 = "book_03"
        case book_05 = "book_05"
        case barbed_wire = "barbed_wire"
        case tube_01_damaged = "tube_01"
        case bombs = "bomb_on"
        case flask_01_damaged = "flask_01"
        case pitcher = "pitcher"
        case el_wires_02 = "el_wires_02"
        case hood = "hood"
        case topPipes = "pipe_01"
        case lightnings = "lightning"
        case magnet = "magnet"
        case lgen_body = "lgen_body"
        
        case h_l_2x1 = "horinzontal_narrow_left_2x1"
        case h_r_2x1 = "horinzontal_narrow_right_2x1"
        case h_3x1 = "horinzontal_3x1"
        case h_2x1 = "horinzontal_2x1"
        case r_h_5x4 = "raund_horinzontal_5x4"
        case t_b_3x2 = "T_botton_3x2"
        case t_u_3x2 = "T_down_3x2"
        case v_b_1x2 = "vertical_narrow_up_1x2"
        case v_t_1x2 = "vertical_narrow_down_1x2"
        case x_3x3 = "cross_3x3"
        case с_r_t_2x2 = "L_right_top_2x2"
        case с_l_t_2x2 = "L_left_top_2x2"
        case с_r_b_2x2 = "L_right_bottom_2x2"
        case с_l_b_2x2 = "L_left_bottom_2x2"
        
        case toxic_1 = "toxic_1"
        case toxic_2 = "toxic_2"
        case toxic_3 = "toxic_3"
        case toxic_4 = "toxic_4"
        case toxic_5 = "toxic_5"
        
        var obstacle: Obstacle {
            switch self {
            case .gasCyls_gas: return
                Obstacle(
                    object: .gasCyls_gas, position: .zero, size: CGSize(width: 1.24, height: 1.24), type: .gasCyls, image: "gas_burner")
            case .gasCyls_goGas: return
                Obstacle(
                    object: .gasCyls_goGas, position: .zero, size: CGSize(width: 2, height: 2.1), type: .gasCyls, image: "go_gas_cyl")
            case .ceilingItems_hand: return
                Obstacle(
                    object: .ceilingItems_hand, position: .zero, size: CGSize(width: 1.5, height: 2), type: .ceilingItems, image: "hand")
            case .ceilingItems_lamp: return
                Obstacle(
                    object: .ceilingItems_lamp, position: .zero, size: CGSize(width: 1.5, height: 2), type: .ceilingItems, image: "lamp_fire")
            case .ceilingItems_spikes_02: return
                Obstacle(
                    object: .ceilingItems_spikes_02, position: .zero, size: CGSize(width: 2.3, height: 2.3), type: .ceilingItems, image: "spikes_02")
            case .ceilingItems_spikes_01: return
                Obstacle(
                    object: .ceilingItems_spikes_01, position: .zero, size: CGSize(width: 2.7, height: 2.7), type: .ceilingItems, image: "spikes_01")
            case .ceilingItems_go_death_wheel: return
                Obstacle(
                    object: .ceilingItems_go_death_wheel, position: .zero, size: CGSize(width: 2.1, height: 2.1), type: .ceilingItems, image: "go_death_wheel")
            case .lLeatherBall_nailed_leather: return
                Obstacle(
                    object: .lLeatherBall_nailed_leather, position: .zero, size: CGSize(width: 1, height: 1), type: .pinnedBalls, image: "go_soft_round_1")
            case .lLeatherBall_go_soft_round_1: return
                Obstacle(
                    object: .lLeatherBall_go_soft_round_1, position: .zero, size: CGSize(width: 8, height: 8), type: .pinnedBalls, image: "go_soft_round_1")
            case .lLeatherBall_go_soft_round_05: return
                Obstacle(
                    object: .lLeatherBall_go_soft_round_05, position: .zero, size: CGSize(width: 4, height: 4), type: .pinnedBalls, image: "go_soft_round_3")
                
            case .distiller_01: return
                Obstacle(
                    object: .distiller_01, position: .zero, size: CGSize(width: 3.5, height: 6), type: .tracedShapes, image: "distiller_01")
            case .distiller_02: return
                Obstacle(
                    object: .distiller_02, position: .zero, size: CGSize(width: 3, height: 5.5), type: .tracedShapes, image: "distiller_02")
            case .clock: return
                Obstacle(
                    object: .clock, position: .zero, size: CGSize(width: 3, height: 3), type: .tracedShapes, image: "clock")
                
            case .suitcases_1: return
                Obstacle(
                    object: .suitcases_1, position: .zero, size: CGSize(width: 6, height: 3), type: .tracedShapes, image: "suitcases_1")
            case .top_piping: return
                Obstacle(
                    object: .top_piping, position: .zero, size: CGSize(width: 8, height: 2), type: .tracedShapes, image: "top_piping")
                
            case .go_flask_01: return
                Obstacle(
                    object: .go_flask_01, position: .zero, size: CGSize(width: 3.9, height: 3), type: .tracedShapes, image: "go_flask_01")
            case .lamp: return
                Obstacle(
                    object: .lamp, position: .zero, size: CGSize(width: 1, height: 2), type: .lampXCoords, image: "lamp")
            case .knife_01: return
                Obstacle(
                    object: .knife_01, position: .zero, size: CGSize(width: 0.5, height: 2.35), type: .boxedObjects, image: "knife_01")
            case .knife_02: return
                Obstacle(
                    object: .knife_02, position: .zero, size: CGSize(width: 0.4, height: 2.0), type: .boxedObjects, image: "knife_02")
            case .pitcher: return
                Obstacle(
                    object: .pitcher, position: .zero, size: CGSize(width: 2.3, height: 3.0), type: .boxedObjects, image: "pitcher")
                
            case .book_01: return
                Obstacle(
                    object: .book_01, position: .zero, size: CGSize(width: 0.6, height: 1.8), type: .boxedObjects, image: "book_01")
            case .book_02: return
                Obstacle(
                    object: .book_02, position: .zero, size: CGSize(width: 0.75, height: 2.3), type: .boxedObjects, image: "book_02")
            case .book_03: return
                Obstacle(
                    object: .book_03, position: .zero, size: CGSize(width: 0.75, height: 2.3), type: .boxedObjects, image: "book_03")
            case .book_05: return
                Obstacle(
                    object: .book_05, position: .zero, size: CGSize(width: 0.65, height: 1.8), type: .boxedObjects, image: "book_05")
            case .barbed_wire: return
                Obstacle(
                    object: .barbed_wire, position: .zero, size: CGSize(width: 2.5, height: 1.2), type: .boxedObjects, image: "barbed_wire")
            case .tube_01_damaged: return
                Obstacle(
                    object: .tube_01_damaged, position: .zero, size: CGSize(width: 0.3, height: 2), type: .tubes, image: "tube_01")
            case .bombs: return
                Obstacle(
                    object: .bombs, position: .zero, size: CGSize(width: 1.5, height: 1.78), type: .bombs, image: "bomb_on")
            case .flask_01_damaged: return
                Obstacle(
                    object: .flask_01_damaged, position: .zero, size: CGSize(width: 2.1, height: 3.1), type: .breakables, image: "flask_01")
            case .hood: return
                Obstacle(
                    object: .hood, position: .zero, size: CGSize(width: 2.0, height: 1.0), type: .hood, image: "hood")
            case .topPipes: return
                Obstacle(
                    object: .topPipes, position: .zero, size: CGSize(width: 2.0, height: 3.0), type: .topPipes, image: "pipe_01")
            case .el_wires_02: return
                Obstacle(
                    object: .el_wires_02, position: .zero, size: CGSize(width: 2.5, height: 2.0), type: .electricBoxes, image: "wires_02")
                
            case .lightnings: return
                Obstacle(
                    object: .lightnings, position: .zero, size: CGSize(width: 0.2, height: 5.0), type: .lightnings, image: "light_05")
            case .magnet: return
                Obstacle(
                    object: .magnet, position: .zero, size: CGSize(width: 1, height: 1), type: .magnets, image: "magnet")
            case .lgen_body: return
                Obstacle(
                    object: .lgen_body, position: .zero, size: CGSize(width: 8, height: 6.2), type: .lGens, image: "lgen_body")
                
            case .h_l_2x1: return
                Obstacle(
                    object: .h_l_2x1, position: .zero, size: CGSize(width: 2, height: 1), type: .labyrinths, image: "h_l_2x1")
            case .h_r_2x1: return
                Obstacle(
                    object: .h_r_2x1, position: .zero, size: CGSize(width: 2, height: 1), type: .labyrinths, image: "h_r_2x1")
            case .h_3x1: return
                Obstacle(
                    object: .h_3x1, position: .zero, size: CGSize(width: 3, height: 1), type: .labyrinths, image: "h_3x1")
            case .h_2x1: return
                Obstacle(
                    object: .h_2x1, position: .zero, size: CGSize(width: 2, height: 1), type: .labyrinths, image: "h_2x1")
            case .r_h_5x4: return
                Obstacle(
                    object: .r_h_5x4, position: .zero, size: CGSize(width: 5, height: 4), type: .labyrinths, image: "r_h_5x4")
            case .t_b_3x2: return
                Obstacle(
                    object: .t_b_3x2, position: .zero, size: CGSize(width: 3, height: 2), type: .labyrinths, image: "t_b_3x2")
            case .t_u_3x2: return
                Obstacle(
                    object: .t_u_3x2, position: .zero, size: CGSize(width: 3, height: 2), type: .labyrinths, image: "t_u_3x2")
            case .v_b_1x2: return
                Obstacle(
                    object: .v_b_1x2, position: .zero, size: CGSize(width: 1, height: 2), type: .labyrinths, image: "v_b_1x2")
            case .v_t_1x2: return
                Obstacle(
                    object: .v_t_1x2, position: .zero, size: CGSize(width: 1, height: 2), type: .labyrinths, image: "v_t_1x2")
            case .x_3x3: return
                Obstacle(
                    object: .x_3x3, position: .zero, size: CGSize(width: 3, height: 3), type: .labyrinths, image: "x_3x3")
            case .с_l_b_2x2: return
                Obstacle(object: .с_l_b_2x2, position: .zero, size: CGSize(width: 2, height: 2), type: .labyrinths, image: "с_l_b_2x2")
            case .с_l_t_2x2: return
                Obstacle(object: .с_l_t_2x2, position: .zero, size: CGSize(width: 2, height: 2), type: .labyrinths, image: "с_l_t_2x2")
            case .с_r_b_2x2: return
                Obstacle(object: .с_r_b_2x2, position: .zero, size: CGSize(width: 2, height: 2), type: .labyrinths, image: "с_r_b_2x2")
            case .с_r_t_2x2: return
                Obstacle(object: .с_r_t_2x2, position: .zero, size: CGSize(width: 2, height: 2), type: .labyrinths, image: "с_r_t_2x2")
            
            case .toxic_1: return
                Obstacle(
                    object: .toxic_1, position: .zero, size: CGSize(width: 1, height: 2.6), type: .toxics, image: "color_toxic_1")
            case .toxic_2: return
                Obstacle(
                    object: .toxic_2, position: .zero, size: CGSize(width: 2, height: 2.4), type: .toxics, image: "color_toxic_2")
            case .toxic_3: return
                Obstacle(
                    object: .toxic_3, position: .zero, size: CGSize(width: 1, height: 3), type: .toxics, image: "color_toxic_3")
            case .toxic_4: return
                Obstacle(
                    object: .toxic_4, position: .zero, size: CGSize(width: 2, height: 3), type: .toxics, image: "color_toxic_4")
            case .toxic_5: return
                Obstacle(
                    object: .toxic_5, position: .zero, size: CGSize(width: 2, height: 2), type: .toxics, image: "color_toxic_5")
                
            default:
                fatalError("Unknown obstacle type: \(rawValue)")
            }
        }
        
    }
}
