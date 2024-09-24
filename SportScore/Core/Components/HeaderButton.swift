//
//  HeaderButton.swift
//  SportScore
//
//  Created by Vladyslav Mi on 28.05.2024.
//

import SwiftUI

struct HeaderButton: View {
    
    let iconName :String
    var body: some View {
        Image(systemName: iconName)
            .fontWeight(.bold)
            .font(.callout)
            .foregroundColor(.accent)
            .frame(width : 35, height: 35)
            .background(
                Circle()
                    .foregroundColor(Color.theme.background)
            )
            .shadow(
                color: Color.theme.accent.opacity(0.25),
                radius: 10, x: 0, y:0)
            .padding()
    }
}

#Preview {
    HeaderButton(iconName: "info")
}
