//
//  MockHistoryIntegrationService.swift
//  WeatherForecastTests
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation
@testable import WeatherForecast

class MockHistoryIntegrationService: HistoryIntegrationHandler {
    var isGetWeatherHistorySuccess: Bool = false
    var isGetWeatherHistoryNetworkFailure: Bool = false
    
    func getWeatherHistory(searchedString: String) async throws -> WeatherForecast.LocationForecast {
        return try await withCheckedThrowingContinuation { continuation in
            if isGetWeatherHistorySuccess, let response = MockHistoryResponseProvider.getHistoryResponse() {
                continuation.resume(returning: response)
            } else {
                if isGetWeatherHistoryNetworkFailure {
                    continuation.resume(throwing: NetworkServiceError.noInternet)
                } else {
                    continuation.resume(throwing: NetworkServiceError.invalidResponse)
                }
            }
        }
    }
}
