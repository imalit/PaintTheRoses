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
    static let red = Color(
        uiColor: UIColor(red: 219/256, green: 31/256, blue: 54/256, alpha: 1)
    )
    
    static let yellow = Color(
        uiColor: UIColor(red: 252/256, green: 242/256, blue: 168/256, alpha: 1)
    )
    
    static let green = Color(
        uiColor: UIColor(red: 78/256, green: 153/256, blue: 58/256, alpha: 1)
    )
    
    static let pink = Color(
        uiColor: UIColor(red: 253/256, green: 209/256, blue: 223/256, alpha: 1)
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

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}
