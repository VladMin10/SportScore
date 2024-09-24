//
//  SettingsView.swift
//  SportScore
//
//  Created by Vladyslav Mi on 29.05.2024.
//

import SwiftUI

struct SettingsView: View {
    
    let instagramURL = URL(string : "https://www.instagram.com/vlad_mi10")!
    let telegramURL = URL(string : "https://t.me/whatissloveee")!
    let coinGeckoURL = URL(string : "https://www.coingecko.com")!
    let defaultURL = URL(string : "https://www.google.com")!
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.theme.background
                    .ignoresSafeArea()
                List {
                    bioSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    allSportsSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    applicationSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                }
            }
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}

extension SettingsView{
    private var bioSection : some View {
        Section(header: Text("VLADYSLAV MINIAILO")) {
            VStack(alignment : .leading) {
                Image("logo")
                    .resizable()
                    .frame(width : 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius : 20))
                Text("This app was made with love for fun and studying SWIFT and SWIFT UI.It uses MVVM Architecture, Combine, CoreData.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Subscribe on Instagram 📷", destination: instagramURL)
            Link("DM me on Telegram 🛩️", destination: telegramURL)
        }
    }
    private var allSportsSection : some View {
        Section(header: Text("ALL SPORTS API")) {
            VStack(alignment : .leading) {
                Image("allsports")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius : 20))
                Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko. Prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Subscribe on Instagram 📷", destination: instagramURL)
            Link("DM me on Telegram 🛩️", destination: telegramURL)
        }
    }
    private var applicationSection : some View{
        Section(header: Text("Application")) {
            Link("Terms of Service", destination: defaultURL)
            Link("Privacy Policy", destination: defaultURL)
            Link("Company Website", destination: defaultURL)
            Link("Learn More", destination: defaultURL)
        }
    }
}
