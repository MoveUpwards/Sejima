//
//  MUBarGraphData.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 25/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit.UIColor

/// Struct that represent bar data.
public struct MUBarGraphData {
    /// Defines the title.
    public let title: String
    /// Defines the value.
    public let value: CGFloat
    /// Defines the color.
    public let color: UIColor
    /// Show / hide the indicator.
    public let showIndicator: Bool

    /// Initializes and returns a newly allocated MUBarGraphData.
    public init(title: String, value: CGFloat, color: UIColor, showIndicator: Bool = false) {
        self.title = title
        self.value = value
        self.color = color
        self.showIndicator = showIndicator
    }
}
