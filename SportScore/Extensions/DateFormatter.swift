//
//  DateFormatter.swift
//  SportScore
//
//  Created by Vladyslav Mi on 11.06.2024.
//

import Foundation

extension DateFormatter {
    static let fixtureDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // Adjust the date format based on the API response
        return formatter
    }()
}
