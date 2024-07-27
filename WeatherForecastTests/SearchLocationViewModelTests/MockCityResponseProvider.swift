//
//  MockCityResponseProvider.swift
//  WeatherForecastTests
//
//  Created by Hymavathi parimi on 27/07/24.
//

@testable import WeatherForecast
import Foundation

enum MockCityResponseProvider {
    private enum MockJsonFileTypes {
        case city

        var fileName: String {
            switch self {
            case .city:
                return "Cities"
            }
        }
    }

    static func getCitiesResponse() -> [WeatherForecast.City]? {
        return Utils.loadJson(fileName: MockJsonFileTypes.city.fileName)
    }
}
