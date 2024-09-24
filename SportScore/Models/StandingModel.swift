//
//  StandingModel.swift
//  SportScore
//
//  Created by Vladyslav Mi on 04.06.2024.
//

import Foundation

struct Standing: Decodable, Identifiable, Equatable, Hashable {
    var id: Int { teamKey }  // створюємо id з teamKey
    let standingPlace: Int
    let standingPlaceType: String?
    let standingTeam: String
    let standingP: Int
    let standingW: Int
    let standingD: Int
    let standingL: Int
    let standingF: Int
    let standingA: Int
    let standingGD: Int
    let standingPTS: Int
    let teamKey: Int
    let leagueKey: Int
    let leagueSeason: String
    let leagueRound: String
    let standingUpdated: String
    let fkStageKey: Int
    let stageName: String
    let teamLogo: String

    enum CodingKeys: String, CodingKey {
        case standingPlace = "standing_place"
        case standingPlaceType = "standing_place_type"
        case standingTeam = "standing_team"
        case standingP = "standing_P"
        case standingW = "standing_W"
        case standingD = "standing_D"
        case standingL = "standing_L"
        case standingF = "standing_F"
        case standingA = "standing_A"
        case standingGD = "standing_GD"
        case standingPTS = "standing_PTS"
        case teamKey = "team_key"
        case leagueKey = "league_key"
        case leagueSeason = "league_season"
        case leagueRound = "league_round"
        case standingUpdated = "standing_updated"
        case fkStageKey = "fk_stage_key"
        case stageName = "stage_name"
        case teamLogo = "team_logo"
    }
}

struct ApiResponse: Decodable {
    let success: Int
    let result: Result

    struct Result: Decodable {
        let total: [Standing]
    }
}
