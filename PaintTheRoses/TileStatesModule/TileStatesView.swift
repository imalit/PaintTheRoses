//
//  TileStatesView.swift
//  PaintTheRoses
//
//  Created by Isiah Marie Ramos Malit on 2023-01-19.
//

import SwiftUI

struct TileStatesView<ViewModel>: View where ViewModel: TileStatesViewModel {
    
    @ObservedObject var tileStatesVM: ViewModel
    
    var body: some View {
        HStack {
            ForEach(TileState.allCases, id:\.hashValue) { tileState in
                Button(action: {
                    tileStatesVM.buttonTapped(state: tileState)
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Constants.mintGreen)
                        RoundedRectangle(cornerRadius: 5)
                            .strokeBorder(.gray, lineWidth: 1)
                        Text("\(tileState.rawValue)").foregroundColor(.black)
                    }
                }
                .padding([.leading, .trailing])
                .frame(height:40)
            }
        }
    }
}

struct TileStatesView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = TileStatesViewModelImp()
        TileStatesView(tileStatesVM: vm)
            .previewLayout(.sizeThatFits)
    }
}
