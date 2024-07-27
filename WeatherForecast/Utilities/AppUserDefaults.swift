//
//  AppUserDefaults.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation

enum AppUserDefaults {
    private static let defaults = UserDefaults.standard
    private static let defaultKey = "weatherApp"

    private enum Keys {
        static let selectedLocation = "\(defaultKey).selectedLocation"
        static let locationHistory = "\(defaultKey).locationHistory"
    }

    static var selectedLocation: String? {
        get {
            defaults.string(forKey: Keys.selectedLocation)
        } set {
            defaults.set(newValue, forKey: Keys.selectedLocation)
        }
    }

    static var locationHistory: [String: LocationForecast]? {
        get {
            try? defaults.getObject(forKey: Keys.locationHistory, castTo: [String: LocationForecast].self)
        } set {
            try? defaults.setObject(newValue, forKey: Keys.locationHistory)
        }
    }
}
