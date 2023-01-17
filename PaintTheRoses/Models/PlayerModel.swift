//
//  PlayerModel.swift
//  PaintTheRoses
//
//  Created by Isiah Marie Ramos Malit on 2023-01-16.
//

import Foundation

struct Player: Identifiable {
    var id: UUID
    var name: String
    var gameMode: GameMode
    
    init(name: String, gameMode: GameMode) {
        self.id = UUID()
        self.name = name
        self.gameMode = gameMode
    }
}
