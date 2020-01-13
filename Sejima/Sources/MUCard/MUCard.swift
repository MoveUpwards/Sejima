//
//  MUCard.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/**
 Class that provide a header and a content view

 A view with customizable options as:
 * A header on the top with title and detail labels.
 * A content view that can be anything of type UIView.
 */
@IBDesignable
open class MUCard: MUNibView {
    @IBOutlet private var headerView: MUHeader!
    @IBOutlet private var contentView: UIView!

    // Content inset constraint
    @IBOutlet private var top: NSLayoutConstraint!
    @IBOutlet private var contentTop: NSLayoutConstraint!
    @IBOutlet private var contentLeading: NSLayoutConstraint!
    @IBOutlet private var contentTrailing: NSLayoutConstraint!
    @IBOutlet private var contentBottom: NSLayoutConstraint!
    @IBOutlet private var headerLeading: NSLayoutConstraint!
    @IBOutlet private var headerTrailing: NSLayoutConstraint!

    /// The card's style.
    open var style: MUCornerStyle = .square {
        didSet {
            updateStyle()
        }
    }

    /// The card's header text alignment
    @objc open dynamic var textAlignment: NSTextAlignment = .left {
        didSet {
            headerView.textAlignment = textAlignment
        }
    }

    /// The card's header title text font
    @objc open dynamic var titleFont: UIFont = .systemFont(ofSize: 34, weight: .regular) {
        didSet {
            headerView.titleFont = titleFont
        }
    }

    /// The card's header detail text font
    @objc open dynamic var detailFont: UIFont = .systemFont(ofSize: 14, weight: .semibold) {
        didSet {
            headerView.detailFont = detailFont
        }
    }

    /// The card’s border width.
    @IBInspectable open dynamic var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    /// The card’s border color.
    @IBInspectable open dynamic var borderColor: UIColor = .white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    /// Optional: The IBInspectable version of the card's style.
    @IBInspectable open dynamic var styleInt: Int = 0 {
        didSet {
            switch styleInt {
            case 1:
                style = .custom(radius)
            default:
                style = .square
            }
        }
    }

    /// Optional: The IBInspectable version of the card's text alignment.
    @IBInspectable open dynamic var textAlignmentInt: Int = 0 {
        didSet {
            textAlignment = NSTextAlignment(rawValue: textAlignmentInt) ?? .left
        }
    }

    /// The card's corner radius.
    @IBInspectable open dynamic var radius: CGFloat = 0.0 {
        didSet {
            guard radius > 0 else {
                return
            }
            style = .custom(radius)
        }
    }

    /// The card's header title text color.
    @IBInspectable open dynamic var titleColor: UIColor = .white {
        didSet {
            headerView.titleColor = titleColor
        }
    }

    /// The card's header detail text color.
    @IBInspectable open dynamic var detailColor: UIColor = .white {
        didSet {
            headerView.detailColor = detailColor
        }
    }

    /// The card's header title text.
    @IBInspectable open var title: String = "" {
        didSet {
            topPadding = title.isEmpty && detail.isEmpty ? 0 : topPadding
            contentTopPadding = title.isEmpty && detail.isEmpty ? 0 : contentTopPadding
            headerView.title = title
        }
    }

    /// The card's header detail text.
    @IBInspectable open var detail: String = "" {
        didSet {
            topPadding = title.isEmpty && detail.isEmpty ? 0 : topPadding
            contentTopPadding = title.isEmpty && title.isEmpty ? 0 : contentTopPadding
            headerView.detail = detail
        }
    }

    /// Define the top padding of the card's header
    @IBInspectable open dynamic var topPadding: CGFloat = 12.0 {
        didSet {
            top.constant = topPadding
        }
    }

    /// Define the top padding of the card's content
    @IBInspectable open dynamic var contentTopPadding: CGFloat = 16.0 {
        didSet {
            contentTop.constant = contentTopPadding
        }
    }

    /// Define the left padding of the card's content
    @IBInspectable open dynamic var contentLeftPadding: CGFloat = 16.0 {
        didSet {
            contentLeading.constant = contentLeftPadding
        }
    }

    /// Define the right padding of the card's content
    @IBInspectable open dynamic var contentRightPadding: CGFloat = 16.0 {
        didSet {
            contentTrailing.constant = contentRightPadding
        }
    }

    /// Define the bottom padding of the card's content
    @IBInspectable open dynamic var contentBottomPadding: CGFloat = 16.0 {
        didSet {
            contentBottom.constant = contentBottomPadding
        }
    }

    /// Define the horizontal padding of the header
    @IBInspectable open dynamic var headerHorizontalPadding: CGFloat = 16.0 {
        didSet {
            headerLeading.constant = headerHorizontalPadding
            headerTrailing.constant = headerHorizontalPadding
        }
    }

    // MARK: - Public functions

    /// Add content inside the card's content view placeholder
    public func add(contentView customView: UIView) {
        contentView.addAutolayoutSubview(customView)
    }

    // MARK: - Private functions

    private func updateStyle() {
        switch style {
        case .round:
            layer.cornerRadius = bounds.size.width * 0.5
        case .custom(let radius):
            layer.cornerRadius = CGFloat(radius)
        case .square:
            layer.cornerRadius = 0
        }

        layoutSubviews()
    }

    // MARK: - Life cycle functions

    /// Default setup to load the view from a xib file.
    override open func xibSetup() {
        super.xibSetup()

        layer.masksToBounds = true
        headerView.spacing = 0.0
    }

    /// The natural size for the receiving view, considering only properties of the view itself.
    override open var intrinsicContentSize: CGSize {
        return .zero
    }
}
