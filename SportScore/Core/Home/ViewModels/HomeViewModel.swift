//
//  HomeViewModel.swift
//  SportScore
//
//  Created by Vladyslav Mi on 30.05.2024.
//

import Foundation
import Combine

enum CurrentView {
    case home, leagues, favourites, news, matches
}

class HomeViewModel: ObservableObject {
    
    @Published var countries: [Country] = []
    @Published var leagues: [League] = []
    @Published var standings: [Standing] = []
    @Published var fixtures: [Fixture] = []
    @Published var H2H: [HeadToHead] = []
    @Published var news: [Article] = []
    @Published var isLoading: Bool = false
    @Published var isLoadingStandings: Bool = false // Додаємо для завантаження таблиці
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .countryName
    @Published var selectedLeagueId: Int?
    @Published var currentView: CurrentView = .matches
    @Published var fixturesByLeague: [String: [Fixture]] = [:]
    
    private let countriesDataService = CountriesDataService()
    private let leaguesDataService = LeaguesDataService()
    private let standingsDataService = StandingsDataService()
    private let newsDataService = NewsDataService()
    //private let HeadToHeadDataService = HeadToHeadDataService()
    
    var fixturesDataService: FixturesDataService

    private var cancellables = Set<AnyCancellable>()
    
    
    enum SortOption {
        case countryKey, countryName
    }

    init(fixturesDataService: FixturesDataService = FixturesDataService()) {
           self.fixturesDataService = fixturesDataService
           addSubscribers()
       }
    
    func addSubscribers() {
        countriesDataService.$allCountries
            .sink { [weak self] countries in
                self?.countries = countries
            }
            .store(in: &cancellables)
        
        leaguesDataService.$allLeagues
            .sink { [weak self] leagues in
                self?.leagues = leagues
            }
            .store(in: &cancellables)
        
        standingsDataService.$allStandings
            .sink { [weak self] standings in
                self?.standings = standings
                self?.isLoadingStandings = false // Завантаження завершено
            }
            .store(in: &cancellables)
        
        fixturesDataService.$allFixtures
            .sink { [weak self] fixtures in
                self?.fixtures = fixtures
                self?.fixturesByLeague = Dictionary(grouping: fixtures, by: { $0.leagueName ?? "" })
            }
            .store(in: &cancellables)
        
        newsDataService.$allNews
            .sink { [weak self] news in
                self?.news = news
            }
            .store(in: &cancellables)
    }
    
    func fetchStandings(for leagueId: Int) {
        isLoadingStandings = true
        standingsDataService.getStandings(for: leagueId)
    }
}
