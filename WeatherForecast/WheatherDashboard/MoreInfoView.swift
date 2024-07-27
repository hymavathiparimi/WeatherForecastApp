//
//  MoreInfoView.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import SwiftUI

struct MoreInfoView: View {
    private let title: String
    private let imageName: String
    private let value: String

    init(title: String, imageName: String, value: String) {
        self.title = title
        self.imageName = imageName
        self.value = value
    }

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40, alignment: .center)
                .foregroundStyle(Colors.themeColor)
                .symbolEffect(.pulse)

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(Colors.themeColor)

                Text(value)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(Colors.themeColor)
            }
            Spacer()
        }
    }
}

#Preview {
    MoreInfoView(title: "Min temp", imageName: "thermometer.low", value: "7")
}

