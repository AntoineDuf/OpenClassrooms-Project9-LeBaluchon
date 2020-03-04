//
//  TranslatorViewModelTestCase.swift
//  LeBaluchonTests
//
//  Created by Antoine Dufayet on 24/02/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import Foundation

@testable import LeBaluchon
import XCTest

class TranslatorViewModelTestCase: XCTestCase {
    var translatorViewModel: TranslatorViewModel!
    var translatorService: TranslatorService!
    
    override func setUp() {
        super.setUp()
        translatorService = TranslatorService(
            translatorSession: URLSessionFake(
                data: FakeResponseData.translatorCorrectDataFrenchToEnglish,
                response: FakeResponseData.responseOK,
                error: nil
            )
        )
        translatorViewModel = TranslatorViewModel(translatorService: translatorService)
    }
    
    override func tearDown() {
        translatorViewModel = nil
        super.tearDown()
    }
    
    func testTranslateInEnglish() {
        // Given:
        let ex = expectation(description: "")
        let text = "Bonjour"
        // When:
        translatorViewModel.selectedLanguage = TranslatorViewModel.Languages.English
        translatorViewModel.toggleLanguage()
        translatorViewModel.translateHandler = { translations in             XCTAssertEqual(translations.count, 1)
            XCTAssertEqual(translations.first?.translatedText, "Hello")
            XCTAssertEqual(self.translatorViewModel.selectedLanguage, TranslatorViewModel.Languages.French)
            ex.fulfill()
        }
        // Then:
        translatorViewModel.translate(text: text)
        wait(for: [ex], timeout: 1)
    }
    
    func testTranslateInFrench() {
        // Given:
        translatorService = TranslatorService(
            translatorSession: URLSessionFake(
                data: FakeResponseData.translatorCorrectDataEnglishToFrench,
                response: FakeResponseData.responseOK,
                error: nil
            )
        )
        translatorViewModel = TranslatorViewModel(translatorService: translatorService)
        let ex = expectation(description: "")
        let text = "Hello"
        // When:
        translatorViewModel.toggleLanguage()
        translatorViewModel.translateHandler = { translations in             XCTAssertEqual(translations.count, 1)
            XCTAssertEqual(translations.first?.translatedText, "Bonjour")
            ex.fulfill()
        }
        // Then:
        translatorViewModel.translate(text: text)
        wait(for: [ex], timeout: 1)
        XCTAssertEqual(translatorViewModel.selectedLanguage, TranslatorViewModel.Languages.English)
    }
    
    func testErrorMessage() {
        //given
        translatorService = TranslatorService(
            translatorSession: URLSessionFake(
                data: nil,
                response: FakeResponseData.responseKO,
                error: nil
            )
        )
        translatorViewModel = TranslatorViewModel(translatorService: translatorService)
        let ex = expectation(description: "")
        let text = "Bonjour"
        //When :
        translatorViewModel.errorHandler = { message in
            XCTAssertEqual(message, "Une erreur est survenue.")
            ex.fulfill()
        }
        //Then :
        translatorViewModel.translate(text: text)
        wait(for: [ex], timeout: 1)
    }
    
    func testFirstLabelCellAtTheLaunch() {
        let configView = translatorViewModel.viewForHeader(in: 0)
        
        XCTAssertEqual(configView.largeContentTitle, "Français")
        XCTAssertEqual(translatorViewModel.selectedLanguage, TranslatorViewModel.Languages.French)
    }
    
    func testSecondLabelCellAtTheLaunch() {
        let configView = translatorViewModel.viewForHeader(in: 1)
        
        XCTAssertEqual(configView.largeContentTitle, "Anglais")
        XCTAssertEqual(translatorViewModel.selectedLanguage, TranslatorViewModel.Languages.French)
    }
    
    func testFirstLabelCellWhenTheTranslationLanguageHaveBeenSwitch() {
        translatorViewModel.toggleLanguage()
        let configView = translatorViewModel.viewForHeader(in: 0)
        
        XCTAssertEqual(configView.largeContentTitle, "Anglais")
        XCTAssertEqual(translatorViewModel.selectedLanguage, TranslatorViewModel.Languages.English)
    }
    
    func testSecondLabelCellWhenTheTranslationLanguageHaveBeenSwitch() {
        translatorViewModel.toggleLanguage()
        let configView = translatorViewModel.viewForHeader(in: 1)
        
        XCTAssertEqual(configView.largeContentTitle, "Français")
        XCTAssertEqual(translatorViewModel.selectedLanguage, TranslatorViewModel.Languages.English)
    }
}
