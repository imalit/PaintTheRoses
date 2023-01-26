//
//  GridViewModel.swift
//  PaintTheRoses
//
//  Created by Isiah Marie Ramos Malit on 2023-01-19.
//

import Foundation
import SwiftUI

protocol GridViewModel: ObservableObject {
    var grid: [Detail]? { get set }
    var tappedGridPoint: ((GridPoint) -> ())? { get set }
    var markedTiles: [GridPoint : TileState] { get set }
    var isTileTapped: Bool { get set }
    func tileTapped(x: Int, y:Int, z: Int)
    func didTapStateOnTile(state: TileState)
    func displayState(x: Int, y: Int, z: Int) -> Color
    func borderColor(x: Int, y: Int, z: Int) -> Color
}

class GridViewModelImp: GridViewModel {
    @Published var grid: [Detail]?
    @Published var markedTiles: [GridPoint : TileState] = [:]
    @Published var isTileTapped: Bool = false
    
    var tappedGridPoint: ((GridPoint) -> ())? = nil
    var tappedPoint: GridPoint? = nil
    
    init(grid: [Detail]?, selections: [GridPoint : TileState]) {
        self.grid = grid
        markedTiles = selections
    }
    
    func tileTapped(x: Int, y: Int, z: Int) {
        let point = GridPoint(x: x, y: y, z: z)
        tappedPoint = point
        tappedGridPoint?(point)
    }
    
    func didTapStateOnTile(state: TileState) {
        if let tappedPoint = tappedPoint {
            if state == .empty {
                markedTiles.removeValue(forKey: tappedPoint)
            } else {
                markedTiles[tappedPoint] = state
            }
        }
    }
    
    func displayState(x: Int, y: Int, z: Int) -> Color {
        let point = GridPoint(x: x, y: y, z: z)
        if let state = markedTiles[point] {
            switch state {
            case .no:
                return Constants.red
            case .yes:
                return Constants.green
            case .maybe:
                return Constants.yellow
            default:
                return Constants.mintGreen
            }
        }
        return Constants.mintGreen
    }
    
    func borderColor(x: Int, y: Int, z: Int) -> Color {
        return (tappedPoint == GridPoint(x: x, y: y, z: z) && isTileTapped) ? .black : .gray
    }
}

