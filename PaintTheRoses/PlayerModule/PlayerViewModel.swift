//
//  PlayerViewModel.swift
//  PaintTheRoses
//
//  Created by Isiah Marie Ramos Malit on 2023-01-17.
//

import Foundation
import Combine
import SwiftUI

protocol PlayerViewModel: ObservableObject {
    
    var name: String { get set }
    var difficultyMode: GameMode { get set }
    var gameObject: Game { get set }
    
    var setPlayerDetails: ((Player)->Void)? { get set }
    var player: Player? { get set }
    
    func sendPlayerDetails()
    func loadData(service: Service)
    func displayGrid() -> [Detail]?
}

class PlayerViewModelImp: PlayerViewModel {
    @Published var gameObject = Game()
    @Published var name: String = ""
    @Published var difficultyMode: GameMode = .easy {
        didSet {
            if oldValue != difficultyMode {
                didChangeGrid = true
            }
        }
    }
    
    var setPlayerDetails: ((Player) -> Void)? = nil
    var player: Player?
    
    private var cancellable: AnyCancellable?
    private var grid: [Detail]? = nil
    private var didChangeGrid: Bool = false
    
    init(id: UUID?) {
        if let id = id {
            player = Players.getPlayer(id: id)
            if let player = player {
                self.name = player.name
                self.difficultyMode = player.gameMode
                self.grid = player.grid
            }
        }
    }
    
    func displayGrid() -> [Detail]? {
        if player == nil || didChangeGrid {
            grid = updateGridList()
            return grid
        } else {
            return player?.grid
        }
    }
    
    private func updateGridList() -> [Detail]? {
        var detail: [Detail]? = nil
        
        switch difficultyMode {
        case .easy:
            detail = gameObject.mode?.easy
        case .medium:
            detail = gameObject.mode?.medium
        case .hard:
            detail = gameObject.mode?.hard
        }
        
        player?.grid = detail
        grid = detail
        return detail
    }
    
    func sendPlayerDetails() {
        if var player = player {
            player.name = name
            player.gameMode = difficultyMode
            player.grid = grid
            setPlayerDetails?(player)
        } else {
            var player = Player(name: name, gameMode: difficultyMode)
            player.grid = grid
            setPlayerDetails?(player)
        }
    }

    func loadData(service: Service) {
        cancellable = service.fetchData()
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { game in
                    self.gameObject = game
                }
            )
    }
}