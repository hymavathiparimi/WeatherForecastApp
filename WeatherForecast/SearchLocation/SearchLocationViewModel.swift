//
//  SearchLocationViewModel.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation

final class SearchLocationViewModel: ObservableObject {
    @Published var searchedCities: [City] = []
    private let cities: [City]
    private var searchTask: DispatchWorkItem?
    private(set) var recentSearchCities: [String] = []

    init(cities: [City]) {
        self.cities = cities
        updateRecentSearchHistory()
    }

    private func updateRecentSearchHistory() {
        let storedCities = AppUserDefaults.locationHistory?.map { $0.key } ?? []
        recentSearchCities = storedCities.sorted(by: { $0 < $1 })
    }

    func searchCity(searchCity: String) {
        guard !searchCity.isEmpty else {
            searchedCities = []
            return
        }
        self.searchedCities = self.cities.filter { $0.city?.lowercased().starts(with: searchCity.lowercased()) ?? false }
    }
}
