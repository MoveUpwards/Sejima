//
//  MUString.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 05/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import Foundation

extension String {
    internal func isValidRegex(_ regex: String) -> Bool {
        return !isEmpty && range(of: regex, options: .regularExpression) == nil
    }

    internal var isLetters: Bool {
        return CharacterSet.letters.isSuperset(of: CharacterSet(charactersIn: self))
    }

    internal var isDigits: Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }

    internal var isAlphanumerics: Bool {
        return CharacterSet.alphanumerics.isSuperset(of: CharacterSet(charactersIn: self))
    }
}
