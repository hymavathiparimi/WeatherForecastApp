//
//  City.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation

struct City: Codable, Hashable, Equatable {
    let city: String?
    let state: String?

    enum CodingKeys: String, CodingKey {
        case city
        case state
    }

    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.city == rhs.city && lhs.state == rhs.state
    }
}
