//
//  LeaguesDataService.swift
//  SportScore
//
//  Created by Vladyslav Mi on 31.05.2024.
//

import Foundation

import Combine

class LeaguesDataService {
    @Published var allLeagues: [League] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getLeagues()
    }
    
    func getLeagues() {
        
        let apiKey = "ef772f57f003922ba2a900daf204f8fa3becf5f4a5736eef01cb7fcdbc9d4c54"
        guard let url = URL(string: "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=\(apiKey)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        NetworkingManager.download(url: request)
            .tryMap { data in
                guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let result = json["result"] as? [[String: Any]] else {
                    throw URLError(.badServerResponse)
                }
                let jsonData = try JSONSerialization.data(withJSONObject: result)
                return jsonData
            }
            .decode(type: [League].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedLeagues) in
                self?.allLeagues = returnedLeagues
            })
            .store(in: &cancellables)
    }
}
