//
//  Day.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation

struct Day: Codable {
    let maxTempC: Double?
    let maxTempF: Double?
    let minTempC: Double?
    let minTempF: Double?
    let averageTempC: Double?
    let averageTempF: Double?
    let maxWindMph: Double?
    let maxWindKph: Double?
    let totalPrecipMm: Double?
    let totalPrecipIn: Double?
    let totalSnowCm: Double?
    let avgVisKm: Double?
    let avgVisMiles: Double?
    let avgHumidity: Int?
    let dailyWillItRain: Int?
    let dailyChanceOfRain: Int?
    let dailyWillItSnow: Int?
    let dailyChanceOfSnow: Int?
    let condition: Condition?
    let uv: Double?

    enum CodingKeys: String, CodingKey {
        case maxTempC = "maxtemp_c"
        case maxTempF = "maxtemp_f"
        case minTempC = "mintemp_c"
        case minTempF = "mintemp_f"
        case averageTempC = "avgtemp_c"
        case averageTempF = "avgtemp_f"
        case maxWindMph = "maxwind_mph"
        case maxWindKph = "maxwind_kph"
        case totalPrecipMm = "totalprecip_mm"
        case totalPrecipIn = "totalprecip_in"
        case totalSnowCm = "totalsnow_cm"
        case avgVisKm = "avgvis_km"
        case avgVisMiles = "avgvis_miles"
        case avgHumidity = "avghumidity"
        case dailyWillItRain = "daily_will_it_rain"
        case dailyChanceOfRain = "daily_chance_of_rain"
        case dailyWillItSnow = "daily_will_it_snow"
        case dailyChanceOfSnow = "daily_chance_of_snow"
        case condition
        case uv
    }
}
