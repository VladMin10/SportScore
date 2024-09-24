//
//  PlayersDataService.swift
//  SportScore
//
//  Created by Vladyslav Mi on 25.06.2024.
//
import Foundation

class PlayerDataService: ObservableObject {
    @Published var playerDetails: [Int: PlayerDetail] = [:]
    
    func fetchPlayer(from player: Player) -> PlayerDetail? {
        guard let playerKey = player.playerKey else {
            return nil
        }
        return playerDetails[playerKey]
    }
    
    func loadPlayerDetails(for team: TeamLineup) {
        let playerKeys = (team.startingLineups ?? []).map { $0.playerKey } + (team.substitutes ?? []).map { $0.playerKey }
        for playerKey in playerKeys {
            if playerDetails[playerKey ?? 0] == nil {
                fetchPlayerDetail(playerKey: playerKey)
            }
        }
    }
    
    private func fetchPlayerDetail(playerKey: Int?) {
        guard let playerKey = playerKey else { return }
        let urlString = "https://api.example.com/playerDetails?player_key=\(playerKey)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to fetch data")
                return
            }
            
            do {
                let playerDetailResponse = try JSONDecoder().decode(PlayerDetailResponse.self, from: data)
                DispatchQueue.main.async {
                    for detail in playerDetailResponse.result {
                        self.playerDetails[detail.playerKey] = detail
                    }
                }
            } catch {
                print("Failed to decode JSON")
            }
        }.resume()
    }
}
