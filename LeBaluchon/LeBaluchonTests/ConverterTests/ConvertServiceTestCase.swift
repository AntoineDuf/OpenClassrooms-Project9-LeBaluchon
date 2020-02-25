//
//  ConvertServiceTestCase.swift
//  LeBaluchonTests
//
//  Created by Antoine Dufayet on 19/02/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

@testable import LeBaluchon
import XCTest

class ConverterServiceTestCase: XCTestCase {
    func testGetCurrencyShouldPostFailedCallbackIfError() {
        // Given
        let converterService = ConverterService(converterSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        converterService.getRate { (currency, error) in
            // Then
            XCTAssertNil(currency)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCurrencyShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let converterService = ConverterService(converterSession: URLSessionFake(data: FakeResponseData.converterCorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        converterService.getRate { (currency, error) in
            // Then
            XCTAssertNotNil(currency)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
