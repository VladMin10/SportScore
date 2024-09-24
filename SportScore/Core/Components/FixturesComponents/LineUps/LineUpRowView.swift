//
//  LineUpRowView.swift
//  SportScore
//
//  Created by Vladyslav Mi on 25.06.2024.
//

import SwiftUI

struct LineUpRowView: View {
    
    let player: Player
    let playerDetail: PlayerDetail
    
    var body: some View {
        HStack {
            if let playerImageURL = playerDetail.playerImage {
                AsyncImage(url: playerImageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .foregroundColor(.gray)
                    @unknown default:
                        ProgressView()
                    }
                }
            } else {
                ProgressView()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }
            
            
            Divider()
                .frame(width: 1, height: 42)
                .background(Color.gray)
                .padding(.horizontal, 3)
            
            VStack(alignment: .leading) {
                HStack {
                    ZStack {
                        Circle()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white) // Set the fill color to white
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: 1) // Add a black stroke around the circle
                            )
                            .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1) // Add a small black shadow
                        Text(player.playerNumber.map { "\($0)" } ?? "N/A")
                            .font(.subheadline)
                            .foregroundColor(.black) // Text color
                    }
                    Text(player.player ?? "N/A")
                        .font(.headline)
                        .lineLimit(1)
                }
            }
        }
    }
}

struct LineUpRowView_Previews: PreviewProvider {
    static var previews: some View {
        LineUpRowView(
            player: Player(player: "Cristiano Ronaldo", playerNumber: 7, playerPosition: 0, playerCountry: "Portugal", playerKey: 103051168, infoTime: nil),
            playerDetail: PlayerDetail(
                playerKey: 103051168,
                playerName: "Cristiano Ronaldo",
                playerNumber: "7",
                playerCountry: "Portugal",
                playerType: "Forwards",
                playerAge: "36",
                playerMatchPlayed: "3",
                playerGoals: "5",
                playerYellowCards: "0",
                playerRedCards: "0",
                playerMinutes: "270",
                playerInjured: "No",
                playerSubstituteOut: "0",
                playerSubstitutesOnBench: "0",
                playerAssists: "1",
                playerIsCaptain: "",
                playerShotsTotal: "",
                playerGoalsConceded: "",
                playerFoulsCommitted: "",
                playerTackles: "",
                playerBlocks: "",
                playerCrossesTotal: "",
                playerInterceptions: "",
                playerClearances: "",
                playerDispossessed: "",
                playerSaves: "",
                playerInsideBoxSaves: "",
                playerDuelsTotal: "",
                playerDuelsWon: "",
                playerDribbleAttempts: "",
                playerDribbleSuccess: "",
                playerPenComm: "",
                playerPenWon: "",
                playerPenScored: "",
                playerPenMissed: "",
                playerPasses: "",
                playerPassesAccuracy: "",
                playerKeyPasses: "",
                playerWoordworks: "",
                playerRating: "",
                teamName: "Portugal",
                teamKey: 23,
                playerImage: URL(string : "https://apiv2.allsportsapi.com/logo/players/52515_cristiano-ronaldo.jpg")))
        }
}
