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
