//
//  SettingObstacleView.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 19.09.25.
//

import SwiftUI

struct SettingObstacleView: View {
    @Binding var obstacle: Obstacle
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Form {
                Stepper("Позиция по X \(obstacle.position.x, specifier: "%.2f")", value: Binding(
                    get: { obstacle.position.x },
                    set: { obstacle.position.x = $0 }
                ), in: 0...1000, step: 0.01)
                Stepper("Позиция по Y \(obstacle.position.y, specifier: "%.2f")", value: Binding(
                    get: { obstacle.position.y },
                    set: { obstacle.position.y = $0 }
                ), in: 0...1000, step: 0.01)
            }
            .padding()
            
            Form {
                Stepper("Ширина: \(obstacle.size.width, specifier: "%.2f")", value: Binding(
                    get: { obstacle.size.width },
                    set: { obstacle.size.width  = $0 }
                ), in: 0...1000, step: 0.1)
                Stepper("Высота \(obstacle.size.height, specifier: "%.2f")", value: Binding(
                    get: { obstacle.size.height},
                    set: { obstacle.size.height = $0 }
                ), in: 0...1000, step: 0.1)
            }
            .padding()
            
            Form {
                Stepper("Угол \(obstacle.angel, specifier: "%.0f")°",
                        value: Binding(
                            get: { obstacle.angel },
                            set: { value in
                                var angle = value.truncatingRemainder(dividingBy: 360)
                                if angle < 0 { angle += 360 }
                                obstacle.angel = angle
                            }
                        ),
                        in: 0...360,
                        step: 90)
            }
            
            HStack {
                Button("OK") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}

//#Preview {
//    @State var  obstacle = Obstacle(
//        object: .gasCyls_gas, position: .zero, size: CGSize(width: 1.24, height: 1.24), type: .gasCyls, image: "gas_burner")
//    SettingObstacleView(obstacle: $obstacle)
//}
