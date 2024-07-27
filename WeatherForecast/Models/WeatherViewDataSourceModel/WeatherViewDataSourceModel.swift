//
//  WeatherViewDataSourceModel.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation

struct WeatherViewDataSourceModel {
    let locationName: String
    let localTime: String
    let conditionIconUrl: URL?
    let conditionText: String
    let averageTempC: String
    let minTemp: String
    let maxTemp: String
    let maxWindMph: String
    let avgHumidity: String
    let sunrise: String
    let sunset: String
}
