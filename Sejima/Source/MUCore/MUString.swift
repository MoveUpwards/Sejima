//
//  MUString.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 05/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit

extension String {
    /// Check if string is valid with given regex
    internal func isValidRegex(_ regex: String) -> Bool {
        return !isEmpty && range(of: regex, options: .regularExpression) != nil
    }

    /// Check if string is only letters character set
    internal var isLetters: Bool {
        return CharacterSet.letters.isSuperset(of: CharacterSet(charactersIn: self))
    }

    /// Check if string is only digits character set
    internal var isDigits: Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }

    /// Check if string is only alpha numerics character set
    internal var isAlphanumerics: Bool {
        return CharacterSet.alphanumerics.isSuperset(of: CharacterSet(charactersIn: self))
    }

    /// Returns bounding box size for a given font
    internal func constrainedSize(width: CGFloat = .greatestFiniteMagnitude,
                                  height: CGFloat = .greatestFiniteMagnitude,
                                  font: UIFont) -> CGSize {
        let rect = CGSize(width: width, height: height)
        return self.boundingRect(with: rect,
                                 options: .usesLineFragmentOrigin,
                                 attributes: [.font: font],
                                 context: nil).size
    }
}
