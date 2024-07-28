//
//  WeatherDashboardViewModel.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation

final class WeatherDashboardViewModel: ObservableObject {
    @Published var locationForecast: LocationForecast?
    @Published var errorMessage: ToastMessageModel?
    @Published var isLoading: Bool = false
    @Published var showBanner: Bool = false
    private(set) var cities: [City] = []
    private let historyIntegrationService: HistoryIntegrationHandler

    init(historyIntegrationService: HistoryIntegrationHandler) {
        self.historyIntegrationService = historyIntegrationService
        loadCities()
    }

    func getHistory(searchedString: String?) {
        guard let searchedString, !searchedString.isEmpty else {
            return
        }
        isLoading = true
        defer { isLoading = false }
        Task {
            do {
                let response = try await historyIntegrationService.getWeatherHistory(searchedString: searchedString)
                Task { @MainActor in
                    self.locationForecast = response
                    self.updateLocationHistory(searchedString: searchedString, locationForecast: response)
                }
            } catch let failure as NetworkServiceError {
                Task { @MainActor in
                    if NetworkServiceError.noInternet == failure {
                        self.locationForecast = AppUserDefaults.locationHistory?[searchedString]
                    }
                    self.errorMessage = ToastMessageModel(title: failure.errorDescription)
                    self.showBanner = self.locationForecast == nil
                }
            } catch {
                Task { @MainActor in
                    self.errorMessage = ToastMessageModel(title: error.localizedDescription)
                    self.showBanner = self.locationForecast == nil
                }
            }
        }
    }

    private func updateLocationHistory(searchedString: String, locationForecast: LocationForecast) {
        var locationHistory = AppUserDefaults.locationHistory
        if (locationHistory ?? [:]).isEmpty {
            AppUserDefaults.locationHistory = [searchedString: locationForecast]
        } else {
            locationHistory?[searchedString] = locationForecast
            AppUserDefaults.locationHistory = locationHistory
        }
        AppUserDefaults.selectedLocation = searchedString
    }

    private func loadCities() {
        Task {
            let cities: [City]? = try? await "Cities".loadJson()
            self.cities = cities?.sorted(by: { $0.city ?? "" < $1.city ?? "" }) ?? []
        }
    }
}
