//
//  GridView.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 7.09.25.
//

import Foundation
import SwiftUICore

struct GridView: View {
    let width: CGFloat
    let height: CGFloat
    let cellSize: CGFloat
    let scale: CGFloat
    
    var body: some View {
        Canvas { context, size in
            // Вертикальные линии
            for x in stride(from: 0, through: width * scale, by: cellSize) {
                let path = Path { path in
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: height * scale))
                }
                context.stroke(path, with: .color(Color.gray.opacity(0.3)), lineWidth: 1)
                context.draw(Text(String(format: "%.0f", x / scale)), at: CGPoint(x: x, y: 8.8 * scale))
            }
            
            // Горизонтальные линии
            for y in stride(from: 0, through: height * scale, by: cellSize) {
                let path = Path { path in
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: width * scale, y: y))
                }
                context.stroke(path, with: .color(Color.gray.opacity(0.3)), lineWidth: 1)
            }
            
            // Жирные линии каждые 5 клеток
            for x in stride(from: 0, through: width * scale, by: cellSize * 5) {
                let path = Path { path in
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: height * scale))
                }
                context.stroke(path, with: .color(Color.gray.opacity(0.5)), lineWidth: 1.5)
                
            }
            
            for y in stride(from: 0, through: height * scale, by: cellSize * 5) {
                let path = Path { path in
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: width * scale, y: y))
                }
                context.stroke(path, with: .color(Color.gray.opacity(0.5)), lineWidth: 1.5)
                
            }
        }
    }
}
