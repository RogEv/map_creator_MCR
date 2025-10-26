//
//  ObstacleView.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 3.09.25.
//

import Foundation
import SwiftUI

struct ObstacleView: View {
    let obstacle : Obstacle
    var body: some View {
        Group {
            Rectangle()
                .fill(Color.clear)
                .background(
                    Image(obstacle.image!)
                        .resizable()
                        .scaledToFit()
                )
                
        }
        .rotationEffect(.degrees(obstacle.angel))
        .overlay(
            RoundedRectangle(cornerRadius: 2)
                .stroke(Color.black, lineWidth: 1)
                .rotationEffect(.degrees(obstacle.angel)))
    }
}
