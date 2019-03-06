//
//  MUProportionalView.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 06/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// Class that act like with dynamic size.
open class MUProportionalView: UIView {
    private var width = CGFloat(1.0)
    private var height = CGFloat(1.0)

    /// Define the view width
    open func set(width: CGFloat) {
        self.width = width
        height = 1.0
    }

    /// Define the view height
    open func set(height: CGFloat) {
        width = 1.0
        self.height = height
    }

    /// The natural size for the receiving view, considering only properties of the view itself.
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: width, height: height)
    }
}
