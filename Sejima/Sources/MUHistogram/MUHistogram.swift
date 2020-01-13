//
//  MUHistogram.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 30/01/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Class that act like a bar chart image generator with customizable options.
@IBDesignable
open class MUHistogram: MUNibView {
    @IBOutlet private var background: UIImageView!

    @IBOutlet private var backgroundLeading: NSLayoutConstraint!
    @IBOutlet private var backgroundTrailing: NSLayoutConstraint!
    @IBOutlet private var backgroundTop: NSLayoutConstraint!
    @IBOutlet private var backgroundBottom: NSLayoutConstraint!

    // MARK: - Public UIAppearence variables

    /// Describes the Bar's color appearance while it shows
    @IBInspectable open dynamic var barColor: UIColor = .white {
        didSet {
            drawInImageView()
        }
    }

    /// Define the border's width
    @IBInspectable open dynamic var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    /// Define the border's color
    @IBInspectable open dynamic var borderColor: UIColor = .white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    /// Define the corner radius
    @IBInspectable open dynamic var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var contentHorizontalPadding: CGFloat = 0.0 {
        didSet {
            backgroundLeading.constant = contentHorizontalPadding
            backgroundTrailing.constant = contentHorizontalPadding
        }
    }

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var contentVerticalPadding: CGFloat = 0.0 {
        didSet {
            backgroundTop.constant = contentVerticalPadding
            backgroundBottom.constant = contentVerticalPadding
        }
    }

    // MARK: - Public variables

    /// Describe all the values being used to draw the histogram
    open var values: [CGFloat] = [] {
        didSet {
            drawInImageView()
        }
    }

    // MARK: - Private functions

    private func drawInImageView() {
        let width = bounds.width - 2.0 * contentHorizontalPadding
        let height = bounds.height - 2.0 * contentVerticalPadding

        guard width > 0.0, height > 0.0 else {
            return
        }

        background.image = UIImage(histogram: values, bar: barColor, size: CGSize(width: width, height: height))
    }

    // MARK: - Life cycle functions

    /// Default setup to load the view from a xib file.
    override open func xibSetup() {
        super.xibSetup()

        layer.masksToBounds = true
    }

    /// Lays out subviews.
    override open func layoutSubviews() {
        super.layoutSubviews()

        drawInImageView()
    }
}
