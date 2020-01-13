//
//  MUBar.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 26/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Class that act like a proportional bar with an indicator on top.
internal class MUBar: MUNibView {
    @IBOutlet private var bar: UIView!
    @IBOutlet private var indicator: MUIndicator!

    @IBOutlet private var barWidth: NSLayoutConstraint!
    @IBOutlet private var barHeight: NSLayoutConstraint!
    @IBOutlet private var indicatorWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var indicatorBottomSpacing: NSLayoutConstraint!

    /// Define the bar's proportional width.
    internal var proportionalWidth: CGFloat = 1.0 {
        didSet {
            barWidth = NSLayoutConstraint.change(multiplier: proportionalWidth, for: barWidth)
        }
    }

    /// Define the value for the bar's height.
    internal var value: CGFloat = 0.0 {
        didSet {
            barHeight = NSLayoutConstraint.change(multiplier: value, for: barHeight)
            updateIndicatorValue()
        }
    }

    /// Define the bar's color.
    internal var color: UIColor = .clear {
        didSet {
            bar.backgroundColor = color
        }
    }

    /// Define the bar's corner radius.
    internal var radius: CGFloat = 0.0 {
        didSet {
            // As we only have vertical bar, we only round the 2 top corners.
            bar.roundCorners([.topLeft, .topRight], value: radius)
        }
    }

    /// Show / hide the MUIndicator.
    internal var showIndicator: Bool = false {
        didSet {
            indicator.isHidden = !showIndicator
        }
    }

    /// Define the indicator's corner radius.
    internal var indicatorRadius: CGFloat = 0.0 {
        didSet {
            indicator.cornerRadius = indicatorRadius
        }
    }

    /// The maximum value of the bar.
    internal var indicatorMultiplier: CGFloat = 0.0 {
        didSet {
            updateIndicatorValue()
        }
    }

    /// Specifies the indicator's value format.
    internal var indicatorFormat: String = "%.f" {
        didSet {
            indicator.format = indicatorFormat
            updateIndicatorValue()
        }
    }

    /// Specifies the indicator's proportional width.
    internal var indicatorWidth: CGFloat = 0.0 {
        didSet {
            indicatorWidthConstraint = NSLayoutConstraint.change(multiplier: indicatorWidth,
                                                                 for: indicatorWidthConstraint)
            updateFont()
        }
    }

    /// Specifies the indicator's value font.
    internal var indicatorTextFont: UIFont = .systemFont(ofSize: 24.0, weight: .bold) {
        didSet {
            updateFont()
        }
    }

    /// Specifies the indicator's value color.
    internal var indicatorTextColor: UIColor = .white {
        didSet {
            indicator.valueColor = indicatorTextColor
        }
    }

    /// Define the inset between the bar and the indicator.
    internal var indicatorBottomInset: CGFloat = 0.0 {
        didSet {
            indicatorBottomSpacing.constant = indicatorBottomInset
        }
    }

    /// Specifies the indicator's color.
    internal var indicatorColor: UIColor = .white {
        didSet {
            indicator.color = indicatorColor
        }
    }

    // MARK: - Life cycle

    /// Default setup to load the view from a xib file.
    open override func xibSetup() {
        super.xibSetup()

        indicator.textAlignment = .center
    }

    // MARK: - Private functions

    @IBAction private func didTap(_ sender: Any) {
        showIndicator.toggle()
    }

    private func updateFont() {
        indicator.valueFont = UIFont(descriptor: indicatorTextFont.fontDescriptor,
                                     size: indicatorTextFont.pointSize * indicatorWidth)
    }

    private func updateIndicatorValue() {
        indicator.set(value: Double(value * indicatorMultiplier))
    }
}
