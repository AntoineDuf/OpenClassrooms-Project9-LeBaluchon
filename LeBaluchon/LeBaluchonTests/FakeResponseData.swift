//
//  FakeResponseWeatherData.swift
//  LeBaluchonTests
//
//  Created by Antoine Dufayet on 19/02/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import Foundation

class FakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "test")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "test")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class APIsError: Error {}
    static let error = APIsError()
    
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var translatorCorrectDataFrenchToEnglish: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "TranslateFrenchToEnglish", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var translatorCorrectDataEnglishToFrench: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "TranslateEnglishToFrench", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var converterCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Currency", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let incorrectData = "erreur".data(using: .utf8)
    
}
