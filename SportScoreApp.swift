//
//  SportScoreApp.swift
//  SportScore
//
//  Created by Vladyslav Mi on 24.05.2024.
//

import SwiftUI

@main
struct SportScoreApp: App {
    
    @StateObject private var vm = HomeViewModel()
    @State private var showLaunchView: Bool = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                HomeView()
                    .environmentObject(vm)
                    .zIndex(1.0)
                
                if showLaunchView {
                    LaunchView(showLaunchView: $showLaunchView)
                        .transition(.opacity)  // Используйте плавный переход
                        .zIndex(2.0)
                }
            }
        }
    }
}

