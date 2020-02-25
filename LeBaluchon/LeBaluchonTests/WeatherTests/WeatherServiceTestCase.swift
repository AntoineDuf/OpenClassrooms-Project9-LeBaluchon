//
//  WeatherServiceTestCase.swift
//  LeBaluchonTests
//
//  Created by Antoine Dufayet on 19/02/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

@testable import LeBaluchon
import XCTest

class WeatherServiceTestCase: XCTestCase {
    func testGetWeatherShouldPostFailedCallbackIfError() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: "New York") { (weather, error) in
            // Then
            XCTAssertNil(weather)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: "New York") { (weather, error) in
            // Then
            XCTAssertNotNil(weather)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
