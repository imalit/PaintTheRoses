//
//  PlayerView.swift
//  PaintTheRoses
//
//  Created by Isiah Marie Ramos Malit on 2023-01-17.
//

import SwiftUI

struct PlayerView<ViewModel: PlayerViewModel>: View {
    
    @ObservedObject var playerVM: ViewModel
    @State var mode: GameMode = .easy
    
    var body: some View {
        GeometryReader { _ in
            VStack {
                HStack {
                    TextField("Enter Player Name", text: $playerVM.name)
                        .padding([.leading])
                        .font(.title)
                    Picker("Mode", selection: $playerVM.difficultyMode) {
                        Text("Easy").tag(GameMode.easy)
                        Text("Medium").tag(GameMode.medium)
                        Text("Hard").tag(GameMode.hard)
                    }
                    .padding([.trailing])
                }.padding([.top],25)
                Spacer()
                GridView(
                    gridVM: playerVM.getGridViewModel()
                )
                Spacer()
                TileStatesView(
                    tileStatesVM: playerVM.getTileStatesViewModel()
                )
                .padding([.bottom], 25)
            }
            .onDisappear{
                playerVM.sendPlayerDetails()
            }
            .onAppear {
                playerVM.loadData(service: GameService())
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        let playerVM = PlayerViewModelImp(id: nil)
        PlayerView(playerVM: playerVM)
            .previewLayout(.sizeThatFits)
    }
}
