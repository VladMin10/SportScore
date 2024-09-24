//
//  FixtureDetailView.swift
//  SportScore
//
//  Created by Vladyslav Mi on 11.06.2024.
//

import SwiftUI

struct FixtureDetailsView: View {
    @State private var filters: [String] = ["Overview", "Lineups", "Statistics", "H2H"]
    @AppStorage("home_filter") private var selectedFilter = "Overview"
    let fixture: Fixture
    @State private var usePlaceholder: Bool = false
    @StateObject private var headToHeadDataService = HeadToHeadDataService()
    @ObservedObject var viewModel = StatsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.theme.background.ignoresSafeArea()
                
                VStack {
                    header
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                    FixtureFilterView(options: filters, selection: $selectedFilter)
                        .background(Divider(), alignment: .bottom)
                        .padding(.horizontal)
                    if selectedFilter == "Overview" {
                        leagueName
                            .padding(.horizontal, 20)
                            .padding(.top, 5)
                        HStack(alignment: .center, content: {
                            Text("\(fixture.eventStatus ?? "")")
                                .foregroundColor(Color.theme.secondaryText)
                            Text("\(fixture.eventFinalResult ?? "")")
                                .foregroundColor(Color.theme.secondaryText)
                        })
                        eventDetails
                    } else if selectedFilter == "Lineups" {
                        if let homeTeam = fixture.lineups?.homeTeam, let awayTeam = fixture.lineups?.awayTeam {
                            LineupsView(homeTeam: homeTeam, awayTeam: awayTeam, fixture: fixture)
                        } else {
                            Text("Lineups are not available.")
                        }

                    } else if selectedFilter == "Statistics" {
                        ScrollView {
                            VStack {
                                ForEach(viewModel.allStats) { stat in
                                    StatisticRowView(statistic: stat)
                                }
                            }
                        }
                    } else if selectedFilter == "H2H" {
                        h2hView
                    }
                    Spacer()
                }
                .padding(.top, 15)
            }
        }
    }
}


struct FixtureDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FixtureDetailsView(
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
            )
        )
    }
}


