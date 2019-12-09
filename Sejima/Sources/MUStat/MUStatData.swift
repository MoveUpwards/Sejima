//
//  MUStatData.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 11/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// Struct that represent stat data
public struct MUStatData {
    /// Defines the icon
    public let image: UIImage?
    /// Defines the value
    public let value: String
    /// Defines the unit
    public let unit: String
    /// Defines the detail
    public let detail: String
    /// Defines the show / hide vertical separator
    public let showVerticalSeparator: Bool

    /// Init a stat data with default values
    public init(image: UIImage? = nil,
                value: String,
                unit: String,
                detail: String,
                showVerticalSeparator: Bool = true) {
        self.image = image
        self.value = value
        self.unit = unit
        self.detail = detail
        self.showVerticalSeparator = showVerticalSeparator
    }

    /// Return the given value in String for the defined format
    public static func value(for input: Double, format: String = "%.1f") -> String {
        // check if counting with ints - cast to int
        if nil != format.range(of: "%(.*)d", options: .regularExpression, range: nil)
            || nil != format.range(of: "%(.*)i") {
            return String(format: format, Int(input))
        } else {
            return String(format: format, input)
        }
    }
}
