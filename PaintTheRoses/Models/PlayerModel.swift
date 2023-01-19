//
//  PlayerModel.swift
//  PaintTheRoses
//
//  Created by Isiah Marie Ramos Malit on 2023-01-16.
//

import Foundation

struct GridPoint: Hashable {
    var x: Int
    var y: Int
    var z: Int
    
    static func == (lhs: GridPoint, rhs: GridPoint) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }

   func hash(into hasher: inout Hasher) {
       hasher.combine(x)
       hasher.combine(y)
       hasher.combine(z)
   }
}

struct Player: Identifiable {
    var id: UUID
    var name: String
    var gameMode: GameMode
    var grid: [Detail]? = nil
    var markedTiles: [GridPoint:TileState] = [:]
    
    init(name: String, gameMode: GameMode) {
        self.id = UUID()
        self.name = name
        self.gameMode = gameMode
    }
}
