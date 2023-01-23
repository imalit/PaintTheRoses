//
//  GridView.swift
//  PaintTheRoses
//
//  Created by Isiah Marie Ramos Malit on 2023-01-19.
//

import SwiftUI

struct GridView<ViewModel>: View where ViewModel: GridViewModel {
    
    @ObservedObject var gridVM: ViewModel
    
    var body: some View {
        if let gridList = gridVM.grid {
            let gridCount = gridList.count
            GeometryReader { geometry in
                VStack {
                    let enumeratedGrid = Array(gridList.enumerated())
                    ForEach(enumeratedGrid, id:\.offset) { gridNum, grid in
                        let attributes = grid.attributes
                        let reversed = Array(attributes.reversed())
                        let attributeCount = CGFloat(attributes.count*gridCount) + 2
                        let size = geometry.size.width/attributeCount
                        
                        VStack (alignment: .leading) {
                            HStack {
                                ForEach(reversed.indices, id: \.self) { x in
                                    Image("\(reversed[x])")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(
                                            width: size,
                                            height: size
                                        )
                                }
                            }.padding([.leading], size+2)
                            
                            
                            ForEach(reversed.indices, id: \.self) { x in
                                HStack {
                                    Image("\(attributes[x])")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(
                                            width: size,
                                            height: size
                                        )

                                    ForEach(0..<attributes.count-x, id: \.self) { y in
                                        ZStack {
                                            Rectangle()
                                                .fill(gridVM.displayState(x: x, y: y, z: gridNum))
                                                .onTapGesture {
                                                    gridVM.tileTapped(x: x, y: y, z: gridNum)
                                                }
                                            Rectangle()
                                                .strokeBorder(.gray , lineWidth: 1)
                                        }.frame(
                                            width: size,
                                            height: size
                                        )
                                    }
                                }
                                    .aspectRatio(1, contentMode: .fit)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        let gridVM = GridViewModelImp(grid: [], selections: [:])
        GridView(gridVM: gridVM)
    }
}
