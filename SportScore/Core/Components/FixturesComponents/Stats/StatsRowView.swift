//
//  StatsView.swift
//  SportScore
//
//  Created by Vladyslav Mi on 18.06.2024.
//

import SwiftUI

struct StatisticRowView: View {
    let statistic: Statistic

    var body: some View {
        HStack {
            Text(statistic.home ?? "") // Use optional chaining and nil coalescing
                .frame(width: 50, alignment: .trailing)
                .font(.subheadline)
                .padding(.trailing, 8)

            GeometryReader { geometry in
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: self.width(for: statistic.home ?? "0%", in: geometry.size.width), alignment: .leading)
//                    Rectangle()
//                        .fill(Color.green)
//                        .frame(width: self.width(for: statistic.home ?? "0%", in: geometry.size.width), alignment: .leading)
                }
            }
            .frame(height: 20)

            Text(statistic.type ?? "")
                .frame(width: 150, alignment: .center)
                .font(.subheadline)

            GeometryReader { geometry in
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: self.width(for: statistic.away ?? "0%", in: geometry.size.width), alignment: .leading)
//                    Rectangle()
//                        .fill(Color.red)
//                        .frame(width: self.width(for: statistic.away ?? "0%", in: geometry.size.width), alignment: .leading)
                }
            }
            .frame(height: 20)

            Text(statistic.away ?? "") // Use optional chaining and nil coalescing
                .frame(width: 50, alignment: .leading)
                .font(.subheadline)
                .padding(.leading, 8)
        }
    }

    private func width(for value: String, in totalWidth: CGFloat) -> CGFloat {
        guard let percentage = Double(value.replacingOccurrences(of: "%", with: "")) else {
            return totalWidth / 2
        }
        let width = CGFloat(percentage) / 100.0 * totalWidth
        return min(width, totalWidth - 20) // Limit the width to prevent overlapping
    }
}


struct StatisticRowView_Previews: PreviewProvider {
    static var previews: some View {
        // Creating a sample Statistic object for preview
        let sampleStatistic = Statistic(type: "Throw In", home: "110%", away: "124%")

        // Using StatisticRowView with sample data
        StatisticRowView(statistic: sampleStatistic)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
