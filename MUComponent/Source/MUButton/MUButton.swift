//
//  MUButton.swift
//  MUComponent
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import MUCore

/// Delegate protocol for MUButton.
public protocol MUButtonDelegate: class {
    /// Will trigger each time button is tapped.
    func didTap(button: MUButton)
}

/// Class that act like UIButton with more customizable options.
@IBDesignable
open class MUButton: MUNibView {
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var progress: UIActivityIndicatorView!

    /// Keep the current background alpha value to put it back if needed.
    private var buttonBackgroundColorAlpha: CGFloat = 1.0

    /// Keep the current border alpha value to put it back if needed.
    private var borderColorAlpha: CGFloat = 1.0

    /// The object that acts as the delegate of the button.
    open weak var delegate: MUButtonDelegate?

    // MARK: - Public IBInspectable variables ONLY

    /// The current title that is displayed by the button.
    @IBInspectable open var title: String = "" {
        didSet {
            setNeedsLayout()
        }
    }

    // MARK: - Public UIAppearence variables ONLY

    /// The button’s horizontal alignment.
    @objc open dynamic var titleAlignment: UIControl.ContentHorizontalAlignment = .center {
        didSet {
            setNeedsLayout()
        }
    }

    /// The button’s font.
    @objc open dynamic var titleFont: UIFont = .systemFont(ofSize: 17.0, weight: .regular) {
        didSet {
            setNeedsLayout()
        }
    }

    /// The button’s font. (Won't work with application's state and reserved state).
    @objc open dynamic var state: UIControl.State = .normal {
        didSet {
            setNeedsLayout()
        }
    }

    // MARK: - Public IBInspectable and UIAppearence variables

    /// The button’s alpha value for disabled state.
    @IBInspectable open dynamic var disabledAlphaValue: CGFloat = 0.7 {
        didSet {
            setNeedsLayout()
        }
    }

    /// The button’s background color.
    @IBInspectable open dynamic var buttonBackgroundColor: UIColor = .white {
        didSet {
            buttonBackgroundColor.getRed(nil, green: nil, blue: nil, alpha: &buttonBackgroundColorAlpha)
            setNeedsLayout()
        }
    }

    /// The button’s border color.
    @IBInspectable open dynamic var borderColor: UIColor = .clear {
        didSet {
            borderColor.getRed(nil, green: nil, blue: nil, alpha: &borderColorAlpha)
            setNeedsLayout()
        }
    }

    /// Optional: The IBInspectable version of the button’s horizontal alignment.
    @IBInspectable open dynamic var titleAlignmentInt: Int = 0 {
        didSet {
            titleAlignment = UIControl.ContentHorizontalAlignment(rawValue: titleAlignmentInt) ?? .center
        }
    }

    /// The button’s title color.
    @IBInspectable open dynamic var titleColor: UIColor = .white {
        didSet {
            setNeedsLayout()
        }
    }

    /// The button’s highlighted title color.
    @IBInspectable open dynamic var titleHighlightedColor: UIColor = .white {
        didSet {
            setNeedsLayout()
        }
    }

    /// The activity indicator’s color.
    @IBInspectable open dynamic var progressColor: UIColor = .white {
        didSet {
            setNeedsLayout()
        }
    }

    /// The button’s border width.
    @IBInspectable open dynamic var borderWidth: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }

    /// The button’s corner radius.
    @IBInspectable open dynamic var cornerRadius: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }

    /// The button’s vertical padding.
    @IBInspectable open dynamic var verticalPadding: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }

    /// The button’s horizontal padding.
    @IBInspectable open dynamic var horizontalPadding: CGFloat = 8.0 {
        didSet {
            setNeedsLayout()
        }
    }

    /// Show or hide the progress indicator.
    @IBInspectable open dynamic var isLoading: Bool = false {
        didSet {
            isUserInteractionEnabled = !isLoading
            state = .normal

            setNeedsLayout()
        }
    }

    // MARK: - Private IBAction functions

    @IBAction private func didTap(_ sender: Any?) {
        state = .normal
        delegate?.didTap(button: self)
    }

    @IBAction private func touchDown(_ sender: Any?) {
        state = .highlighted
    }

    // Up and Drag
    @IBAction private func touchOutside(_ sender: Any?) {
        state = .normal
    }

    @IBAction private func touchDragInside(_ sender: Any) {
        state = .highlighted
    }

    // MARK: - Life cycle functions

    /// Default setup to load the view from a xib file.
    override open func xibSetup() {
        super.xibSetup()

        progress.hidesWhenStopped = true
        button.layer.masksToBounds = true
    }

    /// Lays out subviews.
    override open func layoutSubviews() {
        super.layoutSubviews()

        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        backgroundColor = buttonBackgroundColor

        progress.color = progressColor

        button.layer.cornerRadius = cornerRadius

        button.contentHorizontalAlignment = titleAlignment
        button.contentEdgeInsets = UIEdgeInsets(top: borderWidth + verticalPadding,
                                                left: borderWidth + horizontalPadding,
                                                bottom: borderWidth + verticalPadding,
                                                right: borderWidth + horizontalPadding)

        button.titleLabel?.font = titleFont
        button.setTitle(title, for: state)

        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(titleHighlightedColor, for: .highlighted)
        button.setTitleColor(borderColor.withAlphaComponent(borderColorAlpha * disabledAlphaValue), for: .disabled)

        updateButtonState()
    }

    private func updateButtonState() {
        progress.stopAnimating()

        button.isEnabled = true
        button.isHighlighted = false

        switch state {
        case .disabled:
            let buttonAlpha = buttonBackgroundColorAlpha * disabledAlphaValue
            let borderAlpha = borderColorAlpha * disabledAlphaValue

            layer.borderColor = borderColor.withAlphaComponent(borderAlpha).cgColor
            backgroundColor = buttonBackgroundColor.withAlphaComponent(buttonAlpha)
            button.isEnabled = false

        case .highlighted:
            button.isHighlighted = true
            backgroundColor = borderColor

        default:
            if isLoading {
                button.setTitle("", for: state)
                progress.startAnimating()
            }
        }
    }
}
