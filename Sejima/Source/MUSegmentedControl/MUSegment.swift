//
//  MUSegment.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 05/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// Struct that define a specificly a segment.
public struct MUSegmentItem {
    /// The current title.
    public let title: String
    /// The title’s font.
    public let titleFont: UIFont?
    /// The title’s text color.
    public let titleColor: UIColor?
    /// The title’s selected title color.
    public let selectedTitleColor: UIColor?
    /// The title’s selected background color.
    public let selectedColor: UIColor?

    /// Init with some default values
    public init(title: String,
                titleFont: UIFont? = nil,
                titleColor: UIColor? = nil,
                selectedTitleColor: UIColor? = nil,
                selectedColor: UIColor? = nil) {
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.selectedTitleColor = selectedTitleColor
        self.selectedColor = selectedColor
    }
}
