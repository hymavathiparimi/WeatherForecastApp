//
//  Utils.swift
//  WeatherForecastTests
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation

class Utils {
    private init() {}
    static func loadJson<T: Codable>(fileName: String) -> T? {
        if let url = Bundle(for: Utils.self).url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                return jsonData
            } catch {
                print(error)
            }
        }
        return nil
    }
}
