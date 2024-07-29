//
//  WeatherDashboardView.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import SwiftUI

struct WeatherDashboardView: View {
    @ObservedObject var viewModel: WeatherDashboardViewModel
    @State private var showSearchLocationSheet: Bool = false
    @State private var showSearchLocationFullScreen: Bool = false
    @State private var selectedCity: String?
    @State private var showToast: Bool = false

    init(viewModel: WeatherDashboardViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            content
            searchButton
        }
        .toast(message: viewModel.errorMessage, showToast: $viewModel.showBanner)
    }

    private var content: some View {
        TabView {
            if viewModel.isLoading {
                WeatherView(dataSource: prepareWeatherViewShimmerViewModel())
                    .edgesIgnoringSafeArea(.bottom)
                    .redacted(reason: .placeholder)
            } else {
                ForEach(viewModel.locationForecast?.forecast?.foreCastDay ?? [], id: \.self) { foreCastDay in
                    WeatherView(dataSource: prepareWeatherViewModel(foreCastDay: foreCastDay))
                        .edgesIgnoringSafeArea(.bottom)
                }
            }
        }
        .tabViewStyle(.page)
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            guard let selectedLocation = AppUserDefaults.selectedLocation else {
                showSearchLocationFullScreen.toggle()
                return
            }
            viewModel.getHistory(searchedString: selectedLocation)
        }
        .onChange(of: selectedCity) {
            viewModel.getHistory(searchedString: selectedCity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(Colors.themeColor)
        .sheet(isPresented: $showSearchLocationSheet) {
            SearchLocationView(viewModel: SearchLocationViewModel(cities: viewModel.cities), selectedCity: $selectedCity)
        }
        .fullScreenCover(isPresented: $showSearchLocationFullScreen) {
            SearchLocationView(viewModel: SearchLocationViewModel(cities: viewModel.cities), selectedCity: $selectedCity)
        }
    }

    private var searchButton: some View {
        Button {
            showSearchLocationSheet.toggle()
        } label: {
            Image(systemName: "magnifyingglass.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40, alignment: .center)
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 18)
        .padding(.top, 18)
        .redacted(reason: viewModel.isLoading ? .placeholder : .invalidated)
        .disabled(viewModel.isLoading ? true : false)
    }

    private func prepareWeatherViewModel(foreCastDay: ForeCastDay) -> WeatherViewDataSourceModel {
        WeatherViewDataSourceModel(
            locationName: viewModel.locationForecast?.location?.name ?? "",
            localTime: foreCastDay.date ?? "",
            conditionIconUrl: foreCastDay.day?.condition?.iconUrl,
            conditionText: foreCastDay.day?.condition?.text ?? "",
            averageTempC: "\(foreCastDay.day?.averageTempC?.toString() ?? "")°",
            minTemp: "\(foreCastDay.day?.minTempC?.toString() ?? "")°",
            maxTemp: "\(foreCastDay.day?.maxTempC?.toString() ?? "")°",
            maxWindMph: "\(foreCastDay.day?.maxWindMph?.toString() ?? "")m/s",
            avgHumidity: "\(foreCastDay.day?.avgHumidity?.toString() ?? "")%",
            sunrise: "\(foreCastDay.astro?.sunrise ?? "")",
            sunset: "\(foreCastDay.astro?.sunset ?? "")"
        )
    }

    private func prepareWeatherViewShimmerViewModel() -> WeatherViewDataSourceModel {
        WeatherViewDataSourceModel(
            locationName: .placeholder(length: 4),
            localTime: .placeholder(length: 4),
            conditionIconUrl: URL(string: "https://cdn.weatherapi.com/weather/64x64/night/116.png"),
            conditionText: .placeholder(length: 4),
            averageTempC: .placeholder(length: 4),
            minTemp: .placeholder(length: 4),
            maxTemp: .placeholder(length: 4),
            maxWindMph: .placeholder(length: 4),
            avgHumidity: .placeholder(length: 4),
            sunrise: .placeholder(length: 4),
            sunset: .placeholder(length: 4)
        )
    }
}

#Preview {
    WeatherDashboardView(viewModel: WeatherDashboardViewModel(historyIntegrationService: HistoryIntegrationService(networkManager: NetworkManager(baseURL: ""))))
}
