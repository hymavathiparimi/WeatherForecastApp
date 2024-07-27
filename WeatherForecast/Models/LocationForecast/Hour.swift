//
//  Hour.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation

struct Hour: Codable {
    let timeEpoch: Int?
    let time: String?
    let tempC: Double?
    let tempF: Double?
    let isDay: Int?
    let condition: Condition?

    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay
        case condition
    }
}
