//
//  ForeCastDay.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation

struct ForeCastDay: Codable, Hashable {
    let date: String?
    let dateEpoch: Int?
    let day: Day?
    let astro: Astro?
    let hour: [Hour]?

    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day
        case astro
        case hour
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
        hasher.combine(dateEpoch)
    }

    static func == (lhs: ForeCastDay, rhs: ForeCastDay) -> Bool {
        return lhs.date == rhs.date
    }
}
