//
//  DictionaryWordCounter.swift
//  WordCount
//
//  Created by Despotovic, Mladen on 29/01/2017.
//  Copyright © 2017 Despotovic, Mladen. All rights reserved.
//

import Foundation

class DictionaryWordCounter: WordCountable {
    
    let text: String
    // Since we perform counting ourselves here, we are exposing this variable to test
    private(set) var countedWords: [String: Int] = [:]
    
    required init(_ text: String) {
        
        self.text = text
    }
    
    func countWords(completion: @escaping ([String : Int]?) -> ()) {
        
        // Executes asynchronously and doesn't make callback to main thread, because it assumes caller
        // can be from other threads apart from main.
        DispatchQueue.global().async { [weak self] in
            
            guard let strongSelf = self else { return }
            strongSelf.count()
            
            // Returns result in callback, however, the same is accessible from class member, too
            completion(strongSelf.countedWords)
        }
    }
    
    func countWordsSync() -> [String : Int] {
        
        count()
        return countedWords
    }
    
    private func count() {
        
        // Replacing punctuations with " " to handle text without space after punctuation
        let textWithoutPunctuation = text.replacePunctuation(with: " ")
        let words = textWithoutPunctuation.components(separatedBy: " ").lowercase().filter { $0 != "" }
        
        // 'countedWords' are initialised each time before the count in case this function is called more than once
        countedWords = [:]
        for word in words {
            
            if let count = countedWords[word], count > 0 {
                
                countedWords[word] = count + 1
            }
            else {
                
                countedWords[word] = 1
            }
        }
    }
    
    func printUniqueWords() -> Int {
        
        for (key, value) in countedWords {
            
            print("Word: \(key)  Count: \(value)")
        }
        return countedWords.count
    }
}
