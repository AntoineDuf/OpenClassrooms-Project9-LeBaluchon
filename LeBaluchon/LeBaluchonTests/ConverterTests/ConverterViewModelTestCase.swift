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
    
    func testGivenTextViewHaveAText_WhenValidateButtonIsTappedAndCurrencySetupHasChanged_ThenConverterHandlerSendAResultInEuro() {
        converterViewModel.currencySetup = ConverterViewModel.Currency.USDollar
        converterViewModel.toggleCurrency()
        converterViewModel.getConvert(text: "1")
        
        XCTAssertNotNil(converterViewModel.converterHandler)
        }
    
    func testGivenTextViewHaveAText_WhenValidateButtonIsTappedAndCurrencySetupHasNotChanged_ThenConverterHandlerSendAResultInUsDollar() {
        converterViewModel.toggleCurrency()
        converterViewModel.getConvert(text: "1")
        
        XCTAssertNotNil(converterViewModel.converterHandler)
        }
    
    func testGivenTextViewHaveAText_WhenReafreshButtonIsTappedButNetworkCallSendbackNilData_ThenErrorHandlerSendAResult() {
        converterService = ConverterService(converterSession: URLSessionFake(data: nil, response: FakeResponseData.responseKO, error: nil))
        converterViewModel = ConverterViewModel(converterService: converterService)
        converterViewModel.getConvert(text: "1")
        
        XCTAssertNotNil(converterViewModel.errorHandler)
        }
    
    func testGivenFirstLabelCell_WhenViewDidLoad_ThenFirstLabellCellIsEUR() {
        let configView = converterViewModel.viewForHeader(in: 0)
        
        XCTAssertEqual(configView.largeContentTitle, "EUR")
        }
    
    func testGivenSecondLabelCell_WhenViewDidLoad_ThenSecondLabellCellIsUSD() {
        let configView = converterViewModel.viewForHeader(in: 1)
        
        XCTAssertEqual(configView.largeContentTitle, "USD")
        }
    
    func testGivenFirstLabelCell_WhenInverseButtonIsTapped_ThenFirstLabelCellIsUSD() {
        converterViewModel.toggleCurrency()
        let configView = converterViewModel.viewForHeader(in: 0)
        
        XCTAssertEqual(configView.largeContentTitle, "USD")
        }
    
    func testGivenSecondLabelCell_WhenInverseButtonIsTapped_ThenSecondLabelCellIsEUR() {
        converterViewModel.toggleCurrency()
        let configView = converterViewModel.viewForHeader(in: 1)
        
        XCTAssertEqual(configView.largeContentTitle, "EUR")
        }
    }

