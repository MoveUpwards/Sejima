//
//  MUHeader.swift
//  MUComponent
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// Class that define a title and a detail description.
@IBDesignable
open class MUHeader: MUNibView {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var detailLabel: UILabel!

    @IBOutlet private var labelsSpacing: NSLayoutConstraint!

    // MARK: - Public IBInspectable variables ONLY

    /// The current title.
    @IBInspectable open var title: String = "" {
        didSet {
            setNeedsLayout()
        }
    }

    /// The current detail description.
    @IBInspectable open var detail: String = "" {
        didSet {
            setNeedsLayout()
        }
    }

    // MARK: - Public UIAppearence variables ONLY

    /// The title’s font.
    @objc open dynamic var titleFont: UIFont = .systemFont(ofSize: 34, weight: .regular) {
        didSet {
            setNeedsLayout()
        }
    }

    /// The detail’s font.
    @objc open dynamic var detailFont: UIFont = .systemFont(ofSize: 14, weight: .semibold) {
        didSet {
            setNeedsLayout()
        }
    }

    /// The text’s horizontal alignment.
    @objc open dynamic var textAlignment: NSTextAlignment = .left {
        didSet {
            setNeedsLayout()
        }
    }

    // MARK: - Public IBInspectable and UIAppearence variables

    /// The title’s text color.
    @IBInspectable open dynamic var titleColor: UIColor = .white {
        didSet {
            setNeedsLayout()
        }
    }

    /// The detail’s text color.
    @IBInspectable open dynamic var detailColor: UIColor = .white {
        didSet {
            setNeedsLayout()
        }
    }

    /// Optional: The IBInspectable version of the text’s horizontal alignment.
    @IBInspectable open dynamic var textAlignmentInt: Int = 0 {
        didSet {
            textAlignment = NSTextAlignment(rawValue: textAlignmentInt) ?? .left
        }
    }

    /// The text’s vertical spacing.
    @IBInspectable open dynamic var spacing: CGFloat = 8.0 {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    /// Lays out subviews.
    override open func layoutSubviews() {
        super.layoutSubviews()

        titleLabel.textColor = titleColor
        titleLabel.font = titleFont
        titleLabel.text = title
        titleLabel.textAlignment = textAlignment

        detailLabel.textColor = detailColor
        detailLabel.font = detailFont
        detailLabel.text = detail
        detailLabel.textAlignment = textAlignment
    }

    /// Updates constraints for the view.
    open override func updateConstraints() {
        super.updateConstraints()

        labelsSpacing.constant = spacing
    }
}
