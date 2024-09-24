//
//  NewsDataService.swift
//  SportScore
//
//  Created by Vladyslav Mi on 22.06.2024.
//
import Foundation
import Combine

class NewsDataService: ObservableObject {
    @Published var allNews: [Article] = []
    @Published var isLoading: Bool = false
    var cancellables = Set<AnyCancellable>()
    
    func getNews() {
        isLoading = true
        
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=gb&category=sports&apiKey=d942b9d43a184f89a2c3d51087b728fa") else {
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
            .decode(type: NewsApiResponse.self, decoder: JSONDecoder())
            .map { $0.articles }
            .catch { error -> Just<[Article]> in
                print("Error fetching news: \(error.localizedDescription)")
                return Just([])
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] returnedNews in
                self?.allNews = returnedNews
                self?.isLoading = false
            })
            .store(in: &cancellables)
        
        print("Fetching news articles")
    }
}
