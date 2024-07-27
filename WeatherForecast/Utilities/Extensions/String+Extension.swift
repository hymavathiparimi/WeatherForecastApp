//
//  String+Extension.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation

extension String {
    static func placeholder(length: Int) -> String {
        String(Array(repeating: "X", count: length))
    }

    func loadJson<T: Codable>() async throws -> T? {
        guard let url = Bundle.main.url(forResource: self, withExtension: "json") else {
            throw NetworkServiceError.invalidURL
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(T.self, from: data)
            return jsonData
        } catch {
            throw NetworkServiceError.invalidResponse
        }
    }
}
