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
            }.padding([.top],50)
            Spacer()
            GridView(
                gridVM: playerVM.getGridViewModel()
            )
            .padding([.top, .bottom], 50)
            .background(Constants.mintGreen)
            Spacer()
            TileStatesView(
                tileStatesVM: playerVM.getTileStatesViewModel()
            )
            .padding([.bottom], 50)
        }
        .onDisappear{
            playerVM.sendPlayerDetails()
        }
        .onAppear {
            playerVM.loadData(service: GameService())
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        let playerVM = PlayerViewModelImp(id: nil)
        PlayerView(playerVM: playerVM)
    }
}
