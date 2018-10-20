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
}

extension WordCheckError {
    
    var title: String {
        switch self {
        case .notPossible: return "Word not possible"
        case .notOriginal: return "Word used already"
        case .notReal: return "Word not recognized"
        }
    }
    
    var message: String {
        switch self {
        case .notPossible: return "You can't spell that word from the letters above"
        case .notOriginal: return "Word used already"
        case .notReal: return "Word not recognized in english"
        }
    }
}
