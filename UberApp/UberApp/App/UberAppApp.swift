//
//  UberAppApp.swift
//  UberApp
//
//  Created by Сергей Кривошеев on 04.12.2022.
//

import SwiftUI

@main
struct UberAppApp: App {
    @StateObject var viewModel = LocationSearchViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(viewModel)
        }
    }
}
