//
//  MUTopBar.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// Delegate protocol for MUTopBar.
public protocol MUTopBarDelegate: class {
    /// Will trigger each time left button or title is tapped.
    func didTap(_ topBar: MUTopBar)
}

/// Class that define a title and a button on left side.
@IBDesignable
open class MUTopBar: MUNibView {
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var titleLabel: UIButton!

    @IBOutlet private var leftButtonLeading: NSLayoutConstraint!
    @IBOutlet private var leftButtonWidth: NSLayoutConstraint!

    /// The object that acts as the delegate of the top bar.
    open weak var delegate: MUTopBarDelegate?

    // MARK: - Public IBInspectable variables ONLY

    /// The current title.
    @IBInspectable open var title: String = "" {
        didSet {
            setNeedsLayout()
        }
    }

    // MARK: - Public UIAppearence variables ONLY

    /// The button horizontal alignment.
    @objc open dynamic var buttonAlignment: UIControl.ContentHorizontalAlignment = .center {
        didSet {
            setNeedsLayout()
        }
    }

    /// The title horizontal alignment.
    @objc open dynamic var titleAlignment: UIControl.ContentHorizontalAlignment = .center {
        didSet {
            setNeedsLayout()
        }
    }

    /// The title’s font.
    @objc open dynamic var titleFont: UIFont = .systemFont(ofSize: 24.0, weight: .bold) {
        didSet {
            setNeedsLayout()
        }
    }

    // MARK: - Public IBInspectable and UIAppearence variables

    /// A UIImage for the button.
    @IBInspectable open dynamic var buttonImage: UIImage? = nil {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the left inset of the button.
    @IBInspectable open dynamic var buttonLeftPadding: CGFloat = 0.0 {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    /// The title’s text color.
    @IBInspectable open dynamic var titleColor: UIColor = .white {
        didSet {
            setNeedsLayout()
        }
    }

    /// Optional: The IBInspectable version of the title’s horizontal alignment.
    @IBInspectable open dynamic var titleAlignmentInt: Int {
        get {
            return titleAlignment.rawValue
        }
        set {
            titleAlignment = UIControl.ContentHorizontalAlignment(rawValue: newValue) ?? .center
        }
    }

    /// Define if the top bar has or not a left button.
    @IBInspectable open dynamic var showButton: Bool = false {
        didSet {
            leftButton.isHidden = !showButton
            setNeedsUpdateConstraints()
        }
    }

    // MARK: - Private IBAction functions

    @IBAction private func leftButtonDidTouchUpOutside(_ sender: Any) {
        leftButton.isHighlighted = false
        titleLabel.isHighlighted = false
    }

    @IBAction private func leftButtonDidTouchDown(_ sender: Any) {
        leftButton.isHighlighted = true
        titleLabel.isHighlighted = true
    }

    @IBAction private func leftButtonDidTap(_ sender: Any?) {
        leftButton.isHighlighted = false
        titleLabel.isHighlighted = false

        delegate?.didTap(self)
    }

    // MARK: - Life cycle functions

    /// Lays out subviews.
    override open func layoutSubviews() {
        super.layoutSubviews()

        leftButton.setImage(buttonImage, for: .normal)
        leftButton.contentHorizontalAlignment = buttonAlignment
        titleLabel.setTitleColor(titleColor, for: .normal)
        titleLabel.titleLabel?.font = titleFont
        titleLabel.setTitle(title, for: .normal)
        titleLabel.contentHorizontalAlignment = titleAlignment
    }

    /// Updates constraints for the view.
    override open func updateConstraints() {
        super.updateConstraints()

        leftButtonLeading.constant = buttonLeftPadding
        leftButtonWidth.constant = showButton ? (buttonImage?.size.width ?? 0.0) * UIScreen.main.scale : 0.0
    }

    /// The natural size for the receiving view, considering only properties of the view itself.
    override open var intrinsicContentSize: CGSize {
        return CGSize(width: 375, height: 44) // To act like a UINavigationBar with a default size
    }
}
