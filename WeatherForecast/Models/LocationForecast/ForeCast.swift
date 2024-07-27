//
//  ForeCast.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation

struct ForeCast: Codable {
    let foreCastDay: [ForeCastDay]?

    enum CodingKeys: String, CodingKey {
        case foreCastDay = "forecastday"
    }
}
