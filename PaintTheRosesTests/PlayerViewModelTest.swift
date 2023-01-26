//
//  PlayerViewModelTest.swift
//  PaintTheRosesTests
//
//  Created by Isiah Marie Ramos Malit on 2023-01-26.
//

import XCTest
import Combine

final class PlayerViewModelTest: XCTestCase {
    
    var newPlayerVM: PlayerViewModelImp?
    
    override func setUpWithError() throws {
        newPlayerVM = PlayerViewModelImp(id: UUID())
    }

    override func tearDownWithError() throws {

    }
    
    func testLoadData() {
        XCTAssert(newPlayerVM?.gameObject.mode == nil)
        newPlayerVM?.loadData(service: MockService())
        XCTAssert(newPlayerVM?.gameObject.mode != nil)
    }

    func testNewPlayerDetails() throws {
        newPlayerVM?.loadData(service: MockService())
        XCTAssertEqual(newPlayerVM?.name, "")
        switch newPlayerVM?.difficultyMode {
        case .easy:
            XCTAssert(true)
        default:
            XCTAssert(false)
        }
    }

    func testGetGrid() {
        newPlayerVM?.loadData(service: MockService())
        let grid = newPlayerVM?.displayGrid()
        
        XCTAssertTrue(grid?[0].attributes == ["red", "pink", "yellow", "violet"])
    }
    
    func testSendPlayerDetails() {
        newPlayerVM?.setPlayerDetails = { player in
            MockPlayers.updatePlayers(player: player)
        }
        
        newPlayerVM?.sendPlayerDetails()
        
        XCTAssertEqual(MockPlayers.players.first?.name, "")
        XCTAssertEqual(MockPlayers.players.first?.selections, [:])
        
        switch MockPlayers.players.first?.gameMode {
        case .easy:
            XCTAssert(true)
        default:
            XCTAssert(false)
        }
    }
}
