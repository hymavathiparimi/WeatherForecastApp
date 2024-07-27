//
//  ToastMessageModel.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation

struct ToastMessageModel: Equatable, Hashable {
    var id = UUID()
    var title: String?

    static func == (lhs: ToastMessageModel, rhs: ToastMessageModel) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
    }
}
