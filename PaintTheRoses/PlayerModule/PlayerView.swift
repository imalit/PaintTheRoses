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
            ScrollView {
                if let gridList = playerVM.displayGrid() {
                    VStack {
                        ForEach(gridList) { grid in
                            VStack (alignment: .leading) {
                                let attributes = grid.attributes
                                ForEach(attributes.indices, id: \.self) { index in
                                    HStack {
                                        ForEach(index..<attributes.count, id: \.self) { item in
                                            Text(" |\(attributes[index]),\(attributes[item])")
                                        }
                                    }
                                }
                            }
                        }.padding()
                    }
                }
            }
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
