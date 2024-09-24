//
//  FixturesView.swift
//  SportScore
//
//  Created by Vladyslav Mi on 10.06.2024.
//
import SwiftUI

struct FixturesView: View {
    @StateObject var viewModel: HomeViewModel
    @State private var isShowingFixtureDetails = false
    @State private var selectedFixture: Fixture?

    var body: some View {
        NavigationView {
            ZStack{
                Color.theme.background.ignoresSafeArea()
                
                List {
                    Section(header: Text("UEFA European Championship - Group Stage")) {
                        ForEach(viewModel.fixturesByLeague["UEFA European Championship - Group Stage"] ?? [], id: \.id) { fixture in
                            FixtureRow(fixture: fixture)
                                .onTapGesture {
                                    selectedFixture = fixture
                                    DispatchQueue.main.async {
                                        isShowingFixtureDetails = true
                                    }
                                }
                        }
                    }
                    Section(header: Text("CONMEBOL Copa America - Group Stage")) {
                        ForEach(viewModel.fixturesByLeague["CONMEBOL Copa America - Group Stage"] ?? [], id: \.id) { fixture in
                            FixtureRow(fixture: fixture)
                                .onTapGesture {
                                    selectedFixture = fixture
                                    DispatchQueue.main.async {
                                        isShowingFixtureDetails = true
                                    }
                                }
                        }
                    }
                    Section(header: Text("Friendlies")) {
                        ForEach(viewModel.fixturesByLeague["Friendlies"] ?? [], id: \.id) { fixture in
                            FixtureRow(fixture: fixture)
                                .onTapGesture {
                                    selectedFixture = fixture
                                    DispatchQueue.main.async {
                                        isShowingFixtureDetails = true
                                    }
                                }
                        }
                    }
                    ForEach(viewModel.fixturesByLeague.keys.sorted().filter { $0 != "UEFA European Championship - Group Stage" && $0 != "CONMEBOL Copa America - Group Stage"  && $0 != "Friendlies" }, id: \.self) { leagueName in
                        Section(header: Text(leagueName)) {
                            ForEach(viewModel.fixturesByLeague[leagueName] ?? [], id: \.id) { fixture in
                                FixtureRow(fixture: fixture)
                                    .onTapGesture {
                                        selectedFixture = fixture
                                        DispatchQueue.main.async {
                                            isShowingFixtureDetails = true
                                        }
                                    }
                            }
                        }
                    }
                }
                .sheet(item: $selectedFixture) { fixture in
                    FixtureDetailsView(fixture: fixture)
                }
            }

        }
        .onAppear {
            viewModel.fixturesDataService.getFixtures()
        }
    }
}
struct FixturesView_Previews: PreviewProvider {
    static var previews: some View {
        FixturesView(viewModel: HomeViewModel())
            .preferredColorScheme(.dark)
    }
}
