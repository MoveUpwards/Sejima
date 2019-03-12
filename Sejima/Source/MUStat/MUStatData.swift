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
    /// Defines the format
    public let format: String
    /// Defines the value
    public let value: Double
    /// Defines the unit
    public let unit: String
    /// Defines the detail
    public let detail: String
    /// Defines the show / hide separator
    public let showSeparator: Bool

    /// Init a stat data with default values
    public init(image: UIImage? = nil,
                format: String = "%.f",
                value: Double,
                unit: String,
                detail: String,
                showSeparator: Bool = true) {
        self.image = image
        self.format = format
        self.value = value
        self.unit = unit
        self.detail = detail
        self.showSeparator = showSeparator
    }
}
