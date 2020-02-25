//
//  TranslatorServiceTestCase.swift
//  LeBaluchonTests
//
//  Created by Antoine Dufayet on 19/02/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

@testable import LeBaluchon
import XCTest

class TranslatorServiceTestCase: XCTestCase {
    func testPostTranslationShouldPostFailedCallbackIfError() {
        // Given
        let translatorService = TranslatorService(translatorSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translatorService.postTranslation(textToTranslate: "Bonjour", languageIndex: 0) { (translation, error) in
            // Then
            XCTAssertNil(translation)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testPostTranslationShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let translatorService = TranslatorService(translatorSession: URLSessionFake(data: FakeResponseData.translatorCorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translatorService.postTranslation(textToTranslate: "Bonjour", languageIndex: 0) { (translation, error) in
            // Then
            XCTAssertNotNil(translation)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
