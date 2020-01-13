//
//  MUStat.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Delegate protocol for MUStat.
@objc public protocol MUStatDelegate: class {
    /// Will trigger each time stat is tapped.
    func didTap(stat: MUStat)
}

/**
 Class that provide a value with unit, and a detail string below

 A view with customizable options as:
 * A separator on the most left.
 * An image on the right of the verticalSeparator or on the most left if no verticalSeparator.
 * A block of labels with:
   * A value label and an unit label.
   * A description label.
 */
@IBDesignable
open class MUStat: MUNibView {
    @IBOutlet private var valueLabel: UILabel!
    @IBOutlet private var unitLabel: UILabel!
    @IBOutlet private var detailLabel: UILabel!
    @IBOutlet private var verticalSeparator: UIView!
    @IBOutlet private var horizontalSeparator: UIView!
    @IBOutlet private var imageView: UIImageView!

    @IBOutlet private var verticalSeparatorLeadingConstraint: NSLayoutConstraint! // inactive if no separator
    @IBOutlet private var verticalSeparatorWidthConstraint: NSLayoutConstraint! // inactive if no separator
    @IBOutlet private var horizontalSeparatorWidthConstraint: NSLayoutConstraint! // inactive if no separator
    @IBOutlet private var horizontalSeparatorHeightConstraint: NSLayoutConstraint! // inactive if no separator
    @IBOutlet private var horizontalSeparatorLeadingConstraint: NSLayoutConstraint! // inactive if no image
    @IBOutlet private var horizontalSeparatorTrailingConstraint: NSLayoutConstraint! // inactive if no image
    @IBOutlet private var horizontalSeparatorTopConstraint: NSLayoutConstraint! // inactive if no image
    @IBOutlet private var horizontalSeparatorBottomConstraint: NSLayoutConstraint! // inactive if no image
    @IBOutlet private var imageLeadingConstraint: NSLayoutConstraint! // inactive if no image
    @IBOutlet private var imageHeightConstraint: NSLayoutConstraint! // inactive if no image

    @IBOutlet private var labelsTopConstraint: NSLayoutConstraint!
    @IBOutlet private var labelsBottomConstraint: NSLayoutConstraint!

    /// The object that acts as the delegate of the stat.
    @IBOutlet public weak var delegate: MUStatDelegate? // swiftlint:disable:this private_outlet strong_iboutlet line_length

    // MARK: - Separator

    /// Show / hide vertical separator.
    @IBInspectable open dynamic var showVerticalSeparator: Bool = true {
        didSet {
            verticalSeparator.isHidden = !showVerticalSeparator
            verticalSeparatorLeadingConstraint.isActive = showVerticalSeparator
        }
    }

    /// Specifies thevertical  separator color.
    @IBInspectable open dynamic var verticalSeparatorColor: UIColor = .clear {
        didSet {
            verticalSeparator.backgroundColor = verticalSeparatorColor
        }
    }

    /// Specifies thevertical  separator color.
    @IBInspectable open dynamic var horizontalSeparatorColor: UIColor = .clear {
        didSet {
            horizontalSeparator.backgroundColor = horizontalSeparatorColor
        }
    }

    /// Specifies the vertical separator color.
    @IBInspectable open dynamic var verticalSeparatorWidth: CGFloat = 1.0 {
        didSet {
            verticalSeparatorWidthConstraint.constant = verticalSeparatorWidth
        }
    }

    /// Specifies the vertical separator color.
    @IBInspectable open dynamic var horizontalSeparatorWidth: CGFloat = 0.0 {
        didSet {
            horizontalSeparatorWidthConstraint.constant = horizontalSeparatorWidth
        }
    }

    /// Specifies the vertical separator color.
    @IBInspectable open dynamic var horizontalSeparatorHeight: CGFloat = 0.0 {
        didSet {
            horizontalSeparatorHeightConstraint.constant = horizontalSeparatorHeight
            horizontalSeparatorBottomConstraint.constant = horizontalSeparatorHeight == 0 ? 0 : textVerticalPadding
        }
    }

    /// Specifies the left space if vertical separator is shown.
    @IBInspectable open dynamic var verticalSeparatorLeftPadding: CGFloat = 0.0 {
        didSet {
            verticalSeparatorLeadingConstraint.constant = verticalSeparatorLeftPadding
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
    @IBInspectable open dynamic var value: String = "" {
        didSet {
            valueLabel.text = value
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

    /// The text’s horizontal alignment.
    @objc open dynamic var textAlignment: NSTextAlignment = .left {
        didSet {
            valueLabel.textAlignment = textAlignment
            unitLabel.textAlignment = textAlignment
            detailLabel.textAlignment = textAlignment

            horizontalSeparatorLeadingConstraint.isActive = textAlignment == .left
            horizontalSeparatorTrailingConstraint.isActive = textAlignment == .right

            valueLabel.setContentHuggingPriority(UILayoutPriority(rawValue: textAlignment == .right ? 249 : 251),
                                                 for: .horizontal)
        }
    }

    /// Optional: The IBInspectable version of the text’s horizontal alignment.
    @IBInspectable open var textAlignmentInt: Int {
        get {
            return textAlignment.rawValue
        }
        set {
            textAlignment = NSTextAlignment(rawValue: newValue) ?? .left
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

    /// Define the top and bottom padding of the labels.
    @IBInspectable open dynamic var textVerticalPadding: CGFloat = 0.0 {
        didSet {
            horizontalSeparatorTopConstraint.constant = textVerticalPadding
            horizontalSeparatorBottomConstraint.constant = horizontalSeparatorHeight == 0 ? 0 : textVerticalPadding
        }
    }

    // MARK: - Public functions

    /// Specifies the stat's data
    public func set(data: MUStatData) {
        value = data.value
        unit = data.unit
        detail = data.detail
        showVerticalSeparator = data.showVerticalSeparator
        icon = data.image
    }

    // MARK: - Private IBAction functions

    @IBAction private func didTap(_ sender: Any?) {
        delegate?.didTap(stat: self)
    }
}
