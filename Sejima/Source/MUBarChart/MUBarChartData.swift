//
//  MUBarChartData.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 12/09/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit.UIColor

/// Struct that represent the value / color association.
public struct MUBarChartValue {
    /// Defines the value.
    public let value: CGFloat
    /// Defines the color.
    public let color: UIColor

    /// Initializes and returns a newly allocated MUBarGraphData.
    public init(value: CGFloat, color: UIColor) {
        self.value = value
        self.color = color
    }
}

/// Struct that represent bar chart data.
public struct MUBarChartData {
    /// Defines the title.
    public let title: String
    /// Defines the values / colors of the bar(s).
    public let values: [MUBarChartValue]
    /// Defines if the value is visible.
    public let showValue: Bool
    /// Add all values to show it if needed
    public var totalValue: CGFloat {
        return values.map({ $0.value }).reduce(0, +)
    }

    /// Initializes and returns a newly allocated MUBarChartData.
    public init(title: String, values: [MUBarChartValue], showValue: Bool = false) {
        self.title = title
        self.values = values
        self.showValue = showValue
    }

    /// Initializes and returns a newly allocated MUBarChartData.
    public init(title: String, value: MUBarChartValue, showValue: Bool = false) {
        self.title = title
        self.values = [value]
        self.showValue = showValue
    }
}
