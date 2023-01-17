//
//  ContentView.swift
//  PaintTheRoses
//
//  Created by Isiah Marie Ramos Malit on 2023-01-16.
//

import SwiftUI

struct ContentView<ViewModel>: View where ViewModel: HomeViewModel {
    
    @StateObject var homeVM: ViewModel
    @State var playerViewDisplayed: Bool = false
    @State var id: UUID?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(homeVM.players) { player in
                    HStack {
                        Text(player.name)
                        Spacer()
                        Text(player.gameMode.rawValue)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        playerViewDisplayed = true
                        id = player.id
                    }
                }
                Button("Add Player") {
                    id = nil
                    playerViewDisplayed = true
                }
            }
            .navigationTitle("Players")
            .toolbar {
                Button("New Game") {
                    homeVM.newGame()
                }
            }
        }
        .sheet(isPresented: $playerViewDisplayed,
        onDismiss: {
            playerViewDisplayed = false
        }, content: {
            let player = homeVM.getPlayer(id: id)
            homeVM.navigateToPlayer(player: player)
        })        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(homeVM: HomeViewModelImp())
    }
}
