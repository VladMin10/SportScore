//
//  SportButtonView.swift
//  SportScore
//
//  Created by Vladyslav Mi on 28.05.2024.
//

import SwiftUI

struct SportButtonView: View {
    
    var sport : String
    
    var body: some View {
        HStack(spacing : 8) {
            HStack(spacing : 4) {
                Image(systemName: "soccerball")
                    .foregroundColor(.accent)
                    .font(.headline)
                    .fontWeight(.bold)
                Text(sport)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.accent)
            }
            Image(systemName: "chevron.down")
                .foregroundColor(.accent)
                .font(.headline)
        }
        .frame(width: 125, height: 35)
        .background(
            Rectangle()
                .cornerRadius(15)
                .foregroundColor(Color.theme.background)
        )
        .shadow(
            color: Color.theme.accent.opacity(0.25),
            radius: 10, x: 0, y:0)
        
    }
}

#Preview {
    SportButtonView(sport: "Football")
}
