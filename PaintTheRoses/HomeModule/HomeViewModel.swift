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
    func updatePlayer(player: Player)
    func newGame()
    func delete(indexSet: IndexSet)
    
    associatedtype ViewModel: PlayerViewModel
    func navigateToPlayer(id: UUID?) -> PlayerView<ViewModel>
}

class HomeViewModelImp: HomeViewModel {
    @Published var players = [Player]()
    
    func newGame() {
        players = []
        Players.players = []
    }
    
    func navigateToPlayer(id: UUID?) -> PlayerView<some PlayerViewModel> {
        let playerVM = PlayerViewModelImp(id: id)
        playerVM.setPlayerDetails = { [weak self] player in
            self?.updatePlayer(player: player)
        }
        return PlayerView(playerVM: playerVM)
    }
    
    func delete(indexSet: IndexSet) {
        players.remove(atOffsets: indexSet)
        Players.removePlayers(atOffsets: indexSet)
    }
    
    func updatePlayer(player: Player) {
        if let row = self.players.firstIndex(where: {$0.id == player.id}) {
            players[row] = player
        } else {
            players.append(player)
        }
        Players.updatePlayers(player: player)
    }
}
