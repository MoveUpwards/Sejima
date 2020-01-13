//
//  MUTimeSlider.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 13/02/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Delegate protocol for MUTimeSlider.
@objc public protocol MUTimeSliderDelegate: class {
    /// Will trigger each time the slider moves.
    func didUpdate(timeSlider: MUTimeSlider, time: TimeInterval)
}

/// Class that provide a slider to represent a timeline with customizable options.
@IBDesignable
open class MUTimeSlider: MUNibView {
    @IBOutlet private var indicator: UIView!
    @IBOutlet private var label: UILabel!

    @IBOutlet private var indicatorWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var indicatorLeadingConstraint: NSLayoutConstraint!

    @IBOutlet private var labelTopConstraint: NSLayoutConstraint!
    @IBOutlet private var labelTrailingConstraint: NSLayoutConstraint!

    /// The object that acts as the delegate of the time slider.
    @IBOutlet public weak var delegate: MUTimeSliderDelegate? // swiftlint:disable:this private_outlet strong_iboutlet line_length

    // MARK: - Private variables

    private var indicatorLeading = CGFloat(0.0) {
        didSet {
            indicatorLeadingConstraint.constant = indicatorLeading
            updateTimeLabel()
            updateLabelHorizontalPadding()
        }
    }

    private var percentage = 0.0

    // MARK: - Public variables

    /// Returns the current time based on slider position.
    public var currentTime: TimeInterval {
        return duration * percentage / 100.0
    }

    /// Returns the current slider position.
    public var currentPositionX: CGFloat {
        return indicatorLeading
    }

    // MARK: - Public UIAppearence variables ONLY

    /// Define the border's width
    @IBInspectable open dynamic var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    /// Define the border's color
    @IBInspectable open dynamic var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    /// Define the duration to calculate current slide time
    open var duration: TimeInterval = 0.0 {
        didSet {
            updateTimeLabel()
        }
    }

    // MARK: - Indicator view

    /// Define the indicator's width
    @IBInspectable open dynamic var indicatorWidth: CGFloat = 2.0 {
        didSet {
            indicatorWidthConstraint.constant = indicatorWidth
        }
    }

    /// Define the indicator's color
    @IBInspectable open dynamic var indicatorColor: UIColor = .white {
        didSet {
            indicator.backgroundColor = indicatorColor
        }
    }

    // MARK: - Time label

    /// Define the time's label color
    @IBInspectable open dynamic var timeColor: UIColor = .black {
        didSet {
            label.textColor = timeColor
        }
    }

    /// Define the time's label font
    @objc open dynamic var timeFont: UIFont = .systemFont(ofSize: 16.0) {
        didSet {
            label.font = timeFont
        }
    }

    /// Define the time's label padding to the top
    @IBInspectable open dynamic var timeTopPadding: CGFloat = 2.0 {
        didSet {
            labelTopConstraint.constant = timeTopPadding
        }
    }

    /// Define the time's label padding to the indicator (left or right, depending of the space)
    @IBInspectable open dynamic var timeHorizontalPadding: CGFloat = 2.0 {
        didSet {
            updateLabelHorizontalPadding()
        }
    }

    // MARK: - Public functions

    /// Define the slider position using percentage of the overall timeline.
    public func set(percentage: Double) {
        self.percentage = max(0.0, min(100.0, percentage))
        indicatorLeading = borderWidth +
            (bounds.width - 2.0 * borderWidth - indicatorWidth) * CGFloat(percentage) / 100.0
    }

    /// Define the slider position.
    public func set(positionX: CGFloat) {
        let effectiveWidth = bounds.width - 2.0 * borderWidth - indicatorWidth
        let x = max(borderWidth, min(effectiveWidth + borderWidth, positionX))

        percentage = Double((x - borderWidth) * 100.0 / effectiveWidth)
        indicatorLeading = x
    }

    // MARK: - Button functions

    // Connect touchUpInside and touchDragInside
    @IBAction private func touchEvent(_ sender: Any, forEvent event: UIEvent) {
        guard let x = event.allTouches?.first?.preciseLocation(in: self).x else { return }
        set(positionX: x)
        delegate?.didUpdate(timeSlider: self, time: currentTime)
    }

    // MARK: - Private functions

    private func updateLabelHorizontalPadding() {
        // Calculate the minumum place needed to have |-padding-label-padding-indicator
        let minimumLength = label.bounds.width + 2.0 * timeHorizontalPadding + borderWidth
        if indicatorLeading < minimumLength { // Time should be on the right side
            labelTrailingConstraint.constant = -(label.bounds.width + timeHorizontalPadding + indicatorWidth)
        } else { // Time should be on the left side
            labelTrailingConstraint.constant = timeHorizontalPadding
        }
    }

    private func updateTimeLabel() {
        let formatter = DateComponentsFormatter()

        if currentTime >= 3600 {
            formatter.allowedUnits = [.hour, .minute, .second]
        } else {
            formatter.allowedUnits = [.minute, .second]
        }
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad

        label.text = formatter.string(from: currentTime)
        label.sizeToFit()
    }

    // MARK: - Life cycle functions

    /// Default setup to load the view from a xib file.
    open override func xibSetup() {
        super.xibSetup()

        indicator.backgroundColor = indicatorColor

        label.textColor = timeColor
        label.font = timeFont

        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor

        indicatorWidthConstraint.constant = indicatorWidth
        labelTopConstraint.constant = timeTopPadding
        updateLabelHorizontalPadding()
    }
}
