//
//  HistoryIntegrationService.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation

final class HistoryIntegrationService {
    let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}

extension HistoryIntegrationService: HistoryIntegrationHandler {
    func getWeatherHistory(searchedString: String) async throws -> LocationForecast {
        let today = Date()
        let requestParams = [
            "key": Config.apiKey,
            "dt": today.toString(),
            "end_dt": today.nextDate?.toString() ?? "",
            "q": searchedString
        ]
        return try await withCheckedThrowingContinuation { continuation in
            networkManager.callAPI(.get, endPoint: "v1/history.json", parameters: requestParams) { (result: Result<LocationForecast, NetworkServiceError>) in
                switch result {
                case .success(let forecast):
                    continuation.resume(returning: forecast)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
