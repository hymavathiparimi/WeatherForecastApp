//
//  Config.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation

public enum Config {
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist not found")
        }
        return dict
    }()

    static let apiKey: String = {
        guard let apiKey = Config.infoDictionary[Keys.apiKey.rawValue] as? String else {
            fatalError("API KEY not set in plist")
        }
        return apiKey
    }()

    private enum Keys: String {
        case apiKey = "API_KEY"
    }
}
