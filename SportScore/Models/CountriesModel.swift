//
//  CountriesModel.swift
//  SportScore
//
//  Created by Vladyslav Mi on 30.05.2024.
//

import Foundation


struct Country: Decodable, Identifiable {
    let countryKey: Int
    let countryName: String
    let countryISO2: String?
    let countryLogo: URL?
    
    var id: Int { countryKey }

    enum CodingKeys: String, CodingKey {
        case countryKey = "country_key"
        case countryName = "country_name"
        case countryISO2 = "country_iso2"
        case countryLogo = "country_logo"
    }
}

