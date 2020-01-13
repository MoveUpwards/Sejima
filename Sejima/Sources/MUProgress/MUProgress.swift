//
//  MUProgress.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Class that provide a horizontal progress with optionl value indicator with customizable options.
@IBDesignable
open class MUProgress: MUNibView {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var indicator: MUIndicator!
    @IBOutlet private var progressTrackView: UIView!
    @IBOutlet private var progressView: UIView!

    @IBOutlet private var progressHeight: NSLayoutConstraint!
    @IBOutlet private var progressWidth: NSLayoutConstraint!
    @IBOutlet private var indicatorWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var indicatorBottomSpacing: NSLayoutConstraint!

    // MARK: - Private variables

    private var value: CGFloat = 0.0

    // MARK: - Public variables

    /// Returns the current progress value.
    public var currentValue: CGFloat {
        return value
    }

    // MARK: - Title

    /// The title text displayed.
    @IBInspectable open var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    /// The title's font.
    @objc open dynamic var titleFont: UIFont = .systemFont(ofSize: 12, weight: .regular) {
        didSet {
            titleLabel.font = titleFont
        }
    }

    /// The title's title color.
    @IBInspectable open dynamic var titleColor: UIColor = .black {
        didSet {
            titleLabel.textColor = titleColor
        }
    }

    // MARK: - Track line

    /// Define the track line color.
    @IBInspectable open dynamic var trackColor: UIColor = .white {
        didSet {
            progressTrackView.backgroundColor = trackColor
        }
    }

    // MARK: - Progress line

    /// Specifies the progress thickness.
    @IBInspectable open dynamic var thickness: CGFloat = 3.0 {
        didSet {
            progressHeight.constant = thickness
        }
    }

    /// Specifies the progress color.
    @IBInspectable open dynamic var color: UIColor = .blue {
        didSet {
            progressView.backgroundColor = color
        }
    }

    // MARK: - Indicator

    /// Show / Hide the progress indicator. Default is false
    @IBInspectable open dynamic var showIndicator: Bool = false {
        didSet {
            indicator.isHidden = !showIndicator
        }
    }

    /// Specifies the progress value multiplier.
    /// A value of 0.1 with multiplier of 100 will show 10 in the progress value.
    @IBInspectable open dynamic var indicatorMultiplier: CGFloat = 0.0 {
        didSet {
            updateIndicatorLabelValue(with: value)
        }
    }

    /// Specifies the indicator's value format.
    @IBInspectable open dynamic var indicatorFormat: String = "%.f" {
        didSet {
            indicator.format = indicatorFormat
        }
    }

    /// Specifies the indicator's size modifier rate. Default is 1.0 (ie: 100%)
    @objc open dynamic var indicatorWidth: CGFloat = 1.0 {
        didSet {
            indicatorWidthConstraint = NSLayoutConstraint.change(multiplier: indicatorWidth,
                                                                 for: indicatorWidthConstraint)
            updateIndicatorFont()
        }
    }

    /// Specifies the indicator's value font.
    @objc open dynamic var indicatorFont: UIFont = .systemFont(ofSize: 12, weight: .regular) {
        didSet {
            updateIndicatorFont()
        }
    }

    /// Specifies the indicator's color.
    @IBInspectable open dynamic var indicatorColor: UIColor = .white {
        didSet {
            indicator.color = indicatorColor
        }
    }

    /// Specifies the indicator's value color.
    @IBInspectable open dynamic var indicatorValueColor: UIColor = .black {
        didSet {
            indicator.valueColor = indicatorValueColor
        }
    }

    /// Specifies the indicator's corner radius.
    @IBInspectable open dynamic var indicatorCornerRadius: CGFloat = 4.0 {
        didSet {
            indicator.cornerRadius = indicatorCornerRadius
        }
    }

    /// Specifies the indicator's bottom padding.
    @objc open dynamic var indicatorBottomInset: CGFloat = 4.0 {
        didSet {
            indicatorBottomSpacing.constant = indicatorBottomInset
        }
    }

    // MARK: - Public functions

    /// Specifies the progress title text with an optional animation duration. Default animation duration is 0.3.
    public func set(title: String, duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration, animations: { [weak self] in
            self?.titleLabel?.alpha = 0
            self?.layoutIfNeeded()
        }, completion: { [weak self] _ in
            self?.titleLabel?.text = title
            self?.titleLabel?.alpha = 1
            self?.layoutIfNeeded()
        })
    }

    /// Specifies the progress value with an optionel animation duration. By default animation duration is 0.
    public func set(progress: CGFloat, duration: TimeInterval = 0) {
        if duration > 0 {
            UIView.animate(withDuration: duration,
                           delay: 0,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: { [weak self, progressTrackView, progressWidth] in
                            guard let currentWidth = progressTrackView?.frame.size.width,
                                let width = progressWidth else {
                                    return
                            }

                            width.constant = currentWidth * progress
                            self?.layoutIfNeeded()
                }, completion: { _ in })
        } else {
            progressWidth.constant = progressTrackView.frame.size.width * progress
        }

        updateIndicatorLabelValue(with: progress, duration: duration)
        value = progress
    }

    // MARK: - Private functions

    private func updateIndicatorFont() {
        indicator.valueFont = UIFont(descriptor: indicatorFont.fontDescriptor,
                                     size: indicatorFont.pointSize * indicatorWidth)
    }

    private func updateIndicatorLabelValue(with progress: CGFloat, duration: TimeInterval = 0) {
        indicator.set(value: Double(progress * indicatorMultiplier), duration: duration * 0.5)
    }

    // MARK: - Life cycle functions

    /// Default setup to load the view from a xib file.
    open override func xibSetup() {
        super.xibSetup()

        indicator.textAlignment = .center
        indicator.cornerRadius = indicatorCornerRadius
        indicator.valueFont = indicatorFont
        indicator.format = indicatorFormat
        indicator.color = indicatorColor
        indicator.valueColor = indicatorValueColor
        indicatorBottomSpacing.constant = indicatorBottomInset
    }
}
