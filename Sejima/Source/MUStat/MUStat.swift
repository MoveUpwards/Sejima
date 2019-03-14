//
//  MUStat.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// Delegate protocol for MUStat.
@objc public protocol MUStatDelegate: class {
    /// Will trigger each time stat is tapped.
    func didTap(_ stat: MUStat)
}

/**
 Class that provide a value with unit, and a detail string below

 A view with customizable options as:
 * A separator on the most left.
 * An image on the right of the separator or on the most left if no separator.
 * A block of labels with:
   * A value label and an unit label.
   * A description label.
 */
@IBDesignable
open class MUStat: MUNibView {
    @IBOutlet private var valueLabel: UILabel!
    @IBOutlet private var unitLabel: UILabel!
    @IBOutlet private var detailLabel: UILabel!
    @IBOutlet private var separator: UIView!
    @IBOutlet private var imageView: UIImageView!

    @IBOutlet private var separatorLeadingConstraint: NSLayoutConstraint! // inactive if no separator
    @IBOutlet private var separatorWidthConstraint: NSLayoutConstraint! // inactive if no separator
    @IBOutlet private var imageLeadingConstraint: NSLayoutConstraint! // inactive if no image
    @IBOutlet private var imageHeightConstraint: NSLayoutConstraint! // inactive if no image

    @IBOutlet private var labelsTopConstraint: NSLayoutConstraint!
    @IBOutlet private var labelsBottomConstraint: NSLayoutConstraint!

    /// The object that acts as the delegate of the avatar.
    @IBOutlet public weak var delegate: MUStatDelegate? // swiftlint:disable:this private_outlet strong_iboutlet line_length

    // MARK: - Separator

    /// Show / hide separator.
    @IBInspectable open dynamic var showSeparator: Bool = true {
        didSet {
            separator.isHidden = !showSeparator
            separatorLeadingConstraint.isActive = showSeparator
        }
    }

    /// Specifies the separator color.
    @IBInspectable open dynamic var separatorColor: UIColor = .white {
        didSet {
            separator.backgroundColor = separatorColor
        }
    }

    /// Specifies the separator color.
    @IBInspectable open dynamic var separatorWidth: CGFloat = 1.0 {
        didSet {
            separatorWidthConstraint.constant = separatorWidth
        }
    }

    /// Specifies the left space if separator is shown.
    @IBInspectable open dynamic var separatorLeftPadding: CGFloat = 0.0 {
        didSet {
            separatorLeadingConstraint.constant = separatorLeftPadding
        }
    }

    // MARK: - Icon

    /// Specifies the stat's icon.
    @IBInspectable open dynamic var icon: UIImage? = nil {
        didSet {
            imageView.image = icon
            imageLeadingConstraint.isActive = icon != nil
            imageHeightConstraint.constant = icon == nil ? 0.0 : iconWidth
        }
    }

    /// Specifies the left space if icon is shown.
    @IBInspectable open dynamic var iconWidth: CGFloat = 50.0 {
        didSet {
            imageHeightConstraint.constant = icon == nil ? 0.0 : iconWidth
        }
    }

    /// Specifies the left space if icon is shown.
    @IBInspectable open dynamic var iconLeftPadding: CGFloat = 0.0 {
        didSet {
            imageLeadingConstraint.constant = iconLeftPadding
        }
    }

    // MARK: - Value label

    /// Defines the value text.
    @IBInspectable open dynamic var value: Double = 0.0 {
        didSet {
            setTextValue()
        }
    }

    /// Specifies the value label font.
    @objc open dynamic var valueFont: UIFont = .systemFont(ofSize: 12.0, weight: .regular) {
        didSet {
            valueLabel.font = valueFont
        }
    }

    /// Specifies the value label text color.
    @IBInspectable open dynamic var valueColor: UIColor = .black {
        didSet {
            valueLabel.textColor = valueColor
        }
    }

    /// Specifies the value label format.
    @IBInspectable open dynamic var format: String = "%.f" {
        didSet {
            setTextValue()
        }
    }

    // MARK: - Detail label

    /// Specifies the detail label text.
    @IBInspectable open dynamic var detail: String = "" {
        didSet {
            detailLabel.text = detail
        }
    }

    /// Specifies the detail label font.
    @objc open dynamic var detailFont: UIFont = .systemFont(ofSize: 12.0, weight: .regular) {
        didSet {
            detailLabel.font = detailFont
        }
    }

    /// Specifies the detail label text color.
    @IBInspectable open dynamic var detailColor: UIColor = .black {
        didSet {
            detailLabel.textColor = detailColor
        }
    }

    // MARK: - Unit label

    /// Specifies the value unit text.
    @IBInspectable open dynamic var unit: String = "" {
        didSet {
            unitLabel.text = unit
        }
    }

    /// Specifies the unit label font.
    @objc open dynamic var unitFont: UIFont = .systemFont(ofSize: 12.0, weight: .regular) {
        didSet {
            unitLabel.font = unitFont
        }
    }

    /// Specifies the unit label text color.
    @IBInspectable open dynamic var unitColor: UIColor = .black {
        didSet {
            unitLabel.textColor = unitColor
        }
    }

    // MARK: - Labels padding

    /// Define the top and bottom padding of the labels.
    @IBInspectable open dynamic var verticalPadding: CGFloat = 8.0 {
        didSet {
            labelsTopConstraint.constant = verticalPadding
            labelsBottomConstraint.constant = verticalPadding
        }
    }

    // MARK: - Private functions

    private func setTextValue() {
        // check if counting with ints - cast to int
        if nil != format.range(of: "%(.*)d", options: .regularExpression, range: nil)
            || nil != format.range(of: "%(.*)i") {
            valueLabel.text = String(format: format, Int(value))
        } else {
            valueLabel.text = String(format: format, value)
        }
    }

    // MARK: - Public functions

    /// Specifies the stat's data
    public func set(data: MUStatData) {
        format = data.format
        value = data.value
        unit = data.unit
        detail = data.detail
        showSeparator = data.showSeparator
        icon = data.image

        setTextValue()
    }

    // MARK: - Private IBAction functions

    @IBAction private func didTap(_ sender: Any?) {
        delegate?.didTap(self)
    }
}
