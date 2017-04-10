//
//  PokedexGoTests.swift
//  PokedexGoTests
//
//  Created by JIAWEI CHEN on 3/1/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import XCTest
@testable import PokedexGo


class PokedexGoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let s = PGHelper.imageUrlOfPokemon(width: 240, num: 1).absoluteString
        XCTAssert(s == "https://pokedex.me/new-pokemon/240/001.png", "pokemon image url correct")
    }
    
    
    func testEffectArray() {
        let s = PGHelper.effectOn(pokemonTypes: [1, 2])
        XCTAssert(s != nil, "get effect object")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
