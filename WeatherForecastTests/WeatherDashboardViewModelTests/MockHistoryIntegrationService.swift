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

    func getWeatherHistory(searchedString: String, _ completion: @escaping (Result<LocationForecast, NetworkServiceError>) -> Void) {
        if isGetWeatherHistorySuccess, let response = MockHistoryResponseProvider.getHistoryResponse() {
            completion(.success(response))
        } else {
            if isGetWeatherHistoryNetworkFailure {
                completion(.failure(.noInternet))
            } else {
                completion(.failure(.invalidResponse))
            }
        }
    }
}
