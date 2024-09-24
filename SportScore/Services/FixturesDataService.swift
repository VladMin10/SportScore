//
//  FixturesDataService.swift
//  SportScore
//
//  Created by Vladyslav Mi on 10.06.2024.
//

import Foundation
import Combine

class FixturesDataService {
    @Published var allFixtures: [Fixture] = []
    var cancellables = Set<AnyCancellable>()

    init() {
        getFixtures()
    }

    func getFixtures() {
        let apiKey = "ef772f57f003922ba2a900daf204f8fa3becf5f4a5736eef01cb7fcdbc9d4c54"
        let todayDate = Date()
        let futureDate = Calendar.current.date(byAdding: .day, value: 14, to: todayDate)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
                
        let todayDateString = dateFormatter.string(from: todayDate)
        let futureDateString = dateFormatter.string(from: futureDate)
                
        guard let url = URL(string: "https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey=\(apiKey)&from=\(todayDateString)&to=\(futureDateString)") else { return }
//timezone=Europe/Kyiv
        
        print("URL: \(url)")
        print("Today : \(todayDateString)")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        NetworkingManager.download(url: request)
                    .tryMap { data -> [Fixture] in
                        print("Received data: \(data)")
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(FixturesResponse.self, from: data)
                        return response.result
                    }
                    .map { fixtures in
                        self.sortFixtures(fixtures)
                    }
                    .sink(receiveCompletion: { completion in
                        if case .failure(let error) = completion {
                            print("Error decoding fixtures: \(error)")
                        }
                    }, receiveValue: { [weak self] returnedFixtures in
                        self?.allFixtures = returnedFixtures
                        print("Decoded fixtures: \(returnedFixtures)")
                    })
                    .store(in: &cancellables)
            }
    private func sortFixtures(_ fixtures: [Fixture]) -> [Fixture] {
            let today = Date()
            let calendar = Calendar.current
            
            let todayFixtures = fixtures.filter {
                guard let dateString = $0.eventDate else { return false }
                guard let date = DateFormatter.fixtureDateFormatter.date(from: dateString) else { return false }
                return calendar.isDate(date, inSameDayAs: today)
            }
            
            let futureFixtures = fixtures.filter {
                guard let dateString = $0.eventDate else { return false }
                guard let date = DateFormatter.fixtureDateFormatter.date(from: dateString) else { return false }
                return date > today
            }
            
            return todayFixtures + futureFixtures
        }
}


struct FixturesResponse: Codable {
    let result: [Fixture]
}
