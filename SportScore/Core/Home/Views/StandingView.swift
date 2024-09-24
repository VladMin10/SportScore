//
//  StandingsView.swift
//  SportScore
//
//  Created by Vladyslav Mi on 04.06.2024.
//
import SwiftUI

struct StandingView: View {
    @StateObject var standingsDataService = StandingsDataService()
    var leagueId: Int

    var body: some View {
        VStack(spacing: 0) {
            if standingsDataService.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else {
                List {
                    ForEach(groupedStandings, id: \.self) { group in
                        StandingGroup(group: group)
                    }
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Standings")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            standingsDataService.allStandings.removeAll()
                            standingsDataService.isLoading = false
                        }) {
                            Text("")
                        }
                    }
                }
            }
        }
        .onAppear {
            print("Loading standings for league: \(leagueId)")
            standingsDataService.getStandings(for: leagueId)
        }
    }

    private var groupedStandings: [[Standing]] {
        let grouped = Dictionary(grouping: standingsDataService.allStandings) { $0.leagueRound }
        let sortedGroups = grouped.sorted { $0.key < $1.key }
        
        var result: [[Standing]] = []
        
        for (_, standings) in sortedGroups {
            let sortedStandings = standings.sorted { $0.standingPlace < $1.standingPlace }
            result.append(sortedStandings)
        }
        
        return result
    }
}

struct StandingGroup: View {
    var group: [Standing]

    var body: some View {
        VStack {
            Text("\(group.first?.leagueRound ?? "")")
                .font(.headline)
                .padding(.vertical, 10)
            
            ForEach(group) { standing in
                StandingRow(standing: standing)
                    .padding(.vertical, 5)
            }
        }
    }
}

struct StandingRow: View {
    var standing: Standing

    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(standing.standingPlace == 1 ? Color.green : (standing.standingPlace >= 2 && standing.standingPlace <= 4) ? Color.orange : Color.gray)
                    .frame(width: 20, height: 20)

                Text("\(standing.standingPlace)")
                    .font(.caption)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }

            AsyncImage(url: URL(string: standing.teamLogo)) { image in
                image.resizable()
                    .frame(width: 28, height: 28)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 28, height: 28, alignment: .leading)

            Text(standing.standingTeam)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Text("\(standing.standingP)")
                    .frame(width: 30, alignment: .trailing)
                Text("\(standing.standingGD)")
                    .frame(width: 30, alignment: .trailing)
                Text("\(standing.standingPTS)")
                    .frame(width: 30, alignment: .trailing)
            }
            .font(.system(size: 16))
            .fontWeight(.bold)
            .frame(width: UIScreen.main.bounds.width * 0.3, alignment: .trailing)
        }
    }
}

struct StandingView_Previews: PreviewProvider {
    static var previews: some View {
        StandingView(leagueId: 1)
    }
}

