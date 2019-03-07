//
//  MUPinCodeCharacterSet.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 07/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import Foundation

/// Visual characters allow
public enum MUPinCodeCharacterSet: Equatable {
    /// Only numbers
    case number

    /// Only letters
    case letter

    /// Numbers and letters
    case alphanumeric

    /// No restriction
    case all

    /// Custom restriction
    case custom(rexep: String)
}
