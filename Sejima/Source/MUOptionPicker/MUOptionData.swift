//
//  MUOptionData.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 15/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit.UIImage

/// Struct that represent option data.
public struct MUOptionData {
    /// Defines the image.
    public let image: UIImage?
    /// Defines the title.
    public let text: String

    /// Initializes and returns a newly allocated MUOptionData.
    public init(text: String, image: UIImage? = nil) {
        self.image = image
        self.text = text
    }
}
