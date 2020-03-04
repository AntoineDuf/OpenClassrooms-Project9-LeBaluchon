//
//  WeatherViewModelTestCase.swift
//  LeBaluchonTests
//
//  Created by Antoine Dufayet on 24/02/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import Foundation

@testable import LeBaluchon
import XCTest

class WeatherViewModelTestCase: XCTestCase {
    var weatherViewModel: WeatherViewModel!
    var weatherService: WeatherService!
    
    override func setUp() {
        super.setUp()
        weatherService = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        weatherViewModel = WeatherViewModel(weatherService: weatherService)
    }
    
    override func tearDown() {
        weatherViewModel = nil
        super.tearDown()
    }
    
    func testGetWeatherCityOne() {
        // Given
        let ex = expectation(description: "")
        // When
        weatherViewModel.weatherCityOneHandler = { infoCityOne in
            XCTAssertEqual(infoCityOne.temperature, "5°")
            XCTAssertEqual(infoCityOne.condition, "Ciel dégagé")
            XCTAssertEqual(infoCityOne.wind, "14km/h")
            XCTAssertEqual(infoCityOne.image, "01d")
            XCTAssertEqual(infoCityOne.compass, "IconCompassN-O")
            XCTAssertEqual(infoCityOne.direction, "Nord-Ouest")
            ex.fulfill()
        }
        // Then
        weatherViewModel.refreshWeatherCityOne()
        wait(for: [ex], timeout: 1)
    }
    
    func testGetWeatherCityTwo() {
        // Given
        let ex = expectation(description: "")
        // When
        weatherViewModel.weatherCityTwoHandler = { infoCityOne in
            XCTAssertEqual(infoCityOne.temperature, "5°")
            XCTAssertEqual(infoCityOne.condition, "Ciel dégagé")
            XCTAssertEqual(infoCityOne.wind, "14km/h")
            XCTAssertEqual(infoCityOne.image, "01d")
            XCTAssertEqual(infoCityOne.compass, "IconCompassN-O")
            XCTAssertEqual(infoCityOne.direction, "Nord-Ouest")
            ex.fulfill()
        }
        // Then
        weatherViewModel.refreshWeatherCityTwo()
        wait(for: [ex], timeout: 1)
    }
    
    func testErrorMessageForCityOne() {
        // Given
        let ex = expectation(description: "")
        weatherService = WeatherService(weatherSession: URLSessionFake(data: nil, response: FakeResponseData.responseKO, error: nil))
        weatherViewModel = WeatherViewModel(weatherService: weatherService)
        weatherViewModel.refreshWeatherCityOne()
        // When
        weatherViewModel.errorHandler = { message in
            XCTAssertEqual(message, "Une erreur est survenue.")
            ex.fulfill()
        }
        // Then
        weatherViewModel.refreshWeatherCityOne()
        wait(for: [ex], timeout: 1)
    }
    
    func testErrorMessageForCityTwo() {
        // Given
        let ex = expectation(description: "")
        weatherService = WeatherService(weatherSession: URLSessionFake(data: nil, response: FakeResponseData.responseKO, error: nil))
        weatherViewModel = WeatherViewModel(weatherService: weatherService)
        weatherViewModel.refreshWeatherCityTwo()
        // When
        weatherViewModel.errorHandler = { message in
            XCTAssertEqual(message, "Une erreur est survenue.")
            ex.fulfill()
        }
        // Then
        weatherViewModel.refreshWeatherCityTwo()
        wait(for: [ex], timeout: 1)
    }
    
    func testFirstLabelCellAtTheLaunch() {
        let configView = weatherViewModel.viewForHeader(in: 0)
        
        XCTAssertEqual(configView.largeContentTitle, "Pélissanne")
    }
    
    func testSecondLabelCellAtTheLaunch() {
        let configView = weatherViewModel.viewForHeader(in: 1)
        
        XCTAssertEqual(configView.largeContentTitle, "New York")
    }
    
    func testUpdateWindInfo() {
        let north = weatherViewModel.updateWindIcon(
            condition: 1)
        let north2 = weatherViewModel.updateWindIcon(
            condition: 334)
        let northEast = weatherViewModel.updateWindIcon(
            condition: 24)
        let east = weatherViewModel.updateWindIcon(
            condition: 69)
        let southEast = weatherViewModel.updateWindIcon(
            condition: 114)
        let south = weatherViewModel.updateWindIcon(
            condition: 159)
        let southWest = weatherViewModel.updateWindIcon(
            condition: 204)
        let west = weatherViewModel.updateWindIcon(
            condition: 249)
        let northWest = weatherViewModel.updateWindIcon(
            condition: 294)
        let error = weatherViewModel.updateWindIcon(condition: 500)
        
        XCTAssertEqual(north[1], "Nord")
        XCTAssertEqual(north2[1], "Nord")
        XCTAssertEqual(northEast[1], "Nord-est")
        XCTAssertEqual(east[1], "Est")
        XCTAssertEqual(southEast[1], "Sud-est")
        XCTAssertEqual(south[1], "Sud")
        XCTAssertEqual(southWest[1], "Sud-ouest")
        XCTAssertEqual(west[1], "Ouest")
        XCTAssertEqual(northWest[1], "Nord-Ouest")
        XCTAssertEqual(error[1], "Erreur")
    }
}
