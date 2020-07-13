//
//  MUTopBar.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Delegate protocol for MUTopBar.
@objc public protocol MUTopBarDelegate: class {
    /// Will trigger each time left button or title is tapped.
    func didTap(topBar: MUTopBar)
}

/// Class that define a title and a button on left side.
@IBDesignable
open class MUTopBar: MUNibView {
    @IBOutlet private var leftButton: UIButton!
    @IBOutlet private var titleLabel: UILabel!

    @IBOutlet private var leftButtonTopAlignment: NSLayoutConstraint!
    @IBOutlet private var leftButtonLeading: NSLayoutConstraint!
    @IBOutlet private var leftButtonWidth: NSLayoutConstraint!

    /// The object that acts as the delegate of the top bar.
    @IBOutlet public weak var delegate: MUTopBarDelegate? // swiftlint:disable:this private_outlet strong_iboutlet line_length

    // MARK: - Public IBInspectable variables ONLY

    /// The current title.
    @IBInspectable open var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    /// The current title number of lines.
    @IBInspectable open var lineNumber: Int = 1 {
        didSet {
            titleLabel.numberOfLines = lineNumber
        }
    }

    // MARK: - Public UIAppearence variables ONLY

    /// The title horizontal alignment.
    @objc open dynamic var titleAlignment: NSTextAlignment = .center {
        didSet {
            titleLabel.textAlignment = titleAlignment
        }
    }

    /// The title’s font.
    @objc open dynamic var titleFont: UIFont = .systemFont(ofSize: 24.0, weight: .bold) {
        didSet {
            titleLabel.font = titleFont
        }
    }

    // MARK: - Public IBInspectable and UIAppearence variables

    /// A UIImage for the button.
    @IBInspectable open dynamic var buttonImage: UIImage? = nil {
        didSet {
            leftButton.setImage(buttonImage, for: .normal)
            updateImageWidth()
        }
    }

    /// Define the left inset of the button.
    @IBInspectable open dynamic var buttonLeftPadding: CGFloat = 0.0 {
        didSet {
            leftButtonLeading.constant = buttonLeftPadding
        }
    }

    /// The title’s text color.
    @IBInspectable open dynamic var titleColor: UIColor = .white {
        didSet {
            titleLabel.textColor = titleColor
        }
    }

    /// Optional: The IBInspectable version of the title’s horizontal alignment.
    @IBInspectable open dynamic var titleAlignmentInt: Int {
        get {
            return titleAlignment.rawValue
        }
        set {
            titleAlignment = NSTextAlignment(rawValue: newValue) ?? .center
        }
    }

    /// Define if the top bar has or not a left button.
    @IBInspectable open dynamic var showButton: Bool = false {
        didSet {
            leftButton.isHidden = !showButton
            updateImageWidth()
        }
    }

    /// Define if the left button is centered or top title aligned.
    @IBInspectable open dynamic var isLeftButtonCentered: Bool = true {
        didSet {
            leftButtonTopAlignment.isActive = isLeftButtonCentered
            updateConstraints()
        }
    }

    // MARK: - Private functions

    private func updateImageWidth() {
        leftButtonWidth.constant = showButton ? (buttonImage?.size.width ?? 0.0) * UIScreen.main.scale : 0.0
    }

    // MARK: - Private IBAction functions

    @IBAction private func leftButtonDidTouchUpOutside(_ sender: Any) {
        leftButton.isHighlighted = false
    }

    @IBAction private func leftButtonDidTouchDown(_ sender: Any) {
        leftButton.isHighlighted = true
    }

    @IBAction private func leftButtonDidTap(_ sender: Any?) {
        leftButton.isHighlighted = false

        delegate?.didTap(topBar: self)
    }

    /// The natural size for the receiving view, considering only properties of the view itself.
    override open var intrinsicContentSize: CGSize {
        return CGSize(width: 375, height: 44) // To act like a UINavigationBar with a default size
    }
}
