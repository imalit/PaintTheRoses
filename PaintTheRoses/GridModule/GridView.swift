//
//  GridView.swift
//  PaintTheRoses
//
//  Created by Isiah Marie Ramos Malit on 2023-01-19.
//

import SwiftUI

struct GridView<ViewModel>: View where ViewModel: GridViewModel {
    
    @ObservedObject var gridVM: ViewModel
    @State var isPressed = false
    
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

struct ImageTile: View {
    let imageName: String
    let size: CGFloat
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(
                width: size,
                height: size
            )
    }
}

struct GridTile<ViewModel>: View where ViewModel: GridViewModel {
    
    @ObservedObject var gridVM: ViewModel
    @State var isTapped = false
    
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
                }
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            isTapped = true
                        }
                        .onEnded { _ in
                            isTapped = false
                        }
                )
            Rectangle()
                .strokeBorder(
                    isTapped ? .black : .gray,
                    lineWidth: 1
                )
        }.frame(
            width: size,
            height: size
        )
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        let gridVM = GridViewModelImp(grid: [], selections: [:])
        GridView(gridVM: gridVM)
    }
}
