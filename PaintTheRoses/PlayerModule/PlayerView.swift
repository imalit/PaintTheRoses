//
//  PlayerView.swift
//  PaintTheRoses
//
//  Created by Isiah Marie Ramos Malit on 2023-01-17.
//

import SwiftUI

struct PlayerView<ViewModel>: View where ViewModel: PlayerViewModel {
    
    @ObservedObject var playerVM: ViewModel
    @State var mode: GameMode = .easy
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter Player Name", text: $playerVM.name)
                    .padding([.leading])
                Picker("Mode", selection: $playerVM.difficultyMode) {
                    Text("Easy").tag(GameMode.easy)
                    Text("Medium").tag(GameMode.medium)
                    Text("Hard").tag(GameMode.hard)
                }
                .padding([.trailing])
            }
        }
        .onDisappear{
            playerVM.sendPlayerDetails()
        }
        .onAppear {
            if playerVM.player == nil {
                playerVM.loadData(service: GameService())
                print(playerVM.gameObject)
            }
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        let playerVM = PlayerViewModelImp(player: nil)
        PlayerView(playerVM: playerVM)
    }
}
