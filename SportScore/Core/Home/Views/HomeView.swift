//
//  ContentView.swift
//  SportScore
//
//  Created by Vladyslav Mi on 24.05.2024.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var vm: HomeViewModel
    @State private var showSettingsView: Bool = false
    @State private var showSearchBar: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.background.ignoresSafeArea()

                VStack {
                    if showSearchBar {
                        SearchBarView(searchText: $vm.searchText, showSearchBar: $showSearchBar)
                    } else {
                        headerView
                    }
                    contentView
                    FooterView(currentView: $vm.currentView)
                }
                .sheet(isPresented: $showSettingsView, content: {
                    SettingsView()
                })
            }
        }
    }

    private var headerView: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                HeaderButton(iconName: "info")
                    .padding(2)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        showSettingsView.toggle()
                    }
                SportButtonView(sport: "Football")
                    .padding(2)
                    .background(Color.black.opacity(0.001))
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            
            HeaderButton(iconName: "magnifyingglass")
                .padding(8)
                .background(Color.black.opacity(0.001))
                .onTapGesture {
                    withAnimation(.bouncy()) {
                        showSearchBar.toggle()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .background(Color.theme.background)
        //.cornerRadius(10)
       // .shadow(radius: 5)
        .frame(height: 70)
    }

    private var CountriesView: some View {
        VStack {
            if vm.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else {
                List(vm.countries) { country in
                    CountryRowView(country: country)
                        .padding(.vertical, 5)
                }
                .listStyle(PlainListStyle())
                .background(Color.secondary.opacity(0.1))
            }
        }
        .background(Color.primary.opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }

    private var LeaguesView: some View {
        VStack {
            if vm.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else {
                List(vm.leagues) { league in
                    NavigationLink(destination: StandingView(leagueId: league.leagueKey)) {
                        LeagueRowView(league: league)
                            .padding(.vertical, 5)
                    }
                }
                .listStyle(PlainListStyle())
                .background(Color.secondary.opacity(0.1))
            }
        }
        .background(Color.primary.opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }

    @ViewBuilder
    private var contentView: some View {
        switch vm.currentView {
        case .home:
            FixturesView(viewModel: vm)
        case .leagues:
            LeaguesView
        case .favourites:
            CountriesView
        case .news:
            NewsView()
        case .matches:
            FixturesView(viewModel: vm)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            //.preferredColorScheme(.dark)
            .environmentObject(HomeViewModel())
    }
}
