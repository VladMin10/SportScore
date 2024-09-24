//
//  FixturesRowView.swift
//  SportScore
//
//  Created by Vladyslav Mi on 11.06.2024.
//

import SwiftUI

struct FixtureRow: View {
    let fixture: Fixture

    var body: some View {
        HStack {
            VStack(alignment: .center) {
                Text(fixture.eventTime ?? "")
                    .font(.subheadline)
                HStack {
                    Text(eventStatusText(for: fixture))
                        .font(.subheadline)
                    if fixture.eventLive == "1" {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                    }
                }
            }
            //     .frame(maxWidth: .infinity, alignment: .center)
            
            Divider()
                .frame(width: 1, height: 42)
                .background(Color.gray)
                .padding(.horizontal, 3)
            
            VStack(alignment: .leading) {
                HStack {
                    if let homeTeamLogo = fixture.homeTeamLogo {
                        URLImage(url: homeTeamLogo)
                            .frame(width: 20, height: 20)
                    } else {
                        ProgressView()
                    }
                    Text(fixture.eventHomeTeam ?? "")
                        .font(.headline)
                        .lineLimit(1)
                }
                HStack {
                    if let awayTeamLogo = fixture.awayTeamLogo {
                        URLImage(url: awayTeamLogo)
                            .frame(width: 20, height: 20)
                    } else {
                        ProgressView()
                    }
                    Text(fixture.eventAwayTeam ?? "")
                        .font(.headline)
                        .lineLimit(1)
                }
            }
            Spacer()
            VStack(alignment: .center) {
                Text(fixture.eventFinalResult ?? "-")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(fixture.eventLive == "1" ? Color.red : Color.theme.accent)
            }
        }
    }

    private func eventStatusText(for fixture: Fixture) -> String {
        switch fixture.eventStatus {
        case "PostPoned":
            return "P/P"
        case "Finished":
            return "FT"
        case "Cancelled":
            return "🚫"
        case "Half Time":
            return "HT"
        case "":
            return "-"
        default:
            return fixture.eventStatus ?? "-"
        }
    }
}

struct FixtureRow_Previews: PreviewProvider {
    static var previews: some View {
        FixtureRow(
            fixture: Fixture(
                eventKey: 1,
                eventDate: "2024-06-17",
                eventTime: "19:00",
                eventHomeTeam: "Ukraine",
                homeTeamKey: 101,
                eventAwayTeam: "Romania",
                awayTeamKey: 102,
                eventHalftimeResult: "1-0",
                eventFinalResult: "2-1",
                eventFTResult: "2-1",
                eventPenaltyResult: nil,
                eventStatus: "",
                countryName: "Country",
                leagueName: "Friendlies",
                leagueKey: 201,
                leagueRound: "Round 1",
                leagueSeason: "2024",
                eventLive: "1",
                eventStadium: "Stadium",
                eventReferee: "Referee",
                homeTeamLogo: URL(string: "https://img.freepik.com/free-vector/ukrainian-flag-pattern-vector_53876-162417.jpg?t=st=1718116208~exp=1718116808~hmac=f593188f7dd2d280deb4ecedf061976bb46b890849f758908ab01b9a217cd47a"),
                awayTeamLogo: URL(string: "https://img.freepik.com/free-photo/realistic-romania-flag-background_125540-2767.jpg?t=st=1718116256~exp=1718119856~hmac=032a55e18fe5d997396544343d17e735957dbf4afedd0264058ecf84c562a2e1&w=1800"),
                eventCountryKey: 301,
                leagueLogo: URL(string: "https://example.com/leagueLogo.png"),
                countryLogo: URL(string: "https://example.com/countryLogo.png"),
                eventHomeFormation: "4-4-2",
                eventAwayFormation: "3-5-2",
                fkStageKey: 401,
                stageName: "Stage 1",
                leagueGroup: "Group A",
                goalscorers: [
                    GoalScorer(
                        time: "45'",
                        homeScorer: "Home Player 1",
                        homeScorerId: "1",
                        homeAssist: "Home Assist 1",
                        homeAssistId: "1",
                        score: "1-0",
                        awayScorer: nil,
                        awayScorerId: nil,
                        awayAssist: nil,
                        awayAssistId: nil,
                        info: nil,
                        infoTime: nil
                    )
                ],
                substitutes: [
                    Substitute(
                        time: "60'",
                        homeScorer: SubstitutePlayer(
                            in: "Home In",
                            out: "Home Out",
                            inId: 1,
                            outId: 2
                        ),
                        homeAssist: "Home Assist",
                        score: "1-0",
                        awayScorer: SubstitutePlayer(
                            in: "Away In",
                            out: "Away Out",
                            inId: 3,
                            outId: 4
                        )
                    )
                ],
                cards: [
                    Card(
                        time: "70'",
                        homeFault: "Home Fault",
                        card: "Yellow",
                        awayFault: "Away Fault",
                        info: "Info",
                        homePlayerId: "1",
                        awayPlayerId: "2"
                    )
                ],
                vars: Vars(
                    homeTeam: [],
                    awayTeam: []
                ),
                lineups: Lineups(
                    homeTeam: TeamLineup(
                        startingLineups: [
                            Player(
                                player: "Home Player",
                                playerNumber: 10,
                                playerPosition: 1,
                                playerCountry: "Country",
                                playerKey: 1,
                                infoTime: "Info Time"
                            )
                        ],
                        substitutes: [
                            Player(
                                player: "Substitute Player",
                                playerNumber: 12,
                                playerPosition: 2,
                                playerCountry: "Country",
                                playerKey: 2,
                                infoTime: "Info Time"
                            )
                        ],
                        coaches: [
                            Coaches(
                                coache: "Home Coach",
                                coachCountry: "Country"
                            )
                        ],
                        missingPlayers: ["Missing Player 1"]
                    ),
                    awayTeam: TeamLineup(
                        startingLineups: [
                            Player(
                                player: "Away Player",
                                playerNumber: 9,
                                playerPosition: 3,
                                playerCountry: "Country",
                                playerKey: 3,
                                infoTime: "Info Time"
                            )
                        ],
                        substitutes: [
                            Player(
                                player: "Substitute Player",
                                playerNumber: 11,
                                playerPosition: 4,
                                playerCountry: "Country",
                                playerKey: 4,
                                infoTime: "Info Time"
                            )
                        ],
                        coaches: [
                            Coaches(
                                coache: "Away Coach",
                                coachCountry: "Country"
                            )
                        ],
                        missingPlayers: ["Missing Player 2"]
                    )
                ),
                statistics: [
                    Statistic(
                        type: "Possession",
                        home: "60%",
                        away: "40%"
                    )
                ]
            )
        )
    }
}


