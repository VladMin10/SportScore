//
//  FootballNewsModel.swift
//  SportScore
//
//  Created by Vladyslav Mi on 22.06.2024.
//

import Foundation

struct Article: Decodable, Identifiable {
    var id: UUID = UUID() // Унікальний ідентифікатор для кожної статті
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: URL
    let urlToImage: URL?
    let publishedAt: String
    let content: String?
    
    var formattedPublishedAt: String {
            guard let date = ISO8601DateFormatter().date(from: publishedAt) else {
                return ""
            }
            return date.formattedDate()
    }

    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case content
    }

    struct Source: Decodable {
        let id: String?
        let name: String
    }
}

struct NewsApiResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]

    enum CodingKeys: String, CodingKey {
        case status
        case totalResults = "totalResults"
        case articles
    }
}
