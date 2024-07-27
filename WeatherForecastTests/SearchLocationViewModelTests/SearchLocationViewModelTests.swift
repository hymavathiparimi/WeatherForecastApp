//
//  SearchLocationViewModelTests.swift
//  WeatherForecastTests
//
//  Created by Hymavathi parimi on 27/07/24.
//

@testable import WeatherForecast
import XCTest

final class SearchLocationViewModelTests: XCTestCase {
    var viewModel: SearchLocationViewModel!

    override func setUpWithError() throws {
        let cities = MockCityResponseProvider.getCitiesResponse()
        viewModel = SearchLocationViewModel(cities: cities ?? [])
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testSearchCity() {
        // Given (Arrange)
        let searchCity = "Vijayawada"

        // When (Act)
        viewModel.searchCity(searchCity: searchCity)

        // Then (Assert)
        XCTAssertTrue(!viewModel.searchedCities.isEmpty)
    }
    
    func testEmptySearchCity() {
        // Given (Arrange)
        let searchCity = ""

        // When (Act)
        viewModel.searchCity(searchCity: searchCity)

        // Then (Assert)
        XCTAssertTrue(viewModel.searchedCities.isEmpty)
    }

}
