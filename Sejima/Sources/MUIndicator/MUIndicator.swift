//
//  MUIndicator.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 26/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Class that provide an indicator with a animated counter label with customizable options. See MULabelCounter.
@IBDesignable
open class MUIndicator: MUNibView {
    @IBOutlet private var topBackground: UIView!
    @IBOutlet private var bottomBackground: UIView!
    @IBOutlet private var label: MULabelCounter!

    // MARK: - Public IBInspectable and UIAppearence variables

    /// Specifies the indicator's color.
    @IBInspectable open dynamic var color: UIColor = .white {
        didSet {
            topBackground.backgroundColor = color
            bottomBackground.backgroundColor = color
        }
    }

    /// Specifies the indicator's corner radius.
    @IBInspectable open dynamic var cornerRadius: CGFloat = 2.0 {
        didSet {
            topBackground.layer.cornerRadius = cornerRadius
        }
    }

    /// Specifies the indicator's value font.
    @objc open dynamic var valueFont: UIFont = .systemFont(ofSize: 14, weight: .regular) {
        didSet {
            label.textFont = valueFont
        }
    }

    /// Specifies the indicator's value color.
    @IBInspectable open dynamic var valueColor: UIColor = .white {
        didSet {
            label.textColor = valueColor
        }
    }

    /// The indicator’s text animation curve type.
    @objc open dynamic var animationType: AnimationCurve = .linear {
        didSet {
            label.animationType = animationType
        }
    }

    /// Optional: The IBInspectable version of the indicator’s text animation curve type.
    @IBInspectable open dynamic var animationTypeInt: Int {
        get {
            return animationType.rawValue
        }
        set {
            animationType = AnimationCurve(rawValue: newValue) ?? .linear
        }
    }

    /// The indicator’s text alignment.
    @objc open dynamic var textAlignment: NSTextAlignment = .center {
        didSet {
            label.textAlignment = textAlignment
        }
    }

    /// Optional: The IBInspectable version of the indicator’s text alignment.
    @IBInspectable open dynamic var textAlignmentInt: Int {
        get {
            return textAlignment.rawValue
        }
        set {
            textAlignment = NSTextAlignment(rawValue: newValue) ?? .center
        }
    }

    /// Specifies the indicator's value format.
    @IBInspectable open dynamic var format: String = "%.f" {
        didSet {
            label.format = format
        }
    }

    // MARK: - Private functions

    private func createTriangle() -> UIBezierPath {
        let path = UIBezierPath()
        let widthCenter = bottomBackground.bounds.width * 0.5

        path.move(to: CGPoint(x: widthCenter, y: bottomBackground.bounds.height))
        path.addLine(to: CGPoint(x: widthCenter - widthCenter * 0.2, y: 0.0))
        path.addLine(to: CGPoint(x: widthCenter + widthCenter * 0.2, y: 0.0))
        path.addLine(to: CGPoint(x: widthCenter, y: bottomBackground.bounds.height))

        return path
    }

    // MARK: - Public functions

    /// Set the indicator value with animation. Default animation duration is 0.
    public func set(value: Double, duration: Double = 0.0) {
        label.count(to: value, duration: duration)
    }

    // MARK: - Life cycle functions

    /// Lays out subviews.
    override open func layoutSubviews() {
        super.layoutSubviews()

        // We need it to generate the triangle with the current width and height
        bottomBackground.layoutIfNeeded()

        let path = createTriangle()
        path.close()

        let layer = CAShapeLayer()
        layer.path = path.cgPath
        bottomBackground.layer.mask = layer
    }

    /// The natural size for the receiving view, considering only properties of the view itself.
    override open var intrinsicContentSize: CGSize {
        return .zero
    }
}
