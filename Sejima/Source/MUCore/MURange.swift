//
//  MURange.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 15/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import Foundation

/// Class that act like NSRange and Range merged.
public struct MURange<Bound: Numeric> {
    /// NSRange location equivalent
    public var location: Bound
    /// NSRange length equivalent
    public var length: Bound

    /// Initializes and returns a newly allocated MURange.
    public init(location: Bound, length: Bound) {
        self.location = location
        self.length = length
    }

    /// Range lowerBound equivalent
    public var lowerBound: Bound {
        get {
            return location
        }
        set {
            location = newValue
        }
    }

    /// Range upperBound equivalent
    public var upperBound: Bound {
        get {
            return location + length
        }
        set {
            length = newValue - location
        }
    }
}
