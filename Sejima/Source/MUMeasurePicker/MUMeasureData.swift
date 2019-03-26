//
//  MUMeasureData.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 26/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import Foundation

/// Struct that represent measure data.
public struct MUMeasureData {
    /// Defines the minimum value.
    public let min: Int
    /// Defines the maximum value.
    public let max: Int
    /// Defines the units list.
    public let units: [String]

    /// Initializes and returns a newly allocated MUMeasureData.
    public init(min: Int, max: Int, units: [String]) {
        self.min = min
        self.max = max
        self.units = units
    }
}
