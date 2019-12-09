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

    #if canImport(Foundation)
    /// Sejima: Returns a localized string, with an optional comment for translators.
    ///
    ///        "Hello world".localized -> Bonjour le monde
    ///
    public func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    #endif

    #if canImport(Foundation)
    /// Sejima: Check if string is valid email format.
    ///
    /// - Note: Note that this property does not validate the email address against an email server.
    /// It merely attempts to determine whether its format is suitable for an email address.
    ///
    ///        "john@doe.com".isValidEmail -> true
    ///        "❤️@❤️.com".isValidEmail -> true
    ///        "aa@❤️.co".isValidEmail -> true
    ///        "aa@aa.c".isValidEmail -> false
    ///        "a@a.co".isValidEmail -> false
    ///        "a@❤️.com".isValidEmail -> false
    ///        "aa@❤️.c".isValidEmail -> false
    ///
    public var isValidEmail: Bool {
        let regex = ".*@.*\\..{2,64}"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    #endif
}
