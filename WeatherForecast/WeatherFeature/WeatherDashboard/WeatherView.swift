//
//  WeatherView.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import SwiftUI

struct WeatherView: View {
    private let dataSource: WeatherViewDataSourceModel
    
    init(dataSource: WeatherViewDataSourceModel) {
        self.dataSource = dataSource
    }

    var body: some View {
        content
    }

    private var content: some View {
        VStack(alignment: .leading, spacing: 40) {
            headerView
            todayTempView
            Spacer()
            infoView
                .clipShape(.rect(topLeadingRadius: 20, topTrailingRadius: 20))
        }
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(dataSource.locationName)
                .bold()
                .font(.title)
                .foregroundStyle(.white)

            Text(dataSource.localTime)
                .font(.footnote)
                .foregroundStyle(.white)
        }
        .padding(.top, 18)
        .padding(.horizontal, 18)
    }

    private var todayTempView: some View {
        HStack(alignment: .center, spacing: 8) {
            VStack(alignment: .center, spacing: 8) {
                AsyncImage(url: dataSource.conditionIconUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.white)
                }
                Text(dataSource.conditionText)
                    .bold()
                    .font(.footnote)
                    .foregroundStyle(.white)
            }
            Spacer()
            Text(dataSource.averageTempC)
                .font(.system(size: 80))
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .minimumScaleFactor(0.8)
                .lineLimit(1)
        }
        .padding(.horizontal, 18)
        .frame(height: 50)
    }

    private var infoView: some View {
        HStack(alignment: .center, spacing: 20) {
            VStack(alignment: .leading, spacing: 20) {
                MoreInfoView(title: "Min temp", imageName: "thermometer.low", value: dataSource.minTemp)
                MoreInfoView(title: "Wind speed", imageName: "wind", value: dataSource.maxWindMph)
                MoreInfoView(title: "Sunrise", imageName: "sunrise", value: dataSource.sunrise)
            }
            VStack(alignment: .leading, spacing: 20) {
                MoreInfoView(title: "Max temp", imageName: "thermometer.high", value: dataSource.maxTemp)
                MoreInfoView(title: "Humidity", imageName: "humidity.fill", value: dataSource.avgHumidity)
                MoreInfoView(title: "Sunset", imageName: "sunset", value: dataSource.sunset)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 20)
        .padding(.bottom, 40)
        .padding(.horizontal, 18)
        .background(.white)
    }
}

#Preview {
    WeatherView(dataSource: WeatherViewDataSourceModel(locationName: "", localTime: "", conditionIconUrl: nil, conditionText: "", averageTempC: "", minTemp: "", maxTemp: "", maxWindMph: "", avgHumidity: "", sunrise: "", sunset: ""))
}
