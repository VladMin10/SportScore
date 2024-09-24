//
//  CountryRowView.swift
//  SportScore
//
//  Created by Vladyslav Mi on 31.05.2024.
//

import SwiftUI

struct CountryRowView: View {
    let country: Country
    @State private var usePlaceholder: Bool = false
    
    var body: some View {
        HStack {
            if let urlString = country.countryLogo?.absoluteString,
               let url = URL(string: urlString) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .frame(width: 30, height: 30)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                    usePlaceholder = true
                                }
                            }
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 4)
                    case .failure:
                        Image("restofworld")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 4)
                    @unknown default:
                        Image("restofworld")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 4)
                    }
                }
            } else {
                Image("restofworld")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 4)
            }
            VStack(alignment: .leading) {
                Text(country.countryName)
                    .font(.headline)
//                Text("Key: \(country.countryKey)")
//                    .font(.subheadline)
//                if let iso2 = country.countryISO2 {
//                    Text("ISO2: \(iso2)")
//                        .font(.subheadline)
//                }
            }
        }
        .padding()
       // .frame(maxWidth : .infinity, maxHeight : 42, alignment: .leading)
    }
}

    struct CountryRowView_Previews: PreviewProvider {
        static var previews: some View {
            VStack {
                CountryRowView(country: Country(countryKey: 1, countryName: "Test Country", countryISO2: "TC", countryLogo: URL(string: "https://picsum.photos/600/600")))
                CountryRowView(country: Country(countryKey: 1, countryName: "Test Country", countryISO2: "TC", countryLogo: URL(string: "https://picsum.photos/500/500")))
                CountryRowView(country: Country(countryKey: 1, countryName: "Test Country", countryISO2: "TC", countryLogo: URL(string: "https://picsum.phtos/400/400")))
                CountryRowView(country: Country(countryKey: 1, countryName: "Test Country", countryISO2: "TC", countryLogo: URL(string: "https://picsm.photos/600/600")))
            }
            
                .previewLayout(.sizeThatFits)
               
        }
}
