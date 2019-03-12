//
//  MUCollectionItem.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 12/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// Describes a collection button item.
public struct MUCollectionItem {
    /// Specifies the item test.
    public let text: String
    /// Specifies an optional item image.
    public let image: UIImage?

    /// Init with some default values.
    public init(text: String, image: UIImage? = nil) {
        self.text = text
        self.image = image
    }
}
