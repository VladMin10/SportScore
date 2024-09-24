//
//  TeamsDataService.swift
//  SportScore
//
//  Created by Vladyslav Mi on 25.06.2024.
//

import Foundation
import Combine

class TeamDataService: ObservableObject {
    @Published var team: Team?
    @Published var isLoading: Bool = false
    var cancellables = Set<AnyCancellable>()
    
    func fetchTeam(teamId: Int) {
        isLoading = true
        let apiKey = "ef772f57f003922ba2a900daf204f8fa3becf5f4a5736eef01cb7fcdbc9d4c54"
        
        guard let url = URL(string: "https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=\(teamId)&APIkey=\(apiKey)") else {
            isLoading = false
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: TeamResponse.self, decoder: JSONDecoder())
            .map { $0.result.first }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] team in
                self?.team = team
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
}
