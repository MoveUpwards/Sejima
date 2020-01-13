//
//  MUOverlay.swift
//  MUComponent
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Class that generate overlay with customizable options.
@IBDesignable
open class MUOverlay: MUNibView {
    @IBOutlet private var overlay: UIView!

    /// Describes the Overlay's border width appearance while it shows
    @IBInspectable open dynamic var borderWidth: CGFloat = 0.0 {
        didSet {
            overlay.layer.borderWidth = borderWidth
        }
    }

    /// Describes the Overlay's border color appearance while it shows
    @IBInspectable open dynamic var borderColor: UIColor = .black {
        didSet {
            overlay.layer.borderColor = borderColor.cgColor
        }
    }

    /// The overlay's style.
    open var style: MUCornerStyle = .square {
        didSet {
            updateStyle()
        }
    }

    /// Optional: The IBInspectable version of the overlay's style.
    @IBInspectable open dynamic var styleInt: Int = 0 {
        didSet {
            switch styleInt {
            case 0:
                style = .square
            case 1:
                style = .round
            default:
                style = .custom(radius)
            }
        }
    }

    /// The overlay's corner radius.
    @IBInspectable open dynamic var radius: CGFloat = 0.0 {
        didSet {
            guard radius > 0 else {
                return
            }
            style = .custom(radius)
        }
    }

    // MARK: - Private functions

    private func updateStyle() {
        switch style {
        case .round:
            layer.cornerRadius = bounds.size.width * 0.5
        case .custom(let radius):
            layer.cornerRadius = CGFloat(radius)
        case .square:
            layer.cornerRadius = 0
        }

        overlay.layer.cornerRadius = layer.cornerRadius
    }

    // MARK: - Life cycle functions

    /// Default setup to load the view from a xib file.
    override open func xibSetup() {
        super.xibSetup()

        layer.masksToBounds = true
        overlay.layer.masksToBounds = true
    }

    /// Lays out subviews.
    override open func layoutSubviews() {
        super.layoutSubviews()

        updateStyle()
    }

    /// The natural size for the receiving view, considering only properties of the view itself.
    override open var intrinsicContentSize: CGSize {
        return CGSize(width: 250, height: 250)
    }
}
