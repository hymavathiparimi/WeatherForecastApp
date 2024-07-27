//
//  XCTestCase+Extension.swift
//  WeatherForecastTests
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation
@testable import WeatherForecast
import XCTest

extension XCTestCase {
    func waitOneRunLoop(msg: String = "mainThread", timeout: TimeInterval = 5) {
        let expectation = expectation(description: msg)
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeout)
    }
}
