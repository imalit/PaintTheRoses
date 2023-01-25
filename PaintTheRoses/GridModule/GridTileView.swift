//
//  GridTileView.swift
//  PaintTheRoses
//
//  Created by Isiah Marie Ramos Malit on 2023-01-25.
//

import SwiftUI

struct GridTile<ViewModel>: View where ViewModel: GridViewModel {
    
    @ObservedObject var gridVM: ViewModel
    
    let x: Int
    let y: Int
    let z: Int
    let size: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(gridVM.displayState(x: x, y: y, z: z))
                .onTapGesture {
                    gridVM.tileTapped(x: x, y: y, z: z)
                    gridVM.isTileTapped = true
                }
            Rectangle()
                .strokeBorder(
                    gridVM.borderColor(x: x, y: y, z: z),
                    lineWidth: 1
                )
        }.frame(
            width: size,
            height: size
        )
    }
}

//struct GridTileView_Previews: PreviewProvider {
//    static var previews: some View {
//        GridTile()
//    }
//}