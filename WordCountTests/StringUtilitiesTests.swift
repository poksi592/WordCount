//
//  StringUtilitiesTests.swift
//  WordCount
//
//  Created by Despotovic, Mladen on 29/01/2017.
//  Copyright © 2017 Despotovic, Mladen. All rights reserved.
//

import XCTest
@testable import WordCount

class StringUtilitiesTests: XCTestCase {
    
    func test_ReplacePunctuation() {
        
        let testEmptyString = ""
        let cleanString1 = testEmptyString.replacePunctuation(with: "")
        XCTAssertEqual(cleanString1, "")
        
        let testNoPunctuationString = " Some string "
        let cleanString2 = testNoPunctuationString.replacePunctuation(with: "")
        XCTAssertEqual(cleanString2, " Some string ")
        
        let testSinglePunctuationString1 = "."
        let cleanString3 = testSinglePunctuationString1.replacePunctuation(with: "")
        XCTAssertEqual(cleanString3, "")
        
        let testSinglePunctuationString2 = "."
        let cleanString4 = testSinglePunctuationString2.replacePunctuation()
        XCTAssertEqual(cleanString4, "")
        
        let testSinglePunctuationString3 = "."
        let cleanString5 = testSinglePunctuationString3.replacePunctuation(with: " ")
        XCTAssertEqual(cleanString5, " ")
        
        let testAllPunctuationString1 = ".,;:'\"()!?-_"
        let cleanString7 = testAllPunctuationString1.replacePunctuation(with: " ")
        XCTAssertEqual(cleanString7, "            ")
        
        let testAllPunctuationString2 = ".,;:'\"()!?-_"
        let cleanString8 = testAllPunctuationString2.replacePunctuation()
        XCTAssertEqual(cleanString8, "")
        
        let testSomeText = "And then she stopped, turned around and said: \"How did we get here?\""
        let cleanString9 = testSomeText.replacePunctuation()
        XCTAssertEqual(cleanString9, "And then she stopped turned around and said How did we get here")
    }
}
