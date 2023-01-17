//
//  Service.swift
//  PaintTheRoses
//
//  Created by Isiah Marie Ramos Malit on 2023-01-16.
//

import Foundation
import Combine

protocol Service {
    func fetchData() -> AnyPublisher<Game, Error>
}

class GameService: Service {
    func fetchData() -> AnyPublisher<Game, Error> {
        guard let url = URL(string: Constants.url) else {
            return Just(Game(attributes: nil, mode: nil))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: Game.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
