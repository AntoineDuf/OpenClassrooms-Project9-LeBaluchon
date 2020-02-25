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
    
    func testGivenTextViewHaveAText_WhenValidateButtonIsTappedAndLanguageSetupHasChanged_ThenTranslateHandlerSendAResultInFrench() {
        weatherViewModel.refreshWeatherCityOne()
        
        XCTAssertNotNil(weatherViewModel.weatherCityOneHandler)
        }
    
    func testGivenTextViewHaveAText_WhenValidateButtonIsTappedAndLanguageSetupHasChanged_ThenTranslateHandlerSendAResultInFrench2() {
        weatherViewModel.refreshWeatherCityTwo()
        
        XCTAssertNotNil(weatherViewModel.weatherCityTwoHandler)
        }
    
    func testGivenTextViewHaveAText_WhenReafreshButtonIsTappedButNetworkCallSendbackNilData_ThenErrorHandlerSendAResult() {
        weatherService = WeatherService(weatherSession: URLSessionFake(data: nil, response: FakeResponseData.responseKO, error: nil))
        weatherViewModel = WeatherViewModel(weatherService: weatherService)
        weatherViewModel.refreshWeatherCityOne()
        
        XCTAssertNotNil(weatherViewModel.errorHandler)
        }
    
    func testGivenTextViewHaveAText_WhenReafreshButtonIsTappedButNetworkCallSendbackNilData_ThenErrorHandlerSendAResult2() {
        weatherService = WeatherService(weatherSession: URLSessionFake(data: nil, response: FakeResponseData.responseKO, error: nil))
        weatherViewModel = WeatherViewModel(weatherService: weatherService)
        weatherViewModel.refreshWeatherCityTwo()
        
        XCTAssertNotNil(weatherViewModel.errorHandler)
        }
    
    func testGivenFirstLabelCell_WhenViewDidLoad_ThenFirstLabellCellIsFrench() {
        let configView = weatherViewModel.viewForHeader(in: 0)
        
        XCTAssertEqual(configView.largeContentTitle, "Pélissanne")
        }
    
    func testGivenSecondLabelCell_WhenViewDidLoad_ThenSecondLabellCellIsEnglish() {
        let configView = weatherViewModel.viewForHeader(in: 1)
        
        XCTAssertEqual(configView.largeContentTitle, "New York")
        }
    }
