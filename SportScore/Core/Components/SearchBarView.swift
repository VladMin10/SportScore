//
//  SearchBarView.swift
//  SportScore
//
//  Created by Vladyslav Mi on 30.05.2024.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText : String
    @Binding var showSearchBar: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
            
            TextField("Search by name or symbol",text: $searchText)
                .foregroundColor(Color.theme.accent)
                .disableAutocorrection(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                            showSearchBar = false
                        }
                    ,alignment : .trailing
                )
        }
        
            .font(.headline)
            .padding()
            .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(
                    color : Color.theme.accent.opacity(0.30),
                    radius: 10,x : 0, y: 0)
            )
            .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    @State private static var searchText = ""
    @State private static var showSearchBar = false

    static var previews: some View {
        SearchBarView(searchText: $searchText, showSearchBar: $showSearchBar)
            .previewLayout(.sizeThatFits)
    }
}
