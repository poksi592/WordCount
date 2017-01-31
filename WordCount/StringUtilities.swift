//
//  StringUtilities.swift
//  WordCount
//
//  Created by Despotovic, Mladen on 29/01/2017.
//  Copyright © 2017 Despotovic, Mladen. All rights reserved.
//

import Foundation

extension String {
    
    func replacePunctuation(with: String? = nil) -> String {
        
        // Better acceptance criteria would handle specially "'" and "-", since they both appear in wanted
        // and unwanter roles. "-" is used outside compound words as well and "'" is unfortunatelly used also 
        // when double quotes should be used.
        if let replaceString = with {
            
            return self.components(separatedBy: CharacterSet.punctuationCharacters).joined(separator: replaceString)
        }
        else {
            
            return self.components(separatedBy: CharacterSet.punctuationCharacters).joined(separator: "")
        }
    }
}
