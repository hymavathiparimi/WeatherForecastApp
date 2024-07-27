//
//  MockHistoryResponseProvider.swift
//  WeatherForecastTests
//
//  Created by Hymavathi parimi on 27/07/24.
//

@testable import WeatherForecast

enum MockHistoryResponseProvider {
    private enum MockJsonFileTypes {
        case locationForecast

        var fileName: String {
            switch self {
            case .locationForecast:
                return "LocationForecast"
            }
        }
    }

    static func getHistoryResponse() -> WeatherForecast.LocationForecast? {
        return Utils.loadJson(fileName: MockJsonFileTypes.locationForecast.fileName)
    }
}
