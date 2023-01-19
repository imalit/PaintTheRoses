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
        ScrollView {
            if let gridList = gridVM.grid {
                VStack {
                    let enumeratedGrid = Array(gridList.enumerated())
                    ForEach(enumeratedGrid, id:\.offset) { gridNum, grid in
                        let attributes = grid.attributes
                        let reversed = Array(attributes.reversed())
                        
                        VStack (alignment: .leading) {
                            HStack {
                                ForEach(reversed.indices, id: \.self) { x in
                                    Text("\(reversed[x])")
                                        .frame(width: 35)
                                        .foregroundColor(.black)
                                }
                            }
                            .padding([.leading])
                            
                            ForEach(reversed.indices, id: \.self) { x in
                                HStack {
                                    Text("\(attributes[x])")
                                    ForEach(0..<attributes.count-x, id: \.self) { y in
                                        Button(action: {
                                            gridVM.tileTapped(x: x, y: y, z: gridNum)
                                        }) {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .foregroundColor(.gray)
                                                Text("\(reversed[y])\(attributes[x])")
                                                    .foregroundColor(.black)
                                            }
                                        }.frame(width: 35, height: 35)
                                    }
                                }
                            }
                        }
                    }.padding()
                }
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        let gridVM = GridViewModelImp(grid: [])
        GridView(gridVM: gridVM)
    }
}
