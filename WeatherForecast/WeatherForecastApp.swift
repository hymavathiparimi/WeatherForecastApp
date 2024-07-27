//
//  WeatherForecastApp.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import SwiftUI

@main
struct WeatherForecastApp: App {
    private var networkManager: NetworkManager

    init() {
        networkManager = NetworkManager(baseURL: Constants.baseURL)
    }
    
    var body: some Scene {
        WindowGroup {
            WeatherDashboardView(viewModel: WeatherDashboardViewModel(historyIntegrationService: HistoryIntegrationService(networkManager: networkManager)))
        }
    }
}
