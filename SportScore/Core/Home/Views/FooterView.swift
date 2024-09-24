//
//  FooterView.swift
//  SportScore
//
//  Created by Vladyslav Mi on 04.06.2024.
//

import SwiftUI

struct FooterView: View {
    @Binding var currentView: CurrentView
    
    var body: some View {
        ZStack {
            Color.footerBackground.ignoresSafeArea()
            
            HStack {
                Spacer()
                
                VStack {
                    Image(systemName: "soccerball.inverse")
                        .font(.system(size: 23))
                    Text("Matches")
                        .font(.subheadline)
                }
                .onTapGesture {
                    currentView = .matches
                }
                .foregroundColor((currentView == .matches) ? Color.theme.red : Color.accent)
                
                Spacer()
                Rectangle()
                    .fill(Color.accent)
                    .frame(width: 3, height: 35)
                Spacer()
                VStack {
                    Image(systemName: "trophy.circle")
                        .font(.system(size: 23))
                    Text("Leagues")
                        .font(.subheadline)
                }
                .onTapGesture {
                    currentView = .leagues
                }
                .foregroundColor((currentView == .leagues) ? Color.theme.red : Color.accent)
                
                Spacer()
                Rectangle()
                    .fill(Color.accent)
                    .frame(width: 3, height: 35)
                Spacer()
                
                VStack {
                    Image(systemName: "star.fill")
                        .font(.system(size: 23))
                    
                    Text("Favourites")
                        .font(.subheadline)
                        
                }
                .onTapGesture {
                    currentView = .favourites
                }
                .foregroundColor((currentView == .favourites) ? Color.theme.red : Color.accent)
                
                Spacer()
                Rectangle()
                    .fill(Color.accent)
                    .frame(width: 3, height: 35)
                Spacer()
                
                VStack {
                    Image(systemName: "newspaper.circle")
                        .font(.system(size: 23))
                    Text("News")
                        .font(.subheadline)
                }
                .onTapGesture {
                    currentView = .news
                }
                .foregroundColor((currentView == .news) ? Color.theme.red : Color.accent)
                
                Spacer()
            }
            .padding(.top, 10)
            .foregroundStyle(Color.theme.accent)
            .cornerRadius(10)
        }
        .frame(height: 60)
        //.cornerRadius(1)
    }
}

#Preview {
    VStack {
        Spacer()
        FooterView(currentView: .constant(.home))
    }
}
