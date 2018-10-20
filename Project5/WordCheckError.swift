//
//  WordCheckError.swift
//  Project5
//
//  Created by Gavin Butler on 2018-10-19.
//  Copyright © 2018 Gavin Butler. All rights reserved.
//

import Foundation

enum WordCheckError: String {
    case notPossible
    case notOriginal
    case notReal
    case notLongEnough
    case sameWord
}

extension WordCheckError {
    
    var title: String {
        switch self {
        case .notPossible: return "Word not possible"
        case .notOriginal: return "Word used already"
        case .notReal: return "Word not recognized"
        case .notLongEnough: return "Word not long enough"
        case .sameWord: return "Word cannot be identical"
        }
    }
    
    var message: String {
        switch self {
        case .notPossible: return "You can't spell that word from the letters above"
        case .notOriginal: return "Word used already"
        case .notReal: return "Word not recognized in english"
        case .notLongEnough: return "Word must be at least 3 letters long"
        case .sameWord: return "Word must be a subset of the word above"
        }
    }
}
