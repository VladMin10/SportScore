//
//  LeaguesModel.swift
//  SportScore
//
//  Created by Vladyslav Mi on 03.06.2024.
//

import Foundation

struct League: Hashable, Decodable, Identifiable {
    let leagueKey: Int
    let leagueName: String
    let countryKey: Int
    let countryName: String?
    let leagueLogo: URL?
    
    var id: Int { leagueKey }

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryKey = "country_key"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

    static func == (lhs: League, rhs: League) -> Bool {
            lhs.id == rhs.id
        }
}
