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
            VStack() {
                let enumeratedGrid = Array(gridList.enumerated())
                ForEach(enumeratedGrid, id:\.offset) { gridNum, grid in
                    let attributes = grid.attributes
                    let reversed = Array(attributes.reversed())
                    let attributeCount = CGFloat(attributes.count*gridCount) + 2
                    let size = (UIScreen.screenWidth-30)/attributeCount //30 is padding
                    
                    VStack (alignment: .leading) {
                        HStack {
                            ForEach(reversed.indices, id: \.self) { x in
                                ImageTile(imageName: reversed[x], size: size)
                            }
                        }.padding([.leading], size+8)
                        
                        ForEach(reversed.indices, id: \.self) { x in
                            HStack {
                                ImageTile(imageName: attributes[x], size: size)

                                ForEach(0..<attributes.count-x, id: \.self) { y in
                                    GridTile(
                                        gridVM: gridVM,
                                        x: x,
                                        y: y,
                                        z: gridNum,
                                        size: size
                                    )
                                }
                            }
                            .aspectRatio(contentMode: .fit)
                        }
                    }
                }
                .padding()
            }
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight*0.70)
            .background(Constants.mintGreen)
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        let detail = Detail(attributes: ["clover", "yellow"], id: 1)
        let gridVM = GridViewModelImp(grid: [detail], selections: [:])
        GridView(gridVM: gridVM)
            .previewLayout(.sizeThatFits)
    }
}
