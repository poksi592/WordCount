//
//  ArrayUtilitiesTests.swift
//  WordCount
//
//  Created by Despotovic, Mladen on 28/01/2017.
//  Copyright © 2017 Despotovic, Mladen. All rights reserved.
//

import XCTest
@testable import WordCount

class ArrayUtilitiesTests: XCTestCase {
    
    func test_LowercaseEmptyString() {
        
        let array = [""]
        let lowercaseArray = array.lowercase()
        XCTAssertEqual(lowercaseArray.count, 1)
    }
    
    func test_LowercaseLowercaseStrings() {
        
        let array = ["some", "lowercase", "strings"]
        let lowercaseArray = array.lowercase()
        XCTAssertEqual(lowercaseArray.count, 3)
        XCTAssertEqual(lowercaseArray[0], "some")
        XCTAssertEqual(lowercaseArray[1], "lowercase")
        XCTAssertEqual(lowercaseArray[2], "strings")
    }
    
    func test_LowercaseUppercaseStrings() {
        
        let array = ["SOME", "lowercase", "strings"]
        let lowercaseArray = array.lowercase()
        XCTAssertEqual(lowercaseArray.count, 3)
        XCTAssertEqual(lowercaseArray[0], "some")
        XCTAssertEqual(lowercaseArray[1], "lowercase")
        XCTAssertEqual(lowercaseArray[2], "strings")
    }
    
    func test_LowercaseAllUppercaseStrings() {
        
        let array = ["SOME", "LOWERCASE", "STRINGS"]
        let lowercaseArray = array.lowercase()
        XCTAssertEqual(lowercaseArray.count, 3)
        XCTAssertEqual(lowercaseArray[0], "some")
        XCTAssertEqual(lowercaseArray[1], "lowercase")
        XCTAssertEqual(lowercaseArray[2], "strings")
    }
    
    func test_LowercaseMixedUppercaseStrings() {
        
        let array = ["sOME", "Lowercase", "STRINGS"]
        let lowercaseArray = array.lowercase()
        XCTAssertEqual(lowercaseArray.count, 3)
        XCTAssertEqual(lowercaseArray[0], "some")
        XCTAssertEqual(lowercaseArray[1], "lowercase")
        XCTAssertEqual(lowercaseArray[2], "strings")
    }
    
}
