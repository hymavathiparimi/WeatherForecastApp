//
//  LocationForecast.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation

struct LocationForecast: Codable {
    let location: Location?
    let forecast: ForeCast?

    enum CodingKeys: String, CodingKey {
        case location
        case forecast
    }
}
