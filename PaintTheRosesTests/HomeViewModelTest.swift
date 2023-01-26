//
//  PaintTheRosesTests.swift
//  PaintTheRosesTests
//
//  Created by Isiah Marie Ramos Malit on 2023-01-26.
//

import XCTest

final class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModelImp?

    override func setUpWithError() throws {
        viewModel = HomeViewModelImp()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testAddPlayer() throws {
        let player = Player(name: "Player1", gameMode: .easy)
        viewModel?.updatePlayer(player: player)
        
        XCTAssertEqual(viewModel?.players.count, 1)
        XCTAssertEqual(viewModel?.players[0].name, "Player1")
    }

    func testUpdatePlayer() throws {
        var player1 = Player(name: "Player1", gameMode: .easy)
        let player2 = Player(name: "Player2", gameMode: .hard)
        viewModel?.updatePlayer(player: player1)
        viewModel?.updatePlayer(player: player2)
        
        XCTAssertEqual(viewModel?.players[0].gameMode, .easy)
        
        player1.gameMode = .medium
        viewModel?.updatePlayer(player: player1)
        
        if let players = viewModel?.players {
            for player in players where player.name == "Player1"{
                XCTAssertEqual(viewModel?.players[0].gameMode, .medium)
                return
            }
        }
    }
    
    func testDeletePlayer() throws {
        let player1 = Player(name: "Player1", gameMode: .easy)
        let player2 = Player(name: "Player2", gameMode: .hard)
        viewModel?.updatePlayer(player: player1)
        viewModel?.updatePlayer(player: player2)
        
        XCTAssertEqual(viewModel?.players.count, 2)
        viewModel?.delete(indexSet: IndexSet(integer: 0)) // removed player1
        XCTAssertEqual(viewModel?.players[0].name, "Player2")
        XCTAssertFalse(viewModel?.players[0].name == "Player1")
    }
    
    func testDeleteAll() throws {
        let player1 = Player(name: "Player1", gameMode: .easy)
        let player2 = Player(name: "Player2", gameMode: .hard)
        viewModel?.updatePlayer(player: player1)
        viewModel?.updatePlayer(player: player2)
        
        XCTAssertEqual(viewModel?.players.count, 2)
        viewModel?.newGame()
        XCTAssertEqual(viewModel?.players.count, 0)
    }
}
