//
//  HistoryIntegrationHandler.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation

protocol HistoryIntegrationHandler {
    func getWeatherHistory(searchedString: String) async throws -> LocationForecast
}
