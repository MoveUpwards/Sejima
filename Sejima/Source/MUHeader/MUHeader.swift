//
//  MUHeader.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// Class that define a title and a detail description.
@IBDesignable
open class MUHeader: MUNibView {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var detailLabel: UILabel!

    @IBOutlet private var labelsSpacing: NSLayoutConstraint!

    // MARK: - Title Label

    /// The current title.
    @IBInspectable open var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    /// The title’s font.
    @objc open dynamic var titleFont: UIFont = .systemFont(ofSize: 34.0, weight: .regular) {
        didSet {
            titleLabel.font = titleFont
        }
    }

    /// The title’s text color.
    @IBInspectable open dynamic var titleColor: UIColor = .black {
        didSet {
            titleLabel.textColor = titleColor
        }
    }

    // MARK: - Detail Label

    /// The current detail description.
    @IBInspectable open var detail: String = "" {
        didSet {
            detailLabel.text = detail
        }
    }

    /// The detail’s font.
    @objc open dynamic var detailFont: UIFont = .systemFont(ofSize: 14.0, weight: .semibold) {
        didSet {
            detailLabel.font = detailFont
        }
    }

    /// The detail’s text color.
    @IBInspectable open dynamic var detailColor: UIColor = .black {
        didSet {
            detailLabel.textColor = detailColor
        }
    }

    // MARK: - Generic

    /// The text’s horizontal alignment.
    @objc open dynamic var textAlignment: NSTextAlignment = .left {
        didSet {
            titleLabel.textAlignment = textAlignment
            detailLabel.textAlignment = textAlignment
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

    /// The text’s vertical spacing.
    @IBInspectable open dynamic var spacing: CGFloat = 8.0 {
        didSet {
            labelsSpacing.constant = spacing
        }
    }
}
