//
//  StandingsDataService.swift
//  SportScore
//
//  Created by Vladyslav Mi on 04.06.2024.
//

import Foundation
import Combine

class StandingsDataService: ObservableObject {
    @Published var allStandings: [Standing] = []
    @Published var isLoading: Bool = false
    var cancellables = Set<AnyCancellable>()
    
    //    init() {
    //        getStandings()
    //    }
    
    func getStandings(for leagueId: Int) {
        isLoading = true
        let apiKey = "ef772f57f003922ba2a900daf204f8fa3becf5f4a5736eef01cb7fcdbc9d4c54"
        
        guard let url = URL(string: "https://apiv2.allsportsapi.com/football/?&met=Standings&leagueId=\(leagueId)&APIkey=\(apiKey)") else {
            isLoading = false
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: ApiResponse.self, decoder: JSONDecoder())
            .map { $0.result.total }
            .catch { error -> Just<[Standing]> in
                print("Error fetching standings: \(error.localizedDescription)")
                return Just([])
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] returnedStandings in
                self?.allStandings = returnedStandings
                self?.isLoading = false
            })
            .store(in: &cancellables)
        
        print("Getting standings for league ID:", leagueId)
    }
}
