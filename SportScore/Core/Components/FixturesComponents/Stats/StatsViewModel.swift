//
//  StatsViewModel.swift
//  SportScore
//
//  Created by Vladyslav Mi on 18.06.2024.
//

import Foundation

class StatsViewModel : ObservableObject {
    var allStats: [Statistic] = [ Statistic(type: "Throw In", home: "16", away: "12"),
                                  Statistic(type: "Free Kick", home: "9", away: "10"),
                                  Statistic(type: "Goal Kick", home: "10", away: "4"),
                                  Statistic(type: "Substitution", home: "5", away: "5"),
                                  Statistic(type: "Attacks", home: "61", away: "104"),
                                  Statistic(type: "Dangerous Attacks", home: "22", away: "56"),
                                  Statistic(type: "On Target", home: "5", away: "1"),
                                  Statistic(type: "Off Target", home: "4", away: "10"),
                                  Statistic(type: "Shots Total", home: "9", away: "11"),
                                  Statistic(type: "Shots On Goal", home: "5", away: "1"),
                                  Statistic(type: "Shots Off Goal", home: "2", away: "4"),
                                  Statistic(type: "Shots Blocked", home: "2", away: "6"),
                                  Statistic(type: "Shots Inside Box", home: "3", away: "4"),
                                  Statistic(type: "Shots Outside Box", home: "6", away: "7"),
                                  Statistic(type: "Fouls", home: "8", away: "8"),
                                  Statistic(type: "Corners", home: "4", away: "6"),
                                  Statistic(type: "Offsides", home: "1", away: "1"),
                                  Statistic(type: "Ball Possession", home: "30%", away: "70%"),
                                  Statistic(type: "Yellow Cards", home: "1", away: "1"),
                                  Statistic(type: "Saves", home: "2", away: "2"),
                                  Statistic(type: "Passes Total", home: "227", away: "547"),
                                  Statistic(type: "Passes Accurate", home: "167", away: "477")]
}
