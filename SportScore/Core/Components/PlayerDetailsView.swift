//
//  PlayerDetailsView.swift
//  SportScore
//
//  Created by Vladyslav Mi on 25.06.2024.
//

//import SwiftUI
//
//struct PlayerDetailsView: View {
//    @StateObject var playerDataService = PlayerDataService()
//    let playerId: Int
//
//    var body: some View {
//        VStack {
//            if playerDataService.isLoading {
//                ProgressView("Loading...")
//            } else {
//                if let player = playerDataService.playerDetails.first {
//                    VStack(alignment: .leading, spacing: 10) {
//                        if let imageUrl = player.playerImage {
//                            AsyncImage(url: imageUrl) { image in
//                                image.resizable()
//                                    .scaledToFit()
//                                    .frame(width: 100, height: 100)
//                                    .clipShape(Circle())
//                                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
//                            } placeholder: {
//                                ProgressView()
//                                    .frame(width: 100, height: 100)
//                            }
//                        }
//                        
//                        Text("Name: \(player.playerName ?? "N/A")")
//                            .font(.headline)
//                        Text("Team: \(player.teamName ?? "N/A")")
//                            .font(.subheadline)
//                        Text("Position: \(player.playerType ?? "N/A")")
//                            .font(.subheadline)
//                        Text("Number: \(player.playerNumber ?? "N/A")")
//                            .font(.subheadline)
//                        Text("Age: \(player.playerAge ?? "N/A")")
//                            .font(.subheadline)
//                        Text("Goals: \(player.playerGoals ?? "N/A")")
//                            .font(.subheadline)
//                        Text("Assists: \(player.playerAssists ?? "N/A")")
//                            .font(.subheadline)
//                        Text("Rating: \(player.playerRating ?? "N/A")")
//                            .font(.subheadline)
//                    }
//                    .padding()
//                } else {
//                    Text("Player details are not available.")
//                }
//            }
//        }
//        .onAppear {
//            playerDataService.fetchPlayer(playerId: playerId)
//        }
//    }
//}
//
//#Preview {
//    PlayerDetailsView(playerId: 41841276)
//}
//
