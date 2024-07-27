//
//  Condition.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation

struct Condition: Codable {
    let text: String?
    let icon: String?
    let code: Int?

    enum CodingKeys: String, CodingKey {
        case text
        case icon
        case code
    }

    var formattedIcon: String {
        return "https:\(icon ?? "")"
    }

    var iconUrl: URL? {
        return URL(string: formattedIcon)
    }
}
