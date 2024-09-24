//
//  Color.swift
//  SportScore
//
//  Created by Vladyslav Mi on 24.05.2024.
//

import Foundation
import SwiftUI

extension Color {
    static let launch = LaunchTheme()
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
    let footerBackground = Color("FooterBackground")
    let headerBackground = Color("HeaderBackground")
    let whiteAccent = Color("WhiteAccentColor")
}

struct LaunchTheme {
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
    let pink = Color("LaunchPinkColor")
}
