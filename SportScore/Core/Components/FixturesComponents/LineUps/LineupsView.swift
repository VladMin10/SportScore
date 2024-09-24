
import SwiftUI

struct LineupsView: View {
    let homeTeam: TeamLineup?
    let awayTeam: TeamLineup?
    let fixture: Fixture
    @StateObject private var playerDataService = PlayerDataService()
    @AppStorage("selectedTeam") private var selectedTeam: String = "home"

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Button(action: {
                        selectedTeam = "home"
                    }) {
                        HStack {
                            if let homeTeamLogo = fixture.homeTeamLogo {
                                URLImage(url: homeTeamLogo)
                                    .frame(width: 20, height: 20)
                            }
                            Text(fixture.eventHomeTeam ?? "")
                                .foregroundColor(.accent)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 1)
                                .background(selectedTeam == "home" ? Color.blue : Color.gray.opacity(0.3))
                        )
                        .cornerRadius(15)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        selectedTeam = "away"
                    }) {
                        HStack {
                            if let awayTeamLogo = fixture.awayTeamLogo {
                                URLImage(url: awayTeamLogo)
                                    .frame(width: 20, height: 20)
                            }
                            Text(fixture.eventAwayTeam ?? "")
                                .foregroundColor(.accent)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 1)
                                .background(selectedTeam == "away" ? Color.blue : Color.gray.opacity(0.3))
                        )
                        .cornerRadius(15)
                    }
                }
               .padding()
               .frame(maxWidth : .infinity, alignment : .leading)
                
                if selectedTeam == "home" {
                    LineupDetailView(team: homeTeam, playerDataService: playerDataService)
                } else {
                    LineupDetailView(team: awayTeam, playerDataService: playerDataService)
                }
            }
           .onAppear {
                if let homeTeam = homeTeam {
                    playerDataService.loadPlayerDetails(for: homeTeam)
                }
                if let awayTeam = awayTeam {
                    playerDataService.loadPlayerDetails(for: awayTeam)
                }
            }
        }
    }
}
struct LineupDetailView: View {
    let team: TeamLineup?
    @ObservedObject var playerDataService: PlayerDataService

    var body: some View {
        VStack(alignment: .leading) {
            if let team = team {
                if let coach = team.coaches?.first {
                    Text("Coach: \(coach.coache ?? "N/A")")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.primary)
                        .padding(.bottom, 10)
                }
                Text("Starting Lineups")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                    .padding(.bottom, 10)
                
                ForEach(team.startingLineups ?? [], id: \.playerKey) { player in
                    playerRow(player: player)
                    Divider()
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.2))
                }
                
                Text("Substitutes")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                ForEach(team.substitutes ?? [], id: \.playerKey) { player in
                    playerRow(player: player)
                    Divider()
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.2))
                }
            }
        }
        .padding(.horizontal, 15)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct playerRow: View {
    let player: Player
    
    var body: some View {
        HStack(alignment: .center) {
            ZStack {
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .overlay(
                        Circle()
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
                Text(player.playerNumber.map { "\($0)" } ?? "N/A")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(.black)
            }
            .padding(.trailing, 10)
            
            VStack(alignment: .leading) {
                Text(player.player ?? "N/A")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(.primary)
            }
        }
    }
}



struct LineupsView_Previews: PreviewProvider {
    static var previews: some View {
        let homeTeam = TeamLineup(
            startingLineups: [Player(player: "Player1", playerNumber: 1, playerPosition: 1, playerCountry: "Country 1", playerKey: 1, infoTime: "Info 1"),
                              Player(player: "Player2", playerNumber: 2, playerPosition: 2, playerCountry: "Country 2", playerKey: 2, infoTime: "Info 2")],
            substitutes: [Player(player: "Substitute 1", playerNumber: 11, playerPosition: 11, playerCountry: "Country 11", playerKey: 11, infoTime: "Info 11")],
            coaches: [Coaches(coache: "Coach 1", coachCountry: "Country 1")],
            missingPlayers: ["Missing Player 1"]
        )
        
        let awayTeam = TeamLineup(
            startingLineups: [Player(player: "Player A", playerNumber: 1, playerPosition: 1, playerCountry: "Country A", playerKey: 1, infoTime: "Info A"),
                              Player(player: "Player B", playerNumber: 2, playerPosition: 2, playerCountry: "Country B", playerKey: 2, infoTime: "Info B")],
            substitutes: [Player(player: "Substitute A", playerNumber: 11, playerPosition: 11, playerCountry: "Country A", playerKey: 11, infoTime: "Info A")],
            coaches: [Coaches(coache: "Coach A", coachCountry: "Country A")],
            missingPlayers: ["Missing Player A"]
        )
        
        LineupsView(homeTeam: homeTeam, awayTeam: awayTeam, fixture: Fixture(
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
            eventStatus: "Finished",
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
                    homeScorer: "Yaremchuk R.",
                    homeScorerId: "1",
                    homeAssist: "Brazhko V.",
                    homeAssistId: "1",
                    score: "1-0",
                    awayScorer: nil,
                    awayScorerId: nil,
                    awayAssist: nil,
                    awayAssistId: nil,
                    info: nil,
                    infoTime: nil
                ),
                GoalScorer(
                    time: "50'",
                    homeScorer: "Mudryk M.",
                    homeScorerId: "1",
                    homeAssist: "Yaremchuk R",
                    homeAssistId: "2",
                    score: "2-0",
                    awayScorer: nil,
                    awayScorerId: nil,
                    awayAssist: nil,
                    awayAssistId: nil,
                    info: nil,
                    infoTime: nil
                ),
                GoalScorer(
                    time: "90'",
                    homeScorer: nil,
                    homeScorerId: "1",
                    homeAssist: nil,
                    homeAssistId: nil,
                    score: "2-1",
                    awayScorer: "Antonesku A.",
                    awayScorerId: "3",
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
                        in: "Mydryk M",
                        out: "Zubkov O.",
                        inId: 1,
                        outId: 2
                    ),
                    homeAssist: "Home Assist",
                    score: "1-0",
                    awayScorer: SubstitutePlayer(
                        in: nil,
                        out: nil,
                        inId: nil,
                        outId: nil
                    )
                ),
                Substitute(
                    time: "71'",
                    homeScorer: SubstitutePlayer(
                        `in`: nil,
                        out: nil,
                        inId: nil,
                        outId: nil
                    ),
                    homeAssist: "Home Assist",
                    score: "1-0",
                    awayScorer: SubstitutePlayer(
                        in: "E. Tanninen",
                        out: "L. Forss.",
                        inId: 9,
                        outId: 10
                    )
                )
            ],
            cards: [
                Card(
                    time: "70'",
                    homeFault: "Stepanenko T",
                    card: "Yellow card",
                    awayFault: nil,
                    info: nil,
                    homePlayerId: "4",
                    awayPlayerId: nil
                ),
                Card(
                    time: "89'",
                    homeFault: nil,
                    card: "Yellow card",
                    awayFault: "Antonesku A.",
                    info: nil,
                    homePlayerId: nil,
                    awayPlayerId: "5"
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
        ))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
