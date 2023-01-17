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
    var numOfGrids: Int { get set }
    var dimOfGrid: [(Int, Int)] { get set }
    var player: Player? { get set }
    var gameObject: Game { get set }
    var name: String { get set }
    var difficultyMode: GameMode { get set }
    var setPlayerDetails: ((String, GameMode)->Void)? { get set }
    func sendPlayerDetails()
    func loadData(service: Service)
}

class PlayerViewModelImp: PlayerViewModel {
    @Published var name: String = ""
    @Published var difficultyMode: GameMode = .easy
    @Published var numOfGrids = 1
    @Published var dimOfGrid: [(Int, Int)] = []
    var setPlayerDetails: ((String, GameMode) -> Void)? = nil
    var gameObject = Game()
    var player: Player?
    private var cancellable: AnyCancellable?
    
    init(player: Player?) {
        if let player {
            self.player = player
            self.name = player.name
            self.difficultyMode = player.gameMode
        }
    }
    
    func sendPlayerDetails() {
        setPlayerDetails?(name, difficultyMode)
    }
    
    func drawGrids() -> some View {
        switch difficultyMode {
        case .easy:
            numOfGrids = 1
        case .medium:
            numOfGrids = 2
        case .hard:
            numOfGrids = 1
            
        }
    }
    
    private func calculateGridDimensions(mode: GameMode) -> [(Int, Int)] {
        guard let GOmode = gameObject.mode else { return [] }
        var combination = GOmode.easy
        let result: [(Int, Int)] = []
        
        switch mode {
        case .easy:
            combination = GOmode.easy
        case .medium:
            combination = GOmode.medium
        case .hard:
            combination = GOmode.hard
        }
        
        for index in (0..<numOfGrids) {
            let singleCombo = combination[index]
            let top = singleCombo.top
            let side = singleCombo.side
            
            
        }
        
    }
    
    func loadData(service: Service) {
        cancellable = service.fetchData()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { game in
                    self.gameObject = game
                    print(self.gameObject)
                }
            )
    }
}
