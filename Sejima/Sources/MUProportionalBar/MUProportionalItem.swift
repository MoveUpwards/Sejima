//
//  MUProportionalItem.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 06/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// Struct that define a specificly an item.
public struct MUProportionalItem {
    /// The item's value.
    public let value: CGFloat
    /// The current title.
    public let title: String
    /// The title’s text color.
    public let color: UIColor?

    /// Init with some default values
    public init(value: CGFloat, title: String, color: UIColor? = nil) {
        self.value = value
        self.title = title
        self.color = color
    }
}
