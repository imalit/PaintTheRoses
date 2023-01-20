//
//  Constants.swift
//  PaintTheRoses
//
//  Created by Isiah Marie Ramos Malit on 2023-01-16.
//

import Foundation
import SwiftUI

enum Constants {
    static let url = "https://imalit.github.io/source/painttheroses.json"
    static let mintGreen = Color(
        uiColor: UIColor(red: 203/256, green: 255/256, blue: 210/256, alpha: 1)
    )
}

struct Players {
    static var players: [Player] = []
    
    static func getPlayer(id: UUID) -> Player? {
        guard let player = players.first(where: {
            $0.id == id
        }) else { return nil }
        return player
    }
    
    static func updatePlayers(player: Player) {
        if let row = players.firstIndex(where: {$0.id == player.id}) {
            players[row] = player
        } else {
            players.append(player)
        }
    }
    
    static func removePlayers(atOffsets: IndexSet) {
        players.remove(atOffsets: atOffsets)
    }
}
