//
//  WordCountTests.swift
//  WordCountTests
//
//  Created by Despotovic, Mladen on 27/01/2017.
//  Copyright © 2017 Despotovic, Mladen. All rights reserved.
//

import XCTest
@testable import WordCount

class WordCountTests: XCTestCase {
    
    var bundle: Bundle?
    
    override func setUp() {
        
        super.setUp()
        bundle = Bundle(for: type(of: self))
    }
    
    override func tearDown() {
        
        bundle = nil
        super.tearDown()
    }
    
    func test_InitWithMockCounter() {
        
        let wordCounter = MockWordCounter("Some text here")
        XCTAssertNotNil(wordCounter)
        
        let wordCount = WordCount(wordCounter: wordCounter)
        XCTAssertNotNil(wordCount)
        XCTAssertNotNil(wordCount.wordCounter)
    }
    
    func test_SentenceBagCount() {
        
        // Sentence example that has same words of different cases, punctuation and no space after punctuation.
        let testSomeText = "I pick apples, apples are good. Apples make perfect Apfelstrudel.Mhmmmm,so good :)"
        let bagCounter = BagWordCounter(testSomeText)
        let wordCount = WordCount(wordCounter: bagCounter)
        let count = wordCount.printWordsSync()
        
        XCTAssertNotNil(wordCount)
        XCTAssertNotNil(wordCount.wordCounter)
        XCTAssertEqual(count, 10)
    }
    
    func test_SentenceDictionaryCount() {
        
        // Sentence example that has same words of different cases, punctuation and no space after punctuation.
        let testSomeText = "I pick apples, apples are good. Apples make perfect Apfelstrudel.Mhmmmm,so good :)"
        let dictionaryCounter = DictionaryWordCounter(testSomeText)
        let wordCount = WordCount(wordCounter: dictionaryCounter)
        let count = wordCount.printWordsSync()
        
        XCTAssertNotNil(wordCount)
        XCTAssertNotNil(wordCount.wordCounter)
        XCTAssertEqual(count, 10)
    }
    
    func test_ThirdOfBookDictionaryCounter() {
        
        // Prepare
        let filepath = bundle?.path(forResource: "ThirdOfBook", ofType: "txt")
        let text = try! String(contentsOf: URL(fileURLWithPath: filepath!), encoding: .utf8)
        let dictCounter = DictionaryWordCounter(text)
        
        // Execute
        self.measure {
            _ = dictCounter.countWordsSync()
        }
    }
    
    func test_ThirdOfBookDictionaryCounter_Print() {
        
        // Prepare
        let filepath = bundle?.path(forResource: "ThirdOfBook", ofType: "txt")
        let text = try! String(contentsOf: URL(fileURLWithPath: filepath!), encoding: .utf8)
        let dictCounter = DictionaryWordCounter(text)
        let wordCount = WordCount(wordCounter: dictCounter)
        // Execute
        
        self.measure {
            _ = wordCount.printWordsSync()
        }
    }
    
    func test_ThirdOfBookBagCounter() {
        
        // Prepare
        let filepath = bundle?.path(forResource: "ThirdOfBook", ofType: "txt")
        let text = try! String(contentsOf: URL(fileURLWithPath: filepath!), encoding: .utf8)
        let bagCounter = BagWordCounter(text)
        
        // Execute
        self.measure {
            _ = bagCounter.countWordsSync()
        }
    }
    
    func test_ThirdOfBookBagCounter_Print() {
        
        // Prepare
        let filepath = bundle?.path(forResource: "ThirdOfBook", ofType: "txt")
        let text = try! String(contentsOf: URL(fileURLWithPath: filepath!), encoding: .utf8)
        let bagCounter = BagWordCounter(text)
        let wordCount = WordCount(wordCounter: bagCounter)
        // Execute
        
        self.measure {
            _ = wordCount.printWordsSync()
        }
    }
    
    func test_WholeBookDictionaryCounter() {
        
        // Prepare
        let filepath = bundle?.path(forResource: "WholeBook", ofType: "txt")
        let text = try! String(contentsOf: URL(fileURLWithPath: filepath!), encoding: .utf8)
        let dictCounter = DictionaryWordCounter(text)
        
        // Execute
        self.measure {
            _ = dictCounter.countWordsSync()
        }
    }
    
    func test_WholeBookDictionaryCounter_Print() {
        
        // Prepare
        let filepath = bundle?.path(forResource: "WholeBook", ofType: "txt")
        let text = try! String(contentsOf: URL(fileURLWithPath: filepath!), encoding: .utf8)
        let dictCounter = DictionaryWordCounter(text)
        let wordCount = WordCount(wordCounter: dictCounter)
        // Execute
        
        self.measure {
            _ = wordCount.printWordsSync()
        }
    }
    
    func test_WholeBookBagCounter() {
        
        // Prepare
        let filepath = bundle?.path(forResource: "WholeBook", ofType: "txt")
        let text = try! String(contentsOf: URL(fileURLWithPath: filepath!), encoding: .utf8)
        let bagCounter = BagWordCounter(text)
        
        // Execute
        self.measure {
            _ = bagCounter.countWordsSync()
        }
    }
    
    func test_WholeBookBagCounter_Print() {
        
        // Prepare
        let filepath = bundle?.path(forResource: "WholeBook", ofType: "txt")
        let text = try! String(contentsOf: URL(fileURLWithPath: filepath!), encoding: .utf8)
        let bagCounter = BagWordCounter(text)
        let wordCount = WordCount(wordCounter: bagCounter)
        // Execute
        
        self.measure {
            _ = wordCount.printWordsSync()
        }
    }
    
    func test_CountedNumberControl() {
        
        // Prepare
        let filepath = bundle?.path(forResource: "WholeBook", ofType: "txt")
        let text = try! String(contentsOf: URL(fileURLWithPath: filepath!), encoding: .utf8)
        let bagCounter = BagWordCounter(text)
        let dictCounter = DictionaryWordCounter(text)
        
        // Execute
        let bagCount = bagCounter.countWordsSync()
        let dictCount = dictCounter.countWordsSync()
        XCTAssertEqual(bagCount, dictCount)
    }
}

class MockWordCounter: WordCountable {
    
    private(set) var countedWords: [String: Int] = [:]
    let text: String
    required init(_ text: String) {
        
        self.text = text
    }
    
    func printUniqueWords() -> Int {
        
        return 0
    }
    
    func countWords(completion: @escaping ([String : Int]?) -> ()) {
        
    }
    
    func countWordsSync() -> [String : Int] {
        
        return countedWords
    }
}
