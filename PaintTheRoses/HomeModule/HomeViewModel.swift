//
//  HomeViewModel.swift
//  PaintTheRoses
//
//  Created by Isiah Marie Ramos Malit on 2023-01-16.
//

import Foundation
import SwiftUI

protocol HomeViewModel: ObservableObject {
    var players: [Player] { get set }
    func newGame()
    func getPlayer(id: UUID?) -> Player?
    
    associatedtype ViewModel: PlayerViewModel
    func navigateToPlayer(player: Player?) -> PlayerView<ViewModel>
}

class HomeViewModelImp: HomeViewModel {
    @Published var players = [Player]()
    
    func addPlayer(name: String, gameMode: GameMode) {
        let player = Player(name: name, gameMode: gameMode)
        players.append(player)
    }
    
    func updatePlayer(player: Player, name: String, gameMode: GameMode) {
        if let row = self.players.firstIndex(where: {$0.id == player.id}) {
            var player = players[row]
            player.name = name
            player.gameMode = gameMode
            players[row] = player
        }
    }
    
    func newGame() {
        players = []
    }
    
    func getPlayer(id: UUID?) -> Player? {
        guard let player = players.first(where: {
            $0.id == id
        }) else { return nil }
        return player
    }
    
    func navigateToPlayer(player: Player?) -> PlayerView<some PlayerViewModel> {
        let playerVM = PlayerViewModelImp(player: player)
        playerVM.setPlayerDetails = { [weak self] name, mode in
            if let player = player {
                self?.updatePlayer(player: player, name: name, gameMode: mode)
            } else {
                self?.addPlayer(name: name, gameMode: mode)
            }
        }
        return PlayerView(playerVM: playerVM)
    }
}
