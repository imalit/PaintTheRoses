//
//  GridViewModelTest.swift
//  PaintTheRosesTests
//
//  Created by Isiah Marie Ramos Malit on 2023-01-26.
//

import XCTest

final class GridViewModelTest: XCTestCase {

    var gridVM: GridViewModelImp?
    
    override func setUpWithError() throws {
        let grid = [Detail(attributes: ["red", "pink", "yellow", "violet"], id: 1)]
        let gridPoint = GridPoint(x: 1, y: 1, z: 1)
        let state: TileState = .maybe
        gridVM = GridViewModelImp(grid: grid, selections: [gridPoint: state])
    }

    override func tearDownWithError() throws {
        gridVM = nil
    }
    
    func testTileTapped() throws {
        var savedPoint: GridPoint?
        gridVM?.tappedGridPoint = { point in
            savedPoint = point
        }
        
        gridVM?.tileTapped(x: 0, y: 0, z: 0)
        
        XCTAssertEqual(gridVM?.tappedPoint, savedPoint)
    }
    
    func testDidTapTileOnState() throws {
        let point = GridPoint(x: 1, y: 1, z: 1)
        gridVM?.tappedPoint = point
        gridVM?.markedTiles[point] = .no
        
        XCTAssertEqual(gridVM?.markedTiles[point], .no)
        
        gridVM?.didTapStateOnTile(state: .yes)
        
        if let tappedPoint = gridVM?.tappedPoint {
            XCTAssertEqual(gridVM?.markedTiles[tappedPoint], .yes)
        }
    }
    
    func testDisplayState() throws {
        gridVM?.markedTiles = [
            GridPoint(x: 1, y: 1, z: 1) : .no,
            GridPoint(x: 0, y: 0, z: 1) : .maybe
        ]
        
        XCTAssertEqual(gridVM?.displayState(x: 1, y: 1, z: 1), Constants.red)
    }
    
    func testBorderColor() throws {
        gridVM?.isTileTapped = true
        let point = GridPoint(x: 1, y: 1, z: 1)
        gridVM?.tappedPoint = point
        
        XCTAssertEqual(gridVM?.borderColor(x: 1, y: 1, z: 1), .black)
        XCTAssertEqual(gridVM?.borderColor(x: 1, y: 0, z: 1), .gray)
        
    }
}
