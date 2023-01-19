//
//  TileStateViewModel.swift
//  PaintTheRoses
//
//  Created by Isiah Marie Ramos Malit on 2023-01-19.
//

import Foundation

protocol TileStatesViewModel: ObservableObject {
    var  tappedState: ((TileState) -> Void)? { get set }
    func buttonTapped(state: TileState)
}

class TileStatesViewModelImp: TileStatesViewModel {
    var tappedState: ((TileState) -> Void)? = nil
    
    func buttonTapped(state: TileState) {
        tappedState?(state)
    }
}
