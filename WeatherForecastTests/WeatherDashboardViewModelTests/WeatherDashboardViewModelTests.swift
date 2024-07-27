//
//  WeatherDashboardViewModelTests.swift
//  WeatherForecastTests
//
//  Created by Hymavathi parimi on 27/07/24.
//

@testable import WeatherForecast
import XCTest

final class WeatherDashboardViewModelTests: XCTestCase {
    var viewModel: WeatherDashboardViewModel!
    var mockHistoryIntegrationService: MockHistoryIntegrationService!

    override func setUpWithError() throws {
        mockHistoryIntegrationService = MockHistoryIntegrationService()
        viewModel = WeatherDashboardViewModel(historyIntegrationService: mockHistoryIntegrationService)
    }

    override func tearDownWithError() throws {
        mockHistoryIntegrationService = nil
        viewModel = nil
    }

    func testGetHistorySearchString() {
        // Given (Arrange)
        mockHistoryIntegrationService.isGetWeatherHistorySuccess = true

        // When (Act)
        viewModel.getHistory(searchedString: "")
        waitOneRunLoop()

        // Then (Assert)
        XCTAssertNotNil(viewModel.locationForecast == nil)
    }

    func testGetHistorySuccess() {
        // Given (Arrange)
        mockHistoryIntegrationService.isGetWeatherHistorySuccess = true

        // When (Act)
        viewModel.getHistory(searchedString: "Visakhapatnam")
        waitOneRunLoop()

        // Then (Assert)
        XCTAssertNotNil(viewModel.locationForecast != nil)
    }

    func testGetHistoryFail() {
        // Given (Arrange)
        mockHistoryIntegrationService.isGetWeatherHistorySuccess = false

        // When (Act)
        viewModel.getHistory(searchedString: "Visakhapatnam")
        waitOneRunLoop()

        // Then (Assert)
        XCTAssertEqual(viewModel.errorMessage?.title, NetworkServiceError.invalidResponse.errorDescription)
    }

    func testGetHistoryNetworkFailure() {
        // Given (Arrange)
        mockHistoryIntegrationService.isGetWeatherHistorySuccess = false
        mockHistoryIntegrationService.isGetWeatherHistoryNetworkFailure = true

        // When (Act)
        viewModel.getHistory(searchedString: "Visakhapatnam")
        waitOneRunLoop()

        // Then (Assert)
        XCTAssertEqual(viewModel.errorMessage?.title, NetworkServiceError.noInternet.errorDescription)
    }

}
