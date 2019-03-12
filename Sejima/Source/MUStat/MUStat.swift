//
//  MUStat.swift
//  MUComponent
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// Delegate protocol for MUStat.
@objc public protocol MUStatDelegate: class {
    func didTap(_ stat: MUStat)
}

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

    @IBOutlet private var tagGesture: UITapGestureRecognizer!

    /// The object that acts as the delegate of the avatar.
    // swiftlint:disable:next private_outlet strong_iboutlet
    @IBOutlet public weak var delegate: MUStatDelegate? {
        didSet {
            tagGesture.isEnabled = delegate == nil ? false : true
        }
    }

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
    @IBInspectable open dynamic var separatorWidth: CGFloat = 1 {
        didSet {
            separatorWidthConstraint.constant = separatorWidth
        }
    }

    /// Specifies the stat's icon.
    @IBInspectable open dynamic var icon: UIImage? = nil {
        didSet {
            imageView.image = icon
            imageLeadingConstraint.isActive = icon == nil
            imageHeightConstraint.isActive = icon == nil
        }
    }

    // MARK: - Value label

    /// Defines the value text.
    @IBInspectable open dynamic var value: Double = 0 {
        didSet {
            setTextValue()
        }
    }

    /// Specifies the value label font.
    @objc open dynamic var valueFont: UIFont = .systemFont(ofSize: 12, weight: .regular) {
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
    @objc open dynamic var detailFont: UIFont = .systemFont(ofSize: 12, weight: .regular) {
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
    @objc open dynamic var unitFont: UIFont = .systemFont(ofSize: 12, weight: .regular) {
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
