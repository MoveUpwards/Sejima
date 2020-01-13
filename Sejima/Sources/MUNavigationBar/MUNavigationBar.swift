//
//  MUNavigationBar.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Delegate protocol for MUNavigationBar.
@objc public protocol MUNavigationBarDelegate: class {
    /// Will trigger on cancel / back button tap.
    func leftDidTap(navigationBar: MUNavigationBar)
    /// Will trigger on main / validate button tap.
    func mainDidTap(navigationBar: MUNavigationBar)
    /// Will trigger on more option button tap.
    func rightDidTap(navigationBar: MUNavigationBar)
}

/// Class that act like UINavigationBar with more customizable options.
@IBDesignable
open class MUNavigationBar: MUNibView {
    @IBOutlet private var leftButton: UIButton!
    @IBOutlet private var leftButtonWidthConstraint: NSLayoutConstraint!

    @IBOutlet private var leftSeparatorView: UIView!
    @IBOutlet private var leftSeparatorWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var leftSeparatorHeightConstraint: NSLayoutConstraint!

    @IBOutlet private var mainButton: MUButton!

    @IBOutlet private var rightSeparatorView: UIView!
    @IBOutlet private var rightSeparatorWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var rightSeparatorHeightConstraint: NSLayoutConstraint!

    @IBOutlet private var rightButton: UIButton!
    @IBOutlet private var rightButtonWidthConstraint: NSLayoutConstraint!

    /// The object that acts as the delegate of the navigation bar.
    @IBOutlet public weak var delegate: MUNavigationBarDelegate? // swiftlint:disable:this private_outlet strong_iboutlet line_length

    // MARK: - Left button

    /// A UIImage for the left button.
    @IBInspectable open dynamic var leftButtonImage: UIImage? = nil {
        didSet {
            leftButton.setImage(leftButtonImage, for: .normal)
            leftSeparatorView.isHidden = !(leftButton.image(for: .normal) != nil)
        }
    }

    /// Specifies the let button's proportional width. Default is 70:375
    @IBInspectable open dynamic var leftButtonWidthMultiplier: CGFloat = 70 / 375 {
        didSet {
            leftButtonWidthConstraint = NSLayoutConstraint.change(multiplier: leftButtonWidthMultiplier,
                                                                  for: leftButtonWidthConstraint)
        }
    }

    // MARK: - Right button

    /// A UIImage for the left button.
    @IBInspectable open dynamic var rightButtonImage: UIImage? = nil {
        didSet {
            rightButton.setImage(rightButtonImage, for: .normal)
            rightSeparatorView.isHidden = !(rightButton.image(for: .normal) != nil)
        }
    }

    /// Specifies the let button's proportional width. Default is 70:375
    @IBInspectable open dynamic var rightButtonWidthMultiplier: CGFloat = 70 / 375 {
        didSet {
            rightButtonWidthConstraint = NSLayoutConstraint.change(multiplier: rightButtonWidthMultiplier,
                                                                   for: rightButtonWidthConstraint)
        }
    }

    // MARK: - Separator

    /// The separator’s color.
    @IBInspectable open dynamic var separatorColor: UIColor = .white {
        didSet {
            leftSeparatorView.backgroundColor = separatorColor
            rightSeparatorView.backgroundColor = separatorColor
        }
    }

    /// The separator’s width.
    @IBInspectable open dynamic var separatorWidth: CGFloat = 1.0 {
        didSet {
            leftSeparatorWidthConstraint.constant = separatorWidth
            rightSeparatorWidthConstraint.constant = separatorWidth
        }
    }

    /// The separator’s height multiplier (should be between 0.0 and 1.0).
    @IBInspectable open dynamic var separatorHeightMultiplier: CGFloat = 0.3 {
        didSet {
            leftSeparatorHeightConstraint = NSLayoutConstraint.change(multiplier: separatorHeightMultiplier,
                                                                      for: leftSeparatorHeightConstraint)
            rightSeparatorHeightConstraint = NSLayoutConstraint.change(multiplier: separatorHeightMultiplier,
                                                                       for: rightSeparatorHeightConstraint)
        }
    }

    // MARK: - Main button

    /// The current title that is displayed by the main button.
    @IBInspectable open var mainButtonTitle: String {
        get {
            return mainButton.title
        }
        set {
            mainButton.title = newValue
        }
    }

    /// The main button’s font.
    @objc public dynamic var mainButtonTitleFont: UIFont {
        get {
            return mainButton.titleFont
        }
        set {
            mainButton.titleFont = newValue
        }
    }

