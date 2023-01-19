//
//  GridViewModel.swift
//  PaintTheRoses
//
//  Created by Isiah Marie Ramos Malit on 2023-01-19.
//

import Foundation

protocol GridViewModel: ObservableObject {
    var grid: [Detail]? { get set }
    var tappedGridPoint: ((GridPoint) -> ())? { get set }
    func tileTapped(x: Int, y:Int, z: Int)
}

class GridViewModelImp: GridViewModel {
    @Published var grid: [Detail]?
    var tappedGridPoint: ((GridPoint) -> ())? = nil
    
    init(grid: [Detail]?) {
        self.grid = grid
    }
    
    func tileTapped(x: Int, y: Int, z: Int) {
        let point = GridPoint(x: x, y: y, z: z)
        tappedGridPoint?(point)
    }
}

