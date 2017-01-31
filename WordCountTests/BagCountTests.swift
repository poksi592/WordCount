//
//  BagCountTests.swift
//  WordCount
//
//  Created by Despotovic, Mladen on 27/01/2017.
//  Copyright © 2017 Despotovic, Mladen. All rights reserved.
//

import XCTest
@testable import WordCount

class BagCountTests: XCTestCase {
    
    func test_BagCountInit() {
        
        // Prepare and execute
        let bagCounter = BagWordCounter("Some text here")
        // Test
        XCTAssertNotNil(bagCounter)
    }
    
    func testPrintingUniqueWords() {
        
        // Prepare
        let bagCounter = BagWordCounter("Some text here")
        let testExpectation = expectation(description: "Test Expectation")
        // Execute and Test
        bagCounter.countWords(completion: { (countedWords) in
            
            XCTAssertNil(countedWords)
            XCTAssertEqual(bagCounter.countedWords["some"], 1)
            XCTAssertEqual(bagCounter.countedWords["text"], 1)
            XCTAssertEqual(bagCounter.countedWords["here"], 1)
            testExpectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        let numberOfWords = bagCounter.printUniqueWords()
        // Test
        XCTAssertEqual(numberOfWords, 3)
    }
    
    func testPrintingRepeatingWords() {
        
        // Prepare
        let bagCounter = BagWordCounter("Some text here. And some more")
        let testExpectation = expectation(description: "Test Expectation")
        // Execute and Test
        bagCounter.countWords(completion: { (countedWords) in
            
            XCTAssertNil(countedWords)
            XCTAssertEqual(bagCounter.countedWords["some"], 2)
            XCTAssertEqual(bagCounter.countedWords["text"], 1)
            XCTAssertEqual(bagCounter.countedWords["here"], 1)
            testExpectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        let numberOfWords = bagCounter.printUniqueWords()
        // Test
        XCTAssertEqual(numberOfWords, 5)
    }
    
    func test_IgnoringPunctuation() {
        
        let bagCounter = BagWordCounter("Apple.Apple")
        let testExpectation = expectation(description: "Test Expectation")
        // Execute and Test
        bagCounter.countWords(completion: { (countedWords) in
            
            XCTAssertNil(countedWords)
            XCTAssertEqual(bagCounter.countedWords["apple"], 2)
            testExpectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        let numberOfWords = bagCounter.printUniqueWords()
        // Test
        XCTAssertEqual(numberOfWords, 1)
    }
    
    func test_IgnoringPunctuationAndSpace() {
        
        let bagCounter = BagWordCounter("Apple.   Apple")
        let testExpectation = expectation(description: "Test Expectation")
        // Execute and Test
        bagCounter.countWords(completion: { (countedWords) in
            
            XCTAssertNil(countedWords)
            XCTAssertEqual(bagCounter.countedWords["apple"], 2)
            testExpectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        let numberOfWords = bagCounter.printUniqueWords()
        // Test
        XCTAssertEqual(numberOfWords, 1)
    }
    
    func test_IgnoringPunctuationAndSpaceSentence() {
        
        let bagCounter = BagWordCounter("I pick apples, apples are good. Apples make perfect Apfelstrudel.Mhmmmm,so good :)")
        let testExpectation = expectation(description: "Test Expectation")
        // Execute and Test
        bagCounter.countWords(completion: { (countedWords) in
            
            XCTAssertNil(countedWords)
            XCTAssertEqual(bagCounter.countedWords["apples"], 3)
            XCTAssertNil(bagCounter.countedWords["apple"])
            XCTAssertEqual(bagCounter.countedWords["apfelstrudel"], 1)
            XCTAssertEqual(bagCounter.countedWords["mhmmmm"], 1)
            testExpectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        let numberOfWords = bagCounter.printUniqueWords()
        // Test
        XCTAssertEqual(numberOfWords, 10)
    }
    
    func test_IgnoringPunctuationAndSpaceSentence_Synchronous() {
        
        // Prepare
        let bagCounter = BagWordCounter("I pick apples, apples are good. Apples make perfect Apfelstrudel.Mhmmmm,so good :)")
        // Execute
        let countedWords = bagCounter.countWordsSync()
        
        // Test
        XCTAssertNotNil(countedWords)
        XCTAssertEqual(bagCounter.countedWords["apples"], 3)
        XCTAssertNil(bagCounter.countedWords["apple"])
        XCTAssertEqual(bagCounter.countedWords["apfelstrudel"], 1)
        XCTAssertEqual(bagCounter.countedWords["mhmmmm"], 1)
        
        let numberOfWords = bagCounter.printUniqueWords()
        // Test
        XCTAssertEqual(numberOfWords, 10)
    }
    
}
