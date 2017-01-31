//
//  WordCountPerformanceTests.swift
//  WordCountPerformanceTests
//
//  Created by Despotovic, Mladen on 30/01/2017.
//  Copyright © 2017 Despotovic, Mladen. All rights reserved.
//

import XCTest
@testable import WordCount

class WordCountPerformanceTests: XCTestCase {
    
    var bundle: Bundle?
    
    override func setUp() {
        
        super.setUp()
        bundle = Bundle(for: type(of: self))
    }
    
    override func tearDown() {
        
        bundle = nil
        super.tearDown()
    }
    
    func test_ThirdOfBookDictionaryCounter() {
        
        // Prepare
        let filepath = Bundle.main.path(forResource: "example", ofType: "txt")
        let text = String.(contentsOf: URL.(fileURLWithPath: filepath, encoding: .utf8)
        let dictCounter = DictionaryWordCounter(text)
        // Execute
        
        self.measure {
            let countedWords = dictCounter.countWordsSync()
        }
    }
    
}
