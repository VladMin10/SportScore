//
//  TeamDetailView.swift
//  SportScore
//
//  Created by Vladyslav Mi on 25.06.2024.
//

import SwiftUI

struct TeamDetailView: View {
    @StateObject var teamDataService = TeamDataService()
    let teamId: Int
    
    var body: some View {
        Group {
            if teamDataService.isLoading {
                ProgressView("Loading...")
            } else {
                VStack(alignment: .leading, spacing: 10) {
                    if let team = teamDataService.team {
                        AsyncImage(url: URL(string: team.teamLogo)) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                        } placeholder: {
                            ProgressView()
                                .frame(width: 100, height: 100)
                        }
                        
                        Text("Team: \(team.teamName)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        if let coach = team.coaches.first {
                            Text("Coach: \(coach.coachName)")
                                .font(.headline)
                                .padding(.top, 10)
                        }
                        
                        Text("Players")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                        
                        ScrollView {
                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(team.players) { player in
                                    HStack {
                                        AsyncImage(url: URL(string: player.playerImage)) { image in
                                            image.resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                                .clipShape(Circle())
                                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                        } placeholder: {
                                            ProgressView()
                                                .frame(width: 50, height: 50)
                                        }
                                        
                                        VStack(alignment: .leading) {
                                            Text(player.playerName)
                                                .font(.headline)
                                            Text("Position: \(player.playerType)")
                                                .font(.subheadline)
//                                            Text("Number: \(player.playerNumber)")
//                                                .font(.subheadline)
                                        }
                                    }
                                    .padding(.vertical, 5)
                                }
                            }
                        }
                    } else {
                        Text("No team data available")
                            .font(.headline)
                            .padding()
                    }
                }
                .padding()
            }
        }
        .onAppear {
            teamDataService.fetchTeam(teamId: teamId)
        }
    }
}


#Preview {
    TeamDetailView(teamId : 96)
}
