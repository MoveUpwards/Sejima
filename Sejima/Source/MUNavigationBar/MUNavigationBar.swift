//
//  MUNavigationBar.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// Delegate protocol for MUNavigationBar.
@objc public protocol MUNavigationBarDelegate: class {
    /// Will trigger on cancel / back button tap.
    func leftDidTap(navigationBar: MUNavigationBar)
    /// Will trigger on main / validate button tap.
    func rightDidTap(navigationBar: MUNavigationBar)
}

/// Class that act like UINavigationBar with more customizable options.
@IBDesignable
open class MUNavigationBar: MUNibView {
    @IBOutlet private var leftButton: UIButton!
    @IBOutlet private var leftButtonWidthConstraint: NSLayoutConstraint!

    @IBOutlet private var separatorView: UIView!
    @IBOutlet private var rightButton: MUButton!

    @IBOutlet private var separatorWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var separatorHeightConstraint: NSLayoutConstraint!

    /// The object that acts as the delegate of the navigation bar.
    @IBOutlet public weak var delegate: MUNavigationBarDelegate? // swiftlint:disable:this private_outlet strong_iboutlet line_length

    // MARK: - Left button

    /// A UIImage for the left button.
    @IBInspectable open dynamic var leftButtonImage: UIImage? = nil {
        didSet {
            leftButton.setImage(leftButtonImage, for: .normal)
        }
    }

    /// Specifies the let button's proportional width. Default is 70:375
    internal var leftButtonWidthMultiplier: CGFloat = 70 / 375 {
        didSet {
            leftButtonWidthConstraint = NSLayoutConstraint.change(multiplier: leftButtonWidthMultiplier,
                                                                  for: leftButtonWidthConstraint)
        }
    }

    // MARK: - Separator

    /// The separator’s color.
    @IBInspectable open dynamic var separatorColor: UIColor = .white {
        didSet {
            separatorView.backgroundColor = separatorColor
        }
    }

    /// The separator’s width.
    @IBInspectable open dynamic var separatorWidth: CGFloat = 1.0 {
        didSet {
            separatorWidthConstraint.constant = separatorWidth
        }
    }

    /// The separator’s height multiplier (should be between 0.0 and 1.0).
    @IBInspectable open dynamic var separatorHeightMultiplier: CGFloat = 0.3 {
        didSet {
            separatorHeightConstraint = NSLayoutConstraint.change(multiplier: separatorHeightMultiplier,
                                                                  for: separatorHeightConstraint)
        }
    }

    // MARK: - Main button

    /// The main button.
    public var mainButton: MUButton {
        return rightButton
    }

    /// The current title that is displayed by the main button.
    @IBInspectable open var mainButtonTitle: String {
        get {
            return rightButton.title
        }
        set {
            rightButton.title = newValue
        }
    }

    /// The main button’s font.
    @objc public dynamic var mainButtonTitleFont: UIFont {
        get {
            return rightButton.titleFont
        }
        set {
            rightButton.titleFont = newValue
        }
    }

    /// The main button’s horizontal alignment.
    @objc public dynamic var mainButtonTitleAlignment: UIControl.ContentHorizontalAlignment {
        get {
            return rightButton.titleAlignment
        }
        set {
            rightButton.titleAlignment = newValue
        }
    }

    /// Optional: The IBInspectable version of the main button’s horizontal alignment.
    @IBInspectable open var mainButtonTitleAlignmentInt: Int {
        get {
            return rightButton.titleAlignmentInt
        }
        set {
            rightButton.titleAlignmentInt = newValue
        }
    }

    /// The main button’s title color.
    @IBInspectable open dynamic var mainButtonTitleColor: UIColor {
        get {
            return rightButton.titleColor
        }
        set {
            rightButton.titleColor = newValue
        }
    }

    /// The main button’s highlighted title color.
    @IBInspectable open dynamic var mainButtonTitleHighlightedColor: UIColor {
        get {
            return rightButton.titleHighlightedColor
        }
        set {
            rightButton.titleHighlightedColor = newValue
        }
    }

    /// The activity indicator’s color of the main button.
    @IBInspectable open dynamic var mainButtonProgressColor: UIColor {
        get {
            return rightButton.progressColor
        }
        set {
            rightButton.progressColor = newValue
        }
    }

    /// Show or hide the progress indicator of the main button.
    @IBInspectable open dynamic var mainButtonIsLoading: Bool {
        get {
            return rightButton.isLoading
        }
        set {
            rightButton.isLoading = newValue
        }
    }

    /// The main button’s state. (Won’t work with application’s state and reserved state).
    @objc public dynamic var mainButtonState: UIControl.State {
        get {
            return rightButton.state
        }
        set {
            rightButton.state = newValue
        }
    }

    /// The main button’s alpha value for disabled state.
    @IBInspectable open dynamic var mainButtonDisabledAlphaValue: CGFloat {
        get {
            return rightButton.disabledAlphaValue
        }
        set {
            rightButton.disabledAlphaValue = newValue
        }
    }

    /// The main button’s background color.
    @IBInspectable open dynamic var mainButtonBackgroundColor: UIColor {
        get {
            return rightButton.buttonBackgroundColor
        }
        set {
            rightButton.buttonBackgroundColor = newValue
        }
    }

    /// The main button’s border color.
    @IBInspectable open dynamic var mainButtonBorderColor: UIColor {
        get {
            return rightButton.borderColor
        }
        set {
            rightButton.borderColor = newValue
        }
    }

    /// The main button’s border width.
    @IBInspectable open dynamic var mainButtonBorderWidth: CGFloat {
        get {
            return rightButton.borderWidth
        }
        set {
            rightButton.borderWidth = newValue
        }
    }

    /// The main button’s corner radius.
    @IBInspectable open dynamic var mainButtonCornerRadius: CGFloat {
        get {
            return rightButton.cornerRadius
        }
        set {
            rightButton.cornerRadius = newValue
        }
    }

    /// The main button’s vertical padding.
    @IBInspectable open dynamic var mainButtonVerticalPadding: CGFloat {
        get {
            return rightButton.verticalPadding
        }
        set {
            rightButton.verticalPadding = newValue
        }
    }

    /// The main button’s horizontal padding.
    @IBInspectable open dynamic var mainButtonHorizontalPadding: CGFloat {
        get {
            return rightButton.horizontalPadding
        }
        set {
            rightButton.horizontalPadding = newValue
        }
    }

    // MARK: - Private IBAction functions

    @IBAction private func leftButtonDidTap(_ sender: Any?) {
        delegate?.leftDidTap(navigationBar: self)
    }

    // MARK: - Life cycle functions

    /// Default setup to load the view from a xib file.
    override open func xibSetup() {
        super.xibSetup()
        rightButton.delegate = self
    }

    /// The natural size for the receiving view, considering only properties of the view itself.
    override open var intrinsicContentSize: CGSize {
        return CGSize(width: 375, height: 44) // To act like a UINavigationBar with a default size
    }
}

extension MUNavigationBar: MUButtonDelegate {
    /// Will trigger each time the main button is tapped.
    public func didTap(button: MUButton) {
        delegate?.rightDidTap(navigationBar: self)
    }
}
