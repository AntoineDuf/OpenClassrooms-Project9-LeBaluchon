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
        translatorService = TranslatorService(translatorSession: URLSessionFake(data: FakeResponseData.translatorCorrectData, response: FakeResponseData.responseOK, error: nil))
        translatorViewModel = TranslatorViewModel(translatorService: translatorService)
    }
    
    override func tearDown() {
        translatorViewModel = nil
        super.tearDown()
    }
    
    func testGivenTextViewHaveAText_WhenValidateButtonIsTappedAndLanguageSetupHasChanged_ThenTranslateHandlerSendAResultInFrench() {
        translatorViewModel.selectedLanguage = TranslatorViewModel.Languages.English
        translatorViewModel.toggleLanguage()
        translatorViewModel.translate(text: "Hello")
        
        XCTAssertNotNil(translatorViewModel.translateHandler)
        }
    
    func testGivenTextViewHaveAText_WhenValidateButtonIsTappedAndLanguageSetupHasNotChanged_ThenTranslateHandlerSendAResultInEnglis() {
        translatorViewModel.toggleLanguage()
        translatorViewModel.translate(text: "Bonjour")
        XCTAssertNotNil(translatorViewModel.translateHandler)
        }
    
    func testGivenTextViewHaveAText_WhenReafreshButtonIsTappedButNetworkCallSendbackNilData_ThenErrorHandlerSendAResult() {
        translatorService = TranslatorService(translatorSession: URLSessionFake(data: nil, response: FakeResponseData.responseKO, error: nil))
        translatorViewModel = TranslatorViewModel(translatorService: translatorService)
        translatorViewModel.translate(text: "Bonjour")
        
        XCTAssertNotNil(translatorViewModel.errorHandler)
        }
    
    func testGivenFirstLabelCell_WhenViewDidLoad_ThenFirstLabellCellIsFrench() {
        let configView = translatorViewModel.viewForHeader(in: 0)
        
        XCTAssertEqual(configView.largeContentTitle, "Français")
        }
    
    func testGivenSecondLabelCell_WhenViewDidLoad_ThenSecondLabellCellIsEnglish() {
        let configView = translatorViewModel.viewForHeader(in: 1)
        
        XCTAssertEqual(configView.largeContentTitle, "Anglais")
        }
    
    func testGivenFirstLabelCell_WhenInverseButtonIsTapped_ThenFirstLabelCellIsEnglish() {
        translatorViewModel.toggleLanguage()
        let configView = translatorViewModel.viewForHeader(in: 0)
        
        XCTAssertEqual(configView.largeContentTitle, "Anglais")
        }
    
    func testGivenSecondLabelCell_WhenInverseButtonIsTapped_ThenSecondLabelCellIsFrench() {
        translatorViewModel.toggleLanguage()
        let configView = translatorViewModel.viewForHeader(in: 1)
        
        XCTAssertEqual(configView.largeContentTitle, "Français")
        }
    }
