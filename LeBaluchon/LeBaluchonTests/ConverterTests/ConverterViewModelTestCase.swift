//
//  ConverterViewModelTestCase.swift
//  LeBaluchonTests
//
//  Created by Antoine Dufayet on 22/02/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import Foundation

@testable import LeBaluchon
import XCTest

class ConverterViewModelTestCase: XCTestCase {
    var converterViewModel: ConverterViewModel!
    var converterService: ConverterService!
    
    override func setUp() {
        super.setUp()
        converterService = ConverterService(converterSession: URLSessionFake(data: FakeResponseData.converterCorrectData, response: FakeResponseData.responseOK, error: nil))
        converterViewModel = ConverterViewModel(converterService: converterService)
    }
    
    override func tearDown() {
        converterViewModel = nil
        super.tearDown()
    }
    
    func testConvertInUSDollar() {
        //        Given :
        let ex = expectation(description: "")
        let text = "1"
        //When :
        converterViewModel.currencySetup = ConverterViewModel.Currency.USDollar
        converterViewModel.toggleCurrency()
        converterViewModel.converterHandler = { convertText in
            XCTAssertEqual(convertText, "1.08$")
            ex.fulfill()
        }
        //Then :
        converterViewModel.getConvert(text: text)
        wait(for: [ex], timeout: 1)
        XCTAssertEqual(converterViewModel.currencySetup, ConverterViewModel.Currency.Euro)
        }
    
        func testConvertInEuros() {
        //        Given :
        let ex = expectation(description: "")
        let text = "1"
        //When :
        converterViewModel.currencySetup = ConverterViewModel.Currency.Euro
        converterViewModel.toggleCurrency()
        converterViewModel.converterHandler = { convertText in
            XCTAssertEqual(convertText, "0.93€")
            ex.fulfill()
        }
        //Then :
        converterViewModel.getConvert(text: text)
        wait(for: [ex], timeout: 1)
        XCTAssertEqual(converterViewModel.currencySetup, ConverterViewModel.Currency.USDollar)
        }
    
    func testErrorMessageIfUnknowError() {
        // Given
        converterService = ConverterService(
            converterSession: URLSessionFake(
                data: nil,
                response: FakeResponseData.responseKO,
                error: nil
        )
        )
        converterViewModel = ConverterViewModel(converterService: converterService)
        let ex = expectation(description: "")
        let text = "1"
        // When
        converterViewModel.errorHandler = { message in
            XCTAssertEqual(message, "Une erreur est survenue.")
            ex.fulfill()
        }
        // Then
        converterViewModel.getConvert(text: text)
        wait(for: [ex], timeout: 1)
        }
    
    func testErrorMessageIfWrongTextSend() {
        // Given
        let ex = expectation(description: "")
        let text = "Essaie"
        // When
        converterViewModel.errorHandler = { message in
            XCTAssertEqual(message, "Merci d'entrer une valeur correcte.")
            ex.fulfill()
        }
        // Then
        converterViewModel.getConvert(text: text)
        wait(for: [ex], timeout: 1)
        }
    
    func testFirstLabelCellAtTheLaunch() {
        let configView = converterViewModel.viewForHeader(in: 0)
        
        XCTAssertEqual(configView.largeContentTitle, "EUR")
        }
    
    func testSecondLabelCellAtTheLaunch() {
        let configView = converterViewModel.viewForHeader(in: 1)
        
        XCTAssertEqual(configView.largeContentTitle, "USD")
        }
    
    func testFirstLabelCellWhenConvertCurrencyHaveBeenSwitch() {
        converterViewModel.toggleCurrency()
        let configView = converterViewModel.viewForHeader(in: 0)
        
        XCTAssertEqual(configView.largeContentTitle, "USD")
        XCTAssertEqual(converterViewModel.currencySetup, ConverterViewModel.Currency.USDollar)
        }
    
    func testSecondLabelCellWhenConvertCurrencyHaveBeenSwitch() {
        converterViewModel.toggleCurrency()
        let configView = converterViewModel.viewForHeader(in: 1)
        
        XCTAssertEqual(configView.largeContentTitle, "EUR")
        XCTAssertEqual(converterViewModel.currencySetup, ConverterViewModel.Currency.USDollar)
        }
    }

