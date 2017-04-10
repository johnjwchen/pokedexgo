//
//  PokedexGoUITests.swift
//  PokedexGoUITests
//
//  Created by JIAWEI CHEN on 3/1/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import XCTest

class PokedexGoUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        
    
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        testExample()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        app.buttons["Search"].tap()
        tablesQuery.staticTexts["Arbok"].tap()
        
        tablesQuery.staticTexts["Poison"].tap()
        tablesQuery.staticTexts["Ariados"].tap()
        
        tablesQuery.staticTexts["Poison"].tap()
        tablesQuery.staticTexts["Beedrill"].tap()
        
        tablesQuery.staticTexts["Poison"].tap()
        tablesQuery.staticTexts["Bellsprout"].tap()
        
        tablesQuery.staticTexts["Poison"].tap()
        tablesQuery.staticTexts["Bulbasaur"].tap()
        
        tablesQuery.staticTexts["Poison"].tap()
        tablesQuery.staticTexts["Crobat"].tap()
        
        
        //        let tablesQuery = tablesQuery2
//        tablesQuery.cells.containing(.button, identifier:"More Info, Grass, Poison").staticTexts["Poison"].tap()
//        
//        let tablesQuery2 = tablesQuery
//        tablesQuery2.staticTexts["Ariados"].tap()
//        tablesQuery2.staticTexts["Beedrill"].tap()
        
        
    }
    
}
