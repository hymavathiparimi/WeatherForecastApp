//
//   Date+Extension.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation

extension Date {
    func toString(basedOn dateFormat: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatterManager.shared.dateFormatter
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }

    var nextDate: Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)
    }
}
