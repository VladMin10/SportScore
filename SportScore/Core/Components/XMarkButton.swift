//
//  XMarkButton.swift
//  SportScore
//
//  Created by Vladyslav Mi on 29.05.2024.
//

import SwiftUI

struct XMarkButton: View {
    
    @Environment (\.presentationMode) var presentationmode
    var body: some View {
        Button(action: {presentationmode.wrappedValue.dismiss()}, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

#Preview {
    XMarkButton()
}
