//
//  String.swift
//  SportScore
//
//  Created by Vladyslav Mi on 24.06.2024.
//


import Foundation


extension Date {
    func formattedDate() -> String {
        let calendar = Calendar.current
        let isToday = calendar.isDateInToday(self)
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = isToday ? "HH:mm" : "yyyy-MM-dd"
        
        return outputFormatter.string(from: self)
    }
}
