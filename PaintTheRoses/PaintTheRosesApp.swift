//
//  PaintTheRosesApp.swift
//  PaintTheRoses
//
//  Created by Isiah Marie Ramos Malit on 2023-01-16.
//

import SwiftUI

@main
struct PaintTheRosesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(homeVM: HomeViewModelImp())
        }
    }
}
