//
//  MUStatData.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 11/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit

public struct MUStatData {
    public let image: UIImage?
    public let format: String
    public let value: Double
    public let unit: String
    public let detail: String
    public let showSeparator: Bool

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
