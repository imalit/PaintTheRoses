//
//  MockGridViewModel.swift
//  PaintTheRoses
//
//  Created by Isiah Marie Ramos Malit on 2023-01-25.
//

import Foundation
import SwiftUI

class MockGridViewModel: GridViewModel {
    @Published var grid: [Detail]?
    var tappedGridPoint: ((GridPoint) -> ())?
    var markedTiles: [GridPoint : TileState] = [:]
    var isTileTapped: Bool = false
    
    func tileTapped(x: Int, y: Int, z: Int) {
        
    }
    
    func didTapStateOnTile(state: TileState) {
        
    }
    
    func displayState(x: Int, y: Int, z: Int) -> Color {
        return .gray
    }
    
    func borderColor(x: Int, y: Int, z: Int) -> Color {
        return .black
    }
}

struct MockPlayers: PlayersProtocol {
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

