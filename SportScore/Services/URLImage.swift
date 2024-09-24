//
//  URLImage.swift
//  SportScore
//
//  Created by Vladyslav Mi on 11.06.2024.
//

import SwiftUI

struct URLImage: View {
    let url: URL

    var body: some View {
        AsyncImage(url: url) { image in
            image
              .resizable()
        } placeholder: {
            ProgressView()
        }
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(url: URL(string: "https://picsum.photos/600/600")!)
    }
}
