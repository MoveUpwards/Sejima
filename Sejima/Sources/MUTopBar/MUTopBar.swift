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
    @IBOutlet private var titleLabel: UIButton!

    @IBOutlet private var leftButtonLeading: NSLayoutConstraint!
    @IBOutlet private var leftButtonWidth: NSLayoutConstraint!

    /// The object that acts as the delegate of the top bar.
    @IBOutlet public weak var delegate: MUTopBarDelegate? // swiftlint:disable:this private_outlet strong_iboutlet line_length

    // MARK: - Public IBInspectable variables ONLY

    /// The current title.
    @IBInspectable open var title: String = "" {
        didSet {
            titleLabel.setTitle(title, for: .normal)
        }
    }

    /// The current title number of lines.
    @IBInspectable open var lineNumber: Int = 1 {
        didSet {
            titleLabel.titleLabel?.numberOfLines = lineNumber
        }
    }

    // MARK: - Public UIAppearence variables ONLY

    /// The button horizontal alignment.
    @objc open dynamic var buttonAlignment: UIControl.ContentHorizontalAlignment = .center {
        didSet {
            leftButton.contentHorizontalAlignment = buttonAlignment
        }
    }

    /// The title horizontal alignment.
    @objc open dynamic var titleAlignment: UIControl.ContentHorizontalAlignment = .center {
        didSet {
            titleLabel.contentHorizontalAlignment = titleAlignment
        }
    }

    /// The title horizontal alignment.
    @objc open dynamic var titleVerticalAlignment: UIControl.ContentVerticalAlignment = .center {
        didSet {
            titleLabel.contentVerticalAlignment = titleVerticalAlignment
        }
    }

    /// The title’s font.
    @objc open dynamic var titleFont: UIFont = .systemFont(ofSize: 24.0, weight: .bold) {
        didSet {
            titleLabel.titleLabel?.font = titleFont
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
            titleLabel.setTitleColor(titleColor, for: .normal)
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

    /// Optional: The IBInspectable version of the title’s horizontal alignment.
    @IBInspectable open dynamic var titleVerticalAlignmentInt: Int {
        get {
            return titleVerticalAlignment.rawValue
        }
        set {
            titleVerticalAlignment = UIControl.ContentVerticalAlignment(rawValue: newValue) ?? .center
        }
    }

    /// Define if the top bar has or not a left button.
    @IBInspectable open dynamic var showButton: Bool = false {
        didSet {
            leftButton.isHidden = !showButton
            updateImageWidth()
        }
    }

    // MARK: - Private functions

    private func updateImageWidth() {
        leftButtonWidth.constant = showButton ? (buttonImage?.size.width ?? 0.0) * UIScreen.main.scale : 0.0
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

        delegate?.didTap(topBar: self)
    }

    // MARK: - Life cycle functions

    /// The natural size for the receiving view, considering only properties of the view itself.
    override open var intrinsicContentSize: CGSize {
        return CGSize(width: 375, height: 44) // To act like a UINavigationBar with a default size
    }
}
