//
//  FixtureFilterView.swift
//  SportScore
//
//  Created by Vladyslav Mi on 12.06.2024.
//

import SwiftUI

struct FixtureFilterView: View {
    
    var options : [String] = ["Overview","Lineups", "Statistics", "H2H"]
    @Binding var selection : String
    @Namespace private var namespace
    
    var body: some View {
        HStack(alignment : .top, spacing : 32){
            ForEach(options, id : \.self){ option in
                VStack(spacing : 8) {
                    Text("\(option)")
                        .frame(maxWidth : .infinity)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    if selection == option {
                        RoundedRectangle(cornerRadius: 2)
                            .frame(height : 1.5)
                            .matchedGeometryEffect(id: "selection", in: namespace)
                    }
                }
                .padding(.top, 4)
                .background(Color.black.opacity(0.001))
                .foregroundStyle(selection == option ? .blue : .accent)
                .onTapGesture {
                    selection = option
                }
            }
        }
        .animation(.smooth, value : selection)
    }
}

fileprivate struct FixtureFilterViewPreview : View {
    
    var options : [String] = ["Overview","Lineups", "Statistics", "H2H"]
    @State private var selection = "Overview"
    
    var body : some View {
        FixtureFilterView(options : options, selection : $selection)
    }
}

#Preview {
    FixtureFilterViewPreview()
}
