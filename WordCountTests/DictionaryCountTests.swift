//
//  DictionaryCountTests.swift
//  WordCount
//
//  Created by Despotovic, Mladen on 29/01/2017.
//  Copyright © 2017 Despotovic, Mladen. All rights reserved.
//

import XCTest
@testable import WordCount

class DictionaryCountTests: XCTestCase {
    
    func test_Init() {
        
        let dictCounter = DictionaryWordCounter("Some text here")
        XCTAssertNotNil(dictCounter)
    }
    
    func testPrintingUniqueWords() {
        
        // Prepare
        let dictCounter = DictionaryWordCounter("Some text here")
        let testExpectation = expectation(description: "Test Expectation")
        // Execute and Test
        dictCounter.countWords(completion: { (countedWords) in
            
            XCTAssertNotNil(countedWords)
            XCTAssertEqual(dictCounter.countedWords["some"], 1)
            XCTAssertEqual(dictCounter.countedWords["text"], 1)
            XCTAssertEqual(dictCounter.countedWords["here"], 1)
            testExpectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        let numberOfWords = dictCounter.printUniqueWords()
        // Test
        XCTAssertEqual(numberOfWords, 3)
    }
    
    func testPrintingRepeatingWords() {
        
        // Prepare
        let dictCounter = DictionaryWordCounter("Some text here. And some more")
        let testExpectation = expectation(description: "Test Expectation")
        // Execute and Test
        dictCounter.countWords(completion: { (countedWords) in
            
            XCTAssertNotNil(countedWords)
            XCTAssertEqual(dictCounter.countedWords["some"], 2)
            XCTAssertEqual(dictCounter.countedWords["text"], 1)
            XCTAssertEqual(dictCounter.countedWords["here"], 1)
            testExpectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        let numberOfWords = dictCounter.printUniqueWords()
        // Test
        XCTAssertEqual(numberOfWords, 5)
    }
    
    func test_IgnoringPunctuation() {

        let dictCounter = DictionaryWordCounter("Apple.Apple")
        let testExpectation = expectation(description: "Test Expectation")
        // Execute and Test
        dictCounter.countWords(completion: { (countedWords) in
            
            XCTAssertNotNil(countedWords)
            XCTAssertEqual(dictCounter.countedWords["apple"], 2)
            testExpectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        let numberOfWords = dictCounter.printUniqueWords()
        // Test
        XCTAssertEqual(numberOfWords, 1)
    }
    
    func test_IgnoringPunctuationAndSpaceSingleWord() {
        
        let dictCounter = DictionaryWordCounter("Apple.   Apple")
        let testExpectation = expectation(description: "Test Expectation")
        // Execute and Test
        dictCounter.countWords(completion: { (countedWords) in
            
            XCTAssertNotNil(countedWords)
            XCTAssertEqual(dictCounter.countedWords["apple"], 2)
            testExpectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        let numberOfWords = dictCounter.printUniqueWords()
        // Test
        XCTAssertEqual(numberOfWords, 1)
    }
    
    func test_IgnoringPunctuationAndSpaceSentence() {
        
        let dictCounter = DictionaryWordCounter("I pick apples, apples are good. Apples make perfect Apfelstrudel.Mhmmmm,so good :)")
        let testExpectation = expectation(description: "Test Expectation")
        // Execute and Test
        dictCounter.countWords(completion: { (countedWords) in
            
            XCTAssertNotNil(countedWords)
            XCTAssertEqual(dictCounter.countedWords["apples"], 3)
            XCTAssertNil(dictCounter.countedWords["apple"])
            XCTAssertEqual(dictCounter.countedWords["apfelstrudel"], 1)
            XCTAssertEqual(dictCounter.countedWords["mhmmmm"], 1)
            testExpectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        let numberOfWords = dictCounter.printUniqueWords()
        // Test
        XCTAssertEqual(numberOfWords, 10)
    }
    
    func test_IgnoringPunctuationAndSpaceSentence_Synchronous() {
        
        // Prepare
        let dictCounter = DictionaryWordCounter("I pick apples, apples are good. Apples make perfect Apfelstrudel.Mhmmmm,so good :)")
        // Execute
        let countedWords = dictCounter.countWordsSync()
        
        // Test
        XCTAssertNotNil(countedWords)
        XCTAssertEqual(dictCounter.countedWords["apples"], 3)
        XCTAssertNil(dictCounter.countedWords["apple"])
        XCTAssertEqual(dictCounter.countedWords["apfelstrudel"], 1)
        XCTAssertEqual(dictCounter.countedWords["mhmmmm"], 1)

        let numberOfWords = dictCounter.printUniqueWords()
        // Test
        XCTAssertEqual(numberOfWords, 10)
    }
}