extension FixtureDetailsView {
    private var header : some View {
        HStack(alignment: .center) {
            VStack{
                if let homeTeamLogo = fixture.homeTeamLogo {
                    URLImage(url: homeTeamLogo)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                }
                Text(fixture.eventHomeTeam ?? "")
                    .font(.system(size: 19))
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                    .lineLimit(1)
            }
            .frame(width: UIScreen.main.bounds.width * 0.3 - 40, alignment: .leading)
            
            VStack {
                HStack(alignment: .center) {
                    Text("\(fixture.eventDate ?? "")")
                        .font(.caption2)
                    Text("\(fixture.eventTime ?? "")")
                        .font(.caption2)
                }
                .padding(.bottom, 5)
                
                Text("\(fixture.eventFinalResult ?? "")")
                    .font(.system(size: 32))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 5)
                    .fontWeight(.bold)
                
                Text("\(fixture.eventStatus ?? "")")
                    .font(.caption)
            }
           // .frame(width: 125, height: 100)
            .padding(.horizontal, 5)
            .padding(.bottom, 40)
            .frame(width: UIScreen.main.bounds.width * 0.3, alignment: .center)
            //.background(.ultraThickMaterial)
            
            VStack{
                if let awayTeamLogo = fixture.awayTeamLogo {
                    URLImage(url: awayTeamLogo)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                }
                Text(fixture.eventAwayTeam ?? "")
                    .font(.system(size: 19))
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                    .lineLimit(1)
            }
            .frame(width: UIScreen.main.bounds.width * 0.3 - 40, alignment: .trailing)
        }
    }
    private var leagueName : some View {
        HStack {
            if let urlString = fixture.leagueLogo?.absoluteString,
               let url = URL(string: urlString) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .frame(width: 18, height: 18)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                    usePlaceholder = true
                                }
                            }
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 18, height: 18)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    case .failure:
                        Image("restofworld")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 18, height: 18)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    @unknown default:
                        Image("restofworld")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 18, height: 18)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    }
                }
            } else {
                Image("restofworld")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 18, height: 18)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
            }
            Text("\(fixture.leagueName ?? "")")
                .font(.callout)
                .fontWeight(.medium)
            Spacer()
        }
    }
    private var eventDetails: some View {
        VStack(alignment: .leading) {
            ForEach(combinedEvents) { event in
                switch event.detail {
                case .goalScorer(let scorer):
                    goalView(scorer: scorer)
                case .card(let card):
                    cardView(card: card)
                case .substitution(let substitute):
                    substitutionView(substitute: substitute)
                }
            }
        }
        .padding()
    }
    
    private func logoImage(for phase: AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            return AnyView(ProgressView()
                .progressViewStyle(CircularProgressViewStyle()))
        case .success(let image):
            return AnyView(image
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2)))
        default:
            return AnyView(Image(systemName: "questionmark.square.fill")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2)))
        }
    }

    
}
extension FixtureDetailsView {
    private var combinedEvents: [Event] {
        var events: [Event] = []
        
        if let goalscorers = fixture.goalscorers {
            for scorer in goalscorers {
                if let time = scorer.time {
                    let event = Event(time: time, type: .goal, detail: .goalScorer(scorer))
                    events.append(event)
                }
            }
        }
        
        if let cards = fixture.cards {
            for card in cards {
                if let time = card.time {
                    let event = Event(time: time, type: .card, detail: .card(card))
                    events.append(event)
                }
            }
        }
        
        if let substitutes = fixture.substitutes {
            for substitute in substitutes {
                if let time = substitute.time {
                    let event = Event(time: time, type: .substitution, detail: .substitution(substitute))
                    events.append(event)
                }
            }
        }
        
        return events.sorted { lhs, rhs in
            guard let lhsTime = Int(lhs.time),
                  let rhsTime = Int(rhs.time) else {
                return false
            }
            return lhsTime < rhsTime
        }
    }
    private func goalView(scorer: GoalScorer) -> some View {
        HStack {
            if let homeScorer = scorer.homeScorer {
                VStack(spacing : 3) {
                    Image(systemName: "soccerball.inverse")
                        .foregroundColor(Color.green)
                        
                    Text("\(scorer.time ?? "")'")
                        .foregroundColor(Color.theme.secondaryText)
                        .font(.subheadline)
                }
               
                Divider()
                    .frame(width: 1, height: 30)
                    .background(Color.gray)
                    .padding(.horizontal, 3)
                Text("\(homeScorer)")
            } else if let awayScorer = scorer.awayScorer {
                HStack{
                    HStack{
                        Text("\(awayScorer)")
                    }
                   
                    Divider()
                        .frame(width: 1, height: 35)
                        .background(Color.gray)
                        .padding(.horizontal, 3)
                    VStack(spacing : 3) {
                        Image(systemName: "soccerball.inverse")
                            .foregroundColor(Color.green)
                        Text("\(scorer.time ?? "")'")
                            .foregroundColor(Color.theme.secondaryText)
                            .font(.subheadline)
                    }
                }
                .frame(maxWidth : .infinity, alignment: .trailing)
                
            }
        }
    }

    private func cardView(card: Card) -> some View {
        HStack {
            if let homePlayerID = card.homePlayerId, !homePlayerID.isEmpty {
                VStack(spacing: 3) {
                    Image(systemName: "lanyardcard.fill")
                        .foregroundColor(card.card?.lowercased() == "yellow card" ? .yellow : .red)
                    Text("\(card.time ?? "")'")
                        .foregroundColor(Color.theme.secondaryText)
                        .font(.subheadline)
                }
                Divider()
                    .frame(width: 1, height: 35)
                    .background(Color.gray)
                    .padding(.horizontal, 3)
                Text("\(card.homeFault ?? "")")
            } else if let awayPlayerID = card.awayPlayerId, !awayPlayerID.isEmpty {
                HStack {
                    Text("\(card.awayFault ?? "")")
                    Divider()
                        .frame(width: 1, height: 35)
                        .background(Color.gray)
                        .padding(.horizontal, 3)
                    VStack(spacing: 3) {
                        Image(systemName: "lanyardcard.fill")
                            .foregroundColor(card.card?.lowercased() == "yellow card" ? .yellow : .red)
                        Text("\(card.time ?? "")'")
                            .foregroundColor(Color.theme.secondaryText)
                            .font(.subheadline)
                }
                }
                .frame(maxWidth : .infinity, alignment: .trailing)
            }
        }
    }


