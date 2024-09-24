//
//  LiveModel.swift
//  SportScore
//
//  Created by Vladyslav Mi on 06.06.2024.
//

import Foundation

struct Fixture: Codable, Identifiable {
    let id = UUID()
    let eventKey: Int?
    let eventDate: String?
    let eventTime: String?
    let eventHomeTeam: String?
    let homeTeamKey: Int?
    let eventAwayTeam: String?
    let awayTeamKey: Int?
    let eventHalftimeResult: String?
    let eventFinalResult: String?
    let eventFTResult: String?
    let eventPenaltyResult: String?
    let eventStatus: String?
    let countryName: String?
    let leagueName: String?
    let leagueKey: Int?
    let leagueRound: String?
    let leagueSeason: String?
    let eventLive: String?
    let eventStadium: String?
    let eventReferee: String?
    let homeTeamLogo: URL?
    let awayTeamLogo: URL?
    let eventCountryKey: Int?
    let leagueLogo: URL?
    let countryLogo: URL?
    let eventHomeFormation: String?
    let eventAwayFormation: String?
    let fkStageKey: Int?
    let stageName: String?
    let leagueGroup: String?
    let goalscorers: [GoalScorer]?
    let substitutes: [Substitute]?
    let cards: [Card]?
    let vars: Vars?
    let lineups: Lineups?
    let statistics: [Statistic]?

    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case eventAwayTeam = "event_away_team"
        case awayTeamKey = "away_team_key"
        case eventHalftimeResult = "event_halftime_result"
        case eventFinalResult = "event_final_result"
        case eventFTResult = "event_ft_result"
        case eventPenaltyResult = "event_penalty_result"
        case eventStatus = "event_status"
        case countryName = "country_name"
        case leagueName = "league_name"
        case leagueKey = "league_key"
        case leagueRound = "league_round"
        case leagueSeason = "league_season"
        case eventLive = "event_live"
        case eventStadium = "event_stadium"
        case eventReferee = "event_referee"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
        case eventCountryKey = "event_country_key"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
        case eventHomeFormation = "event_home_formation"
        case eventAwayFormation = "event_away_formation"
        case fkStageKey = "fk_stage_key"
        case stageName = "stage_name"
        case leagueGroup = "league_group"
        case goalscorers
        case substitutes
        case cards
        case vars
        case lineups
        case statistics
    }
}

struct GoalScorer: Codable, Identifiable {
    let id = UUID() // Unique identifier for each instance
    let time: String?
    let homeScorer: String?
    let homeScorerId: String?
    let homeAssist: String?
    let homeAssistId: String?
    let score: String?
    let awayScorer: String?
    let awayScorerId: String?
    let awayAssist: String?
    let awayAssistId: String?
    let info: String?
    let infoTime: String?

    enum CodingKeys: String, CodingKey {
        case time
        case homeScorer = "home_scorer"
        case homeScorerId = "home_scorer_id"
        case homeAssist = "home_assist"
        case homeAssistId = "home_assist_id"
        case score
        case awayScorer = "away_scorer"
        case awayScorerId = "away_scorer_id"
        case awayAssist = "away_assist"
        case awayAssistId = "away_assist_id"
        case info
        case infoTime = "info_time"
    }
}

struct Substitute: Codable, Identifiable {
    let id = UUID() // Unique identifier for each instance
    let time: String?
    let homeScorer: SubstitutePlayer?
    let homeAssist: String?
    let score: String?
    let awayScorer: SubstitutePlayer?

    enum CodingKeys: String, CodingKey {
        case time
        case homeScorer = "home_player"
        case homeAssist = "home_assist"
        case score
        case awayScorer = "away_player"
    }
}

struct SubstitutePlayer: Codable, Identifiable {
    let id = UUID() // Unique identifier for each instance
    let `in`: String?
    let out: String?
    let inId: Int?
    let outId: Int?

    enum CodingKeys: String, CodingKey {
        case `in` = "in"
        case out
        case inId = "in_id"
        case outId = "out_id"
    }
}

struct Card: Codable , Identifiable{
    let id = UUID() // Unique identifier for each instance
    let time: String?
    let homeFault: String?
    let card: String?
    let awayFault: String?
    let info: String?
    let homePlayerId: String?
    let awayPlayerId: String?

    enum CodingKeys: String, CodingKey {
        case time
        case homeFault = "home_fault"
        case card
        case awayFault = "away_fault"
        case info
        case homePlayerId = "home_player_id"
        case awayPlayerId = "away_player_id"
    }
}

struct Vars: Codable {
    let homeTeam: [TeamMember]?
    let awayTeam: [TeamMember]?

    enum CodingKeys: String, CodingKey {
        case homeTeam = "home_team"
        case awayTeam = "away_team"
    }
}

struct TeamMember: Codable {
    let name: String?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
    }
}

struct Lineups: Codable {
    let homeTeam: TeamLineup?
    let awayTeam: TeamLineup?

    enum CodingKeys: String, CodingKey {
        case homeTeam = "home_team"
        case awayTeam = "away_team"
    }
}

struct TeamLineup: Codable {
    let startingLineups: [Player]?
    let substitutes: [Player]?
    let coaches: [Coaches]?
    let missingPlayers: [String]?

    enum CodingKeys: String, CodingKey {
        case startingLineups = "starting_lineups"
        case substitutes
        case coaches
        case missingPlayers = "missing_players"
    }
}

struct Player: Codable, Identifiable {
    let id = UUID()
    let player: String?
    let playerNumber: Int?
    let playerPosition: Int?
    let playerCountry: String?
    let playerKey: Int?
    let infoTime: String?

    enum CodingKeys: String, CodingKey {
        case player
        case playerNumber = "player_number"
        case playerPosition = "player_position"
        case playerCountry = "player_country"
        case playerKey = "player_key"
        case infoTime = "info_time"
    }
}

struct Coaches: Codable {
    let coache: String?
    let coachCountry: String?

    enum CodingKeys: String, CodingKey {
        case coache
        case coachCountry = "coach_country"
    }
}

struct Statistic: Codable, Identifiable {
    let id = UUID()
    let type: String?
    let home: String?
    let away: String?
    
    enum CodingKeys: String, CodingKey {
        case type
        case home
        case away
    }
}
