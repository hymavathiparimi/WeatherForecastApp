//
//  DateFormatterManager.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation

final class DateFormatterManager {
    static let shared = DateFormatterManager()

    private init() {}

    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        return dateFormatter
    }()
}
