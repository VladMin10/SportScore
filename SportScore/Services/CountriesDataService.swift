//
//  CountriesDataService.swift
//  SportScore
//
//  Created by Vladyslav Mi on 30.05.2024.
//

import Foundation
import Combine

class CountriesDataService {
    @Published var allCountries: [Country] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getCountries()
    }
    
    func getCountries() {
        let apiKey = "ef772f57f003922ba2a900daf204f8fa3becf5f4a5736eef01cb7fcdbc9d4c54"
        guard let url = URL(string: "https://apiv2.allsportsapi.com/football/?met=Countries&APIkey=\(apiKey)") else { return }
        
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
            .decode(type: [Country].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCountries) in
                self?.allCountries = returnedCountries
            })
            .store(in: &cancellables)
    }
}
