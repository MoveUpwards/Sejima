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
    /// The title’s selected background color.
    public let selectedColor: UIColor?

    /// The current title.
    public let title: String?
    /// The title’s font.
    public let titleFont: UIFont?
    /// The title’s text color.
    public let titleColor: UIColor?
    /// The title’s selected title color.
    public let selectedTitleColor: UIColor?

    /// The item image.
    public let image: UIImage?
    /// The item selected image.
    public let selectedImage: UIImage?
    /// The image’s tint color.
    public let imageColor: UIColor?
    /// The selected image’s tint color.
    public let selectedImageColor: UIColor?

    /// Init with title
    public init(title: String,
                titleFont: UIFont? = nil,
                titleColor: UIColor? = nil,
                selectedTitleColor: UIColor? = nil,
                selectedColor: UIColor? = nil) {
        self.selectedColor = selectedColor

        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.selectedTitleColor = selectedTitleColor

        self.image = nil
        self.imageColor = nil
        self.selectedImage = nil
        self.selectedImageColor = nil
    }

    /// Init with image
    public init(image: UIImage,
                imageColor: UIColor? = nil,
                selectedImage: UIImage? = nil,
                selectedImageColor: UIColor? = nil,
                selectedColor: UIColor? = nil) {
        self.selectedColor = selectedColor

        self.image = image
        self.imageColor = imageColor
        self.selectedImage = selectedImage
        self.selectedImageColor = selectedImageColor

        self.title = nil
        self.titleFont = nil
        self.titleColor = nil
        self.selectedTitleColor = nil
    }
}