    private func substitutionView(substitute: Substitute) -> some View {
        HStack {
            
            if let homePlayer = substitute.homeScorer?.`in` {
                HStack{
                    VStack{
                        Image(systemName: "arrow.right.arrow.left")
                        Text("\(substitute.time ?? "")'")
                            .foregroundColor(Color.theme.secondaryText)
                            .font(.subheadline)
                    }
                    VStack {
                        Text("In: \(homePlayer)")
                        Text("Out : \(substitute.homeScorer?.out ?? "")")
                    }
                }
               
            } else if let awayPlayer = substitute.awayScorer?.`in` {
                HStack{
                    VStack{
                        Image(systemName: "arrow.right.arrow.left")
                        Text("\(substitute.time ?? "")'")
                            .foregroundColor(Color.theme.secondaryText)
                            .font(.subheadline)
                    }
                    
                    VStack{
                        Text("In: \(awayPlayer)")
                        Text("Out : \(substitute.awayScorer?.out ?? "") ")
                    }
                }
                .frame(maxWidth : .infinity, alignment: .trailing)
            }
        }
    }
    
    private func eventStatusText(for fixture: Fixture) -> String {
        switch fixture.eventStatus {
        case "PostPoned":
            return "P/P"
        case "Finished":
            return "FT"
        case "":
            return "-"
        default:
            return fixture.eventStatus ?? "-"
        }
    }
    
    private var h2hView : some View{
        VStack {
            if headToHeadDataService.isLoading {
                ProgressView()
                } else {
                    List(headToHeadDataService.allHeadToHead) { headToHead in
                        HStack {
                            VStack(alignment: .center) {
                                Text(headToHead.eventDate ?? "")
                                    .font(.subheadline)
                                    .lineLimit(2)
                                HStack {
                                    Text(eventStatusText(for: fixture))
                                        .font(.subheadline)
                                }
                            }
                            Divider()
                                .frame(width: 1, height: 42)
                                .background(Color.gray)
                                .padding(.horizontal, 3)
                            VStack(alignment: .leading) {
                                HStack {
                                    if let homeTeamLogo = headToHead.homeTeamLogo,
                                       let homeTeamLogoURL = URL(string: homeTeamLogo) {
                                            URLImage(url: homeTeamLogoURL)
                                                .frame(width: 20, height: 20)
                                    } else {
                                        ProgressView()
                                    }
                                    Text(headToHead.eventHomeTeam ?? "")
                                        .font(.headline)
                                        .lineLimit(1)
                                }
                                HStack {
                                    if let awayTeamLogo = headToHead.awayTeamLogo,
                                       let awayTeamLogoURL = URL(string : awayTeamLogo){
                                        URLImage(url: awayTeamLogoURL)
                                            .frame(width: 20, height: 20)
                                    } else {
                                        ProgressView()
                                    }
                                    Text(headToHead.eventAwayTeam ?? "")
                                        .font(.headline)
                                        .lineLimit(1)
                                }
                            }
                            
                            Spacer()
                            Text(headToHead.eventFinalResult)
                            }
                        }
                    }
            }
            .onAppear {
                headToHeadDataService.getHeadToHead(homeTeamId: fixture.homeTeamKey ?? 101, awayTeamId: fixture.awayTeamKey ?? 102)
                }
    }
}



struct Event: Identifiable {
    let id = UUID()
    let time: String
    let type: EventType
    let detail: EventDetail
    
    enum EventType {
        case goal
        case card
        case substitution
    }
    
    enum EventDetail {
        case goalScorer(GoalScorer)
        case card(Card)
        case substitution(Substitute)
    }
}