    /// The main button’s horizontal alignment.
    @objc public dynamic var mainButtonTitleAlignment: UIControl.ContentHorizontalAlignment {
        get {
            return mainButton.titleAlignment
        }
        set {
            mainButton.titleAlignment = newValue
        }
    }

    /// Optional: The IBInspectable version of the main button’s horizontal alignment.
    @IBInspectable open var mainButtonTitleAlignmentInt: Int {
        get {
            return mainButton.titleAlignmentInt
        }
        set {
            mainButton.titleAlignmentInt = newValue
        }
    }

    /// The main button’s title color.
    @IBInspectable open dynamic var mainButtonTitleColor: UIColor {
        get {
            return mainButton.titleColor
        }
        set {
            mainButton.titleColor = newValue
        }
    }

    /// The main button’s highlighted title color.
    @IBInspectable open dynamic var mainButtonTitleHighlightedColor: UIColor {
        get {
            return mainButton.titleHighlightedColor
        }
        set {
            mainButton.titleHighlightedColor = newValue
        }
    }

    /// The activity indicator’s color of the main button.
    @IBInspectable open dynamic var mainButtonProgressColor: UIColor {
        get {
            return mainButton.progressColor
        }
        set {
            mainButton.progressColor = newValue
        }
    }

    /// Show or hide the progress indicator of the main button.
    @IBInspectable open dynamic var mainButtonIsLoading: Bool {
        get {
            return mainButton.isLoading
        }
        set {
            mainButton.isLoading = newValue
        }
    }

    /// The main button’s state. (Won’t work with application’s state and reserved state).
    @objc public dynamic var mainButtonState: UIControl.State {
        get {
            return mainButton.state
        }
        set {
            mainButton.state = newValue
        }
    }

    /// The main button’s alpha value for disabled state.
    @IBInspectable open dynamic var mainButtonDisabledAlphaValue: CGFloat {
        get {
            return mainButton.disabledAlphaValue
        }
        set {
            mainButton.disabledAlphaValue = newValue
        }
    }

    /// The main button’s background color.
    @IBInspectable open dynamic var mainButtonBackgroundColor: UIColor {
        get {
            return mainButton.buttonBackgroundColor
        }
        set {
            mainButton.buttonBackgroundColor = newValue
        }
    }

    /// The main button’s border color.
    @IBInspectable open dynamic var mainButtonBorderColor: UIColor {
        get {
            return mainButton.borderColor
        }
        set {
            mainButton.borderColor = newValue
        }
    }

    /// The main button’s border width.
    @IBInspectable open dynamic var mainButtonBorderWidth: CGFloat {
        get {
            return mainButton.borderWidth
        }
        set {
            mainButton.borderWidth = newValue
        }
    }

    /// The main button’s corner radius.
    @IBInspectable open dynamic var mainButtonCornerRadius: CGFloat {
        get {
            return mainButton.cornerRadius
        }
        set {
            mainButton.cornerRadius = newValue
        }
    }

    /// The main button’s vertical padding.
    @IBInspectable open dynamic var mainButtonVerticalPadding: CGFloat {
        get {
            return mainButton.verticalPadding
        }
        set {
            mainButton.verticalPadding = newValue
        }
    }

    /// The main button’s horizontal padding.
    @IBInspectable open dynamic var mainButtonHorizontalPadding: CGFloat {
        get {
            return mainButton.horizontalPadding
        }
        set {
            mainButton.horizontalPadding = newValue
        }
    }

    // MARK: - Private IBAction functions

    @IBAction private func leftButtonDidTap(_ sender: Any?) {
        delegate?.leftDidTap(navigationBar: self)
    }

    @IBAction private func rightButtonDidTap(_ sender: Any?) {
        delegate?.rightDidTap(navigationBar: self)
    }

    // MARK: - Life cycle functions

    /// Default setup to load the view from a xib file.
    override open func xibSetup() {
        super.xibSetup()
        mainButton.delegate = self
        leftSeparatorView.isHidden = true
        rightSeparatorView.isHidden = true
    }

    /// The natural size for the receiving view, considering only properties of the view itself.
    override open var intrinsicContentSize: CGSize {
        return CGSize(width: 375, height: 44) // To act like a UINavigationBar with a default size
    }
}

extension MUNavigationBar: MUButtonDelegate {
    /// Will trigger each time the main button is tapped.
    public func didTap(button: MUButton) {
        delegate?.mainDidTap(navigationBar: self)
    }
}
