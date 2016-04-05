//
//  RandomizerTests.swift
//  RandomizerTests
//
//  Created by Max Chuquimia on 5/04/2016.
//  Copyright © 2016 Chuquimian Productions. All rights reserved.
//

import XCTest
@testable import Randomizer

class RandomizerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRandomizer() {
        (0..<9999).forEach { _ in
            let result = Randomizer.zeroOrOne()
            
            XCTAssertTrue(result == 0 || result == 1, "Result should only ever be 0 or 1")
        }
    }
}
