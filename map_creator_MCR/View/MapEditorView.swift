//
//  ContentView.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 15.08.25.
//

import SwiftUI

struct MapEditorView: View {
    @State private var showingExportDialog: Bool = false
    @State private var obstaclePrewiew: Obstacle? = nil
    private let scale = Constant.scale
    @StateObject private var mapController = MapController()
    @State private var showingSettings = false
    @State private var selectedObstacleIndex: Int? = nil
    
    
    
    
    var body: some View {
        
        VStack {
            undoToolBar
            contrallToolbar
            
            VStack{
                mapCanvasView
                HStack{
                    obstacleTableView
                    ScrollView {
                        Text("КОД УРОВНЯ")
                        Text(mapController.codeGenerator())
                            .background(Color.black.opacity(0.3))
                        
                    }
                    Spacer()
                    
                }
                Spacer()
            }
            .padding()
        }
    }
    
    var mapCanvasView: some View {
        ScrollView(.horizontal){
            ZStack{
                Rectangle()
                    .fill(Color.white.opacity(0.3))
                    .frame(
                        width: CGFloat(mapController.gameMap.width) * scale,
                        height: CGFloat(mapController.gameMap.height) * scale)
                    .border(Color.black, width: 2)
                
                GridView(
                    width: CGFloat(mapController.gameMap.width),
                    height: CGFloat(mapController.gameMap.height),
                    cellSize: scale, // Размер клетки равен scale
                    scale: scale
                )
                .frame(
                    width: CGFloat(mapController.gameMap.width) * scale,
                    height: CGFloat(mapController.gameMap.height) * scale
                )
                
                ForEach(Array(mapController.gameMap.obstacles.enumerated()), id: \.offset) { index, obstacle in
                    ObstacleView(obstacle: obstacle)
                        .frame(width: obstacle.size.width * scale,
                               height: obstacle.size.height * scale)
                        .position(mapController.positionForObstacle(obstacle))
                }
                
                if let obstacle = obstaclePrewiew {
                    ObstacleView(obstacle: obstacle)
                        .frame(width: obstacle.size.width * scale,
                               height: obstacle.size.height * scale)
                        .position(
                            mapController.positionForObstacle(obstacle)
                        )
                }
                
                Rectangle()
                    .fill(Color.clear)
                    .contentShape(Rectangle())
                    .frame(width: CGFloat(mapController.gameMap.width) * scale,
                           height: CGFloat(mapController.gameMap.height) * scale)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                updateObstaclePreview(at: value.location)
                            }
                            .onEnded{ value in
                                guard let safeObst = obstaclePrewiew else { return }
                                mapController.addObstacle(at: value.location, obstaclePrewiew: safeObst)
                                obstaclePrewiew = nil
                            }
                    )
            }
            .frame(width: CGFloat(mapController.gameMap.width) * scale, height: CGFloat(mapController.gameMap.height) * scale)
        }
    }
    
    var obstacleTableView: some View {
        let obstacles = mapController.gameMap.obstacles
        
        return Table(of: Int.self) {  // Используем индексы как данные
            TableColumn("#") { index in
                Text("\(index + 1)")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .width(20)
            
            TableColumn("Общая информация") { index in
                let obstacle = obstacles[index]
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text("Позиция: \(obstacle.position.x.formatted())×\((9 - obstacle.position.y).formatted())")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Stepper("X", value: Binding(
                            get: { mapController.gameMap.obstacles[index].position.x },
                            set: { mapController.gameMap.obstacles[index].position.x = $0 }
                        ), in: 0...1000, step: 0.1)
                        
                        Stepper("Y", value: Binding(
                            get: { mapController.gameMap.obstacles[index].position.y },
                            set: { mapController.gameMap.obstacles[index].position.y = $0 }
                        ), in: 0...1000, step: 0.1)
                        
                        VStack {
                            Button("Удалить") {
                                mapController.gameMap.obstacles.remove(at: index)
                            }
                            .buttonStyle(.bordered)
                            
                            Button("Настроить") {
                                selectedObstacleIndex = index
                                showingSettings = true
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    
                    HStack {
                        Text("Размер: X:\(obstacle.size.width.formatted())× Y:\(obstacle.size.height.formatted())")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        } rows: {
            // Передаем индексы как rows
            ForEach(obstacles.indices, id: \.self) { index in
                TableRow(index)
            }
        }
        .sheet(isPresented: $showingSettings) {
            if let index = selectedObstacleIndex {
                SettingObstacleView(
                    obstacle: $mapController.gameMap.obstacles[index]
                )
            }
        }
        .frame(width: 350)
    }
    
    // State переменные
    
    
    var contrallToolbar: some View {
        HStack {
            Picker("Тип препятствия", selection: $mapController.selectedObstacleType)
            {
                ForEach(Obstacle.ObstacleObject.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }
            Stepper(
                value: $mapController.gameMap.width,
                in: 20...90,
                step: 1
            ) {
                Text("Ширина карты: \(mapController.gameMap.width)")
            }
            Button("Экспорт кода"){
                mapController.saveTextToFile(mapController.codeGenerator())
                //showingExportDialog = true
            }
            Button("Очистить карту"){
                mapController.gameMap.obstacles.removeAll()
                obstaclePrewiew = nil
            }
        }
    }
    var undoToolBar: some View {
        HStack(spacing: 16) {
            Rectangle()
                .fill(Color.clear)
                .background(
                    Image(mapController.selectedObstacleType.obstacle.image ?? "photo")
                        .resizable()
                        .scaledToFit()
                )
                .frame(width: 50, height: 50)
            
            Button("Отмена последнего", systemImage: "arrow.uturn.backward") {
                mapController.deleteLastObstacle()
            }
            .disabled(mapController.gameMap.obstacles.isEmpty)
            .buttonStyle(.bordered)
            
            Label(
                title: {
                    if let preview = obstaclePrewiew {
                        Text("x: \(preview.position.x, specifier: "%.1f"), y: \(9 - preview.position.y, specifier: "%.1f")")
                    } else {
                        Text("Не выбрано")
                    }
                },
                icon: {
                    Image(systemName: "location.circle.fill")
                }
            )
            .font(.subheadline.monospacedDigit())
        }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(12)
    }
    
    private func updateObstaclePreview(at location: CGPoint) {
        let relativeX = location.x / scale
        var relativeY = (CGFloat(mapController.gameMap.height) * scale - location.y) / scale
        
        // Проверка, что точка внутри карты
        guard relativeX >= 0, relativeX <= CGFloat(mapController.gameMap.width),
              relativeY >= 0, relativeY <= CGFloat(mapController.gameMap.height)
        else {
            obstaclePrewiew = nil
            return }
        
        // Прверка, что нет коллизии
        //        guard mapController.checkCollision(at: CGPoint(x: relativeX, y: relativeY))
        //        else {
        //            obstaclePrewiew = nil
        //            return
        //        }
        obstaclePrewiew = mapController.selectedObstacleType.obstacle
        if relativeY - (obstaclePrewiew?.size.height)! < 0.3 {
            relativeY = (obstaclePrewiew?.size.height)! - 0
        }
        obstaclePrewiew?.position = CGPoint(x: relativeX, y: relativeY).rounded(decimals: 2)
    }
}

extension Int: Identifiable {
    public var id: Int { self }
}
//#Preview {
//    MapEditorView()
//}
