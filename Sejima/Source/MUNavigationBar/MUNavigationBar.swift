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
    func leftDidTap(_ navigationBar: MUNavigationBar)
    /// Will trigger on main / validate button tap.
    func rightDidTap(_ navigationBar: MUNavigationBar)
}

/// Class that act like UINavigationBar with more customizable options.
@IBDesignable
open class MUNavigationBar: MUNibView {
    @IBOutlet private var leftButton: UIButton!
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

    @IBInspectable public var mainButtonTitle: String {
        get {
            return rightButton.title
        }
        set {
            rightButton.title = newValue
        }
    }

    @objc public dynamic var mainButtonTitleFont: UIFont {
        get {
            return rightButton.titleFont
        }
        set {
            rightButton.titleFont = newValue
        }
    }

    @objc public dynamic var mainButtonTitleAlignment: UIControl.ContentHorizontalAlignment {
        get {
            return rightButton.titleAlignment
        }
        set {
            rightButton.titleAlignment = newValue
        }
    }

    @IBInspectable public var mainButtonTitleAlignmentInt: Int {
        get {
            return rightButton.titleAlignmentInt
        }
        set {
            rightButton.titleAlignmentInt = newValue
        }
    }

    @IBInspectable public dynamic var mainButtonTitleColor: UIColor {
        get {
            return rightButton.titleColor
        }
        set {
            rightButton.titleColor = newValue
        }
    }

    @IBInspectable public dynamic var mainButtonTitleHighlightedColor: UIColor {
        get {
            return rightButton.titleHighlightedColor
        }
        set {
            rightButton.titleHighlightedColor = newValue
        }
    }

    @IBInspectable public dynamic var mainButtonProgressColor: UIColor {
        get {
            return rightButton.progressColor
        }
        set {
            rightButton.progressColor = newValue
        }
    }

    @IBInspectable public dynamic var mainButtonIsLoading: Bool {
        get {
            return rightButton.isLoading
        }
        set {
            rightButton.isLoading = newValue
        }
    }

    @objc public dynamic var mainButtonState: UIControl.State {
        get {
            return rightButton.state
        }
        set {
            rightButton.state = newValue
        }
    }

    @IBInspectable public dynamic var mainButtonDisabledAlphaValue: CGFloat {
        get {
            return rightButton.disabledAlphaValue
        }
        set {
            rightButton.disabledAlphaValue = newValue
        }
    }

    @IBInspectable public dynamic var mainButtonBackgroundColor: UIColor {
        get {
            return rightButton.buttonBackgroundColor
        }
        set {
            rightButton.buttonBackgroundColor = newValue
        }
    }

    @IBInspectable public dynamic var mainButtonBorderColor: UIColor {
        get {
            return rightButton.borderColor
        }
        set {
            rightButton.borderColor = newValue
        }
    }

    @IBInspectable public dynamic var mainButtonBorderWidth: CGFloat {
        get {
            return rightButton.borderWidth
        }
        set {
            rightButton.borderWidth = newValue
        }
    }

    @IBInspectable public dynamic var mainButtonCornerRadius: CGFloat {
        get {
            return rightButton.cornerRadius
        }
        set {
            rightButton.cornerRadius = newValue
        }
    }

    @IBInspectable public dynamic var mainButtonVerticalPadding: CGFloat {
        get {
            return rightButton.verticalPadding
        }
        set {
            rightButton.verticalPadding = newValue
        }
    }

    @IBInspectable public dynamic var mainButtonHorizontalPadding: CGFloat {
        get {
            return rightButton.horizontalPadding
        }
        set {
            rightButton.horizontalPadding = newValue
        }
    }

    // MARK: - Private IBAction functions

    @IBAction private func leftButtonDidTap(_ sender: Any?) {
        delegate?.leftDidTap(self)
    }

    // MARK: - Life cycle functions

    open override func xibSetup() {
        super.xibSetup()
        rightButton.delegate = self
    }
}

extension MUNavigationBar: MUButtonDelegate {
    /// Will trigger each time the main button is tapped.
    public func didTap(_ button: MUButton) {
        delegate?.rightDidTap(self)
    }
}
