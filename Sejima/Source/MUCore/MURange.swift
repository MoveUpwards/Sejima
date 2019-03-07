//
//  MURange.swift
//  MUComponent
//
//  Created by Loïc GRIFFIE on 15/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import Foundation

/// A class that create a weak target to avoid retain cycles.
public struct MURange<Bound: Numeric> {
    ///
    public var location: Bound
    /// 
    public var length: Bound

    /// Initializes and returns a newly allocated MURange.
    public init(location: Bound, length: Bound) {
        self.location = location
        self.length = length
    }

    ///
    public var lowerBound: Bound {
        get {
            return location
        }
        set {
            location = newValue
        }
    }

    ///
    public var upperBound: Bound {
        get {
            return location + length
        }
        set {
            length = newValue - location
        }
    }
}

extension Range where Bound: Numeric {
    /// NSRange(location: Int, length: Int) style
    public init(location: Bound, length: Bound) {
        self.init(uncheckedBounds: (lower: location, upper: location + length))
    }

    public var location: Bound {
        return lowerBound // Get ONLY as lowerBound is a constant
    }

    public var length: Bound {
        return upperBound - lowerBound // Get ONLY as upperBound is a constant
    }
}

extension Range where Bound == String.Index {
    internal var nsRange: NSRange {
        return NSRange(location: lowerBound.encodedOffset,
                       length: upperBound.encodedOffset - lowerBound.encodedOffset)
    }
}
