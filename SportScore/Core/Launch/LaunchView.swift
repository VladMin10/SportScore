//
//  LaunchScreen.swift
//  SportScore
//
//  Created by Vladyslav Mi on 26.06.2024.
//


import SwiftUI

struct LaunchView: View {

    @State private var loadingText: [String] = "Loading scores...".map { String($0) }
    @State private var showLoadingText: Bool = false
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var showLaunchView: Bool

    var body: some View {
        ZStack {
            Color.launch.background
                .ignoresSafeArea()

            Image("logo-transparent")
                .resizable()
                .frame(width: 125, height: 125)

            ZStack {
                if showLoadingText {
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices, id: \.self) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(.clear) // Set text color to clear
                                .overlay(
                                      LinearGradient(
                                        gradient: Gradient(colors: [Color.launch.accent, Color.launch.pink]),
                                                      startPoint: .leading,
                                                      endPoint: .trailing)
                                .mask(
                                     Text(loadingText[index])
                                         .font(.headline)
                                         .fontWeight(.heavy)
                                     )
                                )
                                .offset(y: counter == index ? -10 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
                
            }
            .offset(y: 80)
        }
        .onAppear {
            showLoadingText.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                let lastIndex = loadingText.count - 1
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    if loops >= 2 {
                        showLaunchView = false
                    }
                } else {
                    counter += 1
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LaunchView(showLaunchView: .constant(true))
                .navigationBarHidden(true)
        }
    }
}
