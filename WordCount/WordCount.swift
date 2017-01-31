//
//  WordCount.swift
//  WordCount
//
//  Created by Despotovic, Mladen on 28/01/2017.
//  Copyright © 2017 Despotovic, Mladen. All rights reserved.
//

import Foundation

// It's a class, otherwise we can't make good reference to self in Dispatch closure in 'countWords'
protocol WordCountable: class {
    
    init(_ text: String)
    var countedWords: [String: Int] { get }
    func printUniqueWords() -> Int
    func countWords(completion: @escaping ([String: Int]?) -> ())
    
    // Synchronous version for smaller texts. ot the best naming, but Swift's poor polymorpism capabilities
    // prevent us to use same name with different signature
    // We could implement synchronous count into property 'countedWords', but it would be more complicated and could be
    // misleading to users
    func countWordsSync() -> [String: Int]
}

struct WordCount {
    
    private(set) var wordCounter: WordCountable
    
    init(wordCounter: WordCountable) {
        
        self.wordCounter = wordCounter
    }
    
    func printWordsSync() -> Int {
        
        _ = wordCounter.countWordsSync()
        return wordCounter.printUniqueWords()
    }
    
    func printWords(completion: @escaping ([String: Int]?) -> ()) {
        
        wordCounter.countWords { (words) in
            
            _ = self.wordCounter.printUniqueWords()
            completion(words)
        }
    }
}
