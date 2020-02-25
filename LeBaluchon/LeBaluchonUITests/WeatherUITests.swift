//
//  WeatherUITests.swift
//  LeBaluchonUITests
//
//  Created by Antoine Dufayet on 25/02/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import XCTest

class WeatherUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        
    }
    
    func SwipTest() {
        app.navigationBars["Traducteur"].tap()
        XCTAssert(app.navigationBars["Traducteur"].exists)
    }
}
