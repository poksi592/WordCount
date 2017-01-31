//
//  ArrayUtilities.swift
//  WordCount
//
//  Created by Despotovic, Mladen on 28/01/2017.
//  Copyright © 2017 Despotovic, Mladen. All rights reserved.
//

import Foundation

extension Array where Element: ExpressibleByStringLiteral {
    
    func lowercase() -> [String] {
        
        let newArray: [String] = self.map { (element) in
            
            if let element = element as? String {
                
                return element.localizedLowercase
            }
            else {
                return ""
            }
            
        }
        return newArray.flatMap { $0 }
    }
}
