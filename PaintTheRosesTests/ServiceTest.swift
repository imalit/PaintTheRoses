//
//  ServiceTest.swift
//  PaintTheRoses
//
//  Created by Isiah Marie Ramos Malit on 2023-01-26.
//

import XCTest
import Combine

final class ServiceTest: XCTestCase {
    
    var game: Game?
    var cancellable: AnyCancellable?

    override func setUpWithError() throws {
        cancellable = MockService().fetchData()
            .sink(receiveCompletion: { _ in }, receiveValue: {
                self.game = $0
            }
        )
    }

    override func tearDownWithError() throws {
        game = nil
    }

    func testAttributes() throws {
        let easy = game?.mode?.easy[0].attributes
        let medium = game?.mode?.medium[1].attributes
        let hard = game?.mode?.hard[0].attributes
        
        XCTAssertEqual(easy, ["red", "pink", "yellow", "violet"])
        XCTAssertEqual(medium, ["spades", "clover", "diamond", "hearts"])
        XCTAssertEqual(hard, ["red", "pink", "yellow", "violet", "spades", "clover", "diamond", "hearts"])
    }
}

class MockService: Service {
    let jsonString = """
    {
        "mode": {
            "easy": [{
                "attributes": ["red", "pink", "yellow", "violet"],
                "id":1
            }],
            "medium": [{
                "attributes": ["red", "pink", "yellow", "violet"],
                "id":1
            }, {
                "attributes": ["spades", "clover", "diamond", "hearts"],
                "id":2
            }],
            "hard": [{
                "attributes": ["red", "pink", "yellow", "violet", "spades", "clover", "diamond", "hearts"],
                "id":1
            }]
        }
    }
    """
    
    func fetchData() -> AnyPublisher<Game, Error> {
        do {
            let jsonData = Data(jsonString.utf8)
            let game = try JSONDecoder().decode(Game.self, from: jsonData)
            return Just(game)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Just(Game(mode: nil))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
