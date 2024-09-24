//
//  HeadToHeadDataService.swift
//  SportScore
//
//  Created by Vladyslav Mi on 17.06.2024.
//

import Foundation

import Combine

class HeadToHeadDataService: ObservableObject {
    @Published var allHeadToHead: [HeadToHead] = []
    @Published var isLoading: Bool = false
    var cancellables = Set<AnyCancellable>()
    
    func getHeadToHead(homeTeamId: Int, awayTeamId: Int) {
        let apiKey = "ef772f57f003922ba2a900daf204f8fa3becf5f4a5736eef01cb7fcdbc9d4c54"
        isLoading = true
        
        guard let url = URL(string:
        
        "https://apiv2.allsportsapi.com/football/?met=H2H&APIkey=\(apiKey)&firstTeamId=\(homeTeamId)&secondTeamId=\(awayTeamId)") else {
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
            .decode(type: ApiResponseH2H.self, decoder: JSONDecoder())
            .map { $0.result.H2H }
            .catch { error -> Just<[HeadToHead]> in
                print("Error fetching head-to-head data: \(error.localizedDescription)")
                return Just([])
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] returnedHeadToHead in
                self?.allHeadToHead = returnedHeadToHead
                self?.isLoading = false
            })
            .store(in: &cancellables)
        
        print("Getting head-to-head data for home team ID: \(homeTeamId) and away team ID: \(awayTeamId)")
    }
}
