//
//  BagWordCounter
//  WordCount
//
//  Created by Despotovic, Mladen on 27/01/2017.
//  Copyright © 2017 Despotovic, Mladen. All rights reserved.
//

import Foundation

// It's a class, otherwise we can't make good reference to self in Dispatch closure.
class BagWordCounter: WordCountable {
    
    let text: String
    private var bag: NSCountedSet? = nil
    required init(_ text: String) {
        
        self.text = text
    }
    
    func countWords(completion: @escaping ([String : Int]?) -> ()) {
        
        // Executes asynchronously and doesn't make callback to main thread, because it assumes caller
        // can be from other threads apart from main.
        DispatchQueue.global().async { [weak self] in
            
            guard let strongSelf = self else { return }
            strongSelf.count()
            
            // It would be unefficient to convert NSCountedSet to Dictionary for the purpose of printing counted words
            // in separate function as it is,
            // so we don't create it unless specifically accessed getter method
            // consequently this callback returns nil, because there is no way yet in Swift 3
            // to make closure @escaping and optional at the same time
            completion(nil)
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
        bag = NSCountedSet(array: words)
    }
    
    lazy var countedWords: [String: Int] = {

        var resultDictionary: [String: Int] = [:]
        if let bag = self.bag {

            for element in bag {
                    
                if let element = element as? String {
                        
                    resultDictionary[element] = bag.count(for: element)
                }
            }
        }
        return resultDictionary
    }()
    
    func printUniqueWords() -> Int {
        
        if let bag = bag {
            
            for element in bag {
                
                print("Word: \(element)  Count: \(bag.count(for: element))")
            }
            return bag.count
        }
        else {
            return 0
        }
    }
}
