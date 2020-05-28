//
//  MUButton.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Delegate protocol for MUButton.
@objc public protocol MUButtonDelegate: class {
    /// Will trigger each time button is tapped.
    func didTap(button: MUButton)
}

/// Class that act like UIButton with more customizable options.
@IBDesignable
open class MUButton: MUNibView {
    @IBOutlet private var button: UIButton!
    @IBOutlet private var progress: MUActivityIndicatorProtocol!

    /// Keep the current background alpha value to put it back if needed.
    private var buttonBackgroundColorAlpha: CGFloat = 1.0

    /// Keep the current border alpha value to put it back if needed.
    private var borderColorAlpha: CGFloat = 1.0

    /// The object that acts as the delegate of the button.
    @IBOutlet public weak var delegate: MUButtonDelegate? // swiftlint:disable:this private_outlet strong_iboutlet line_length

    // MARK: - Title

    /// The current title that is displayed by the button.
    @IBInspectable open var image: UIImage? = nil {
        didSet {
            button.setImage(image, for: .normal)
        }
    }

    open var imageEdgeInsets: UIEdgeInsets = .zero {
        didSet {
            button.imageEdgeInsets = imageEdgeInsets
        }
    }

    /// The current title that is displayed by the button.
    @IBInspectable open var title: String = "" {
        didSet {
            button.setTitle(title, for: .normal)
        }
    }

    /// The button’s font.
    @objc open dynamic var titleFont: UIFont = .systemFont(ofSize: 17.0, weight: .regular) {
        didSet {
            button.titleLabel?.font = titleFont
        }
    }

    /// The button’s horizontal alignment.
    @objc open dynamic var titleAlignment: UIControl.ContentHorizontalAlignment = .center {
        didSet {
            button.contentHorizontalAlignment = titleAlignment
        }
    }

    /// Optional: The IBInspectable version of the button’s horizontal alignment.
    @IBInspectable open dynamic var titleAlignmentInt: Int {
        get {
            return titleAlignment.rawValue
        }
        set {
            titleAlignment = UIControl.ContentHorizontalAlignment(rawValue: newValue) ?? .center
        }
    }

    /// The button’s title color.
    @IBInspectable open dynamic var titleColor: UIColor = .white {
        didSet {
            button.setTitleColor(titleColor, for: .normal)
        }
    }

    /// The button’s highlighted title color.
    @IBInspectable open dynamic var titleHighlightedColor: UIColor = .white {
        didSet {
            button.setTitleColor(titleHighlightedColor, for: .highlighted)
        }
    }

    // MARK: - Loading

    /// The activity indicator’s color.
    @IBInspectable open dynamic var progressColor: UIColor = .white {
        didSet {
            progress.color = progressColor
        }
    }

    /// Show or hide the progress indicator.
    @IBInspectable open dynamic var isLoading: Bool = false {
        didSet {
            button.isHidden = isLoading

            isLoading ? progress.startAnimating() : progress.stopAnimating()
        }
    }

    // MARK: - Generic

    /// The button’s state. (Won't work with application's state and reserved state).
    @objc open dynamic var state: UIControl.State = .normal {
        didSet {
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
                layer.borderColor = borderColor.cgColor

            default:
                layer.borderColor = borderColor.cgColor
                backgroundColor = buttonBackgroundColor
            }
        }
    }

    /// The button’s alpha value for disabled state.
    @IBInspectable open dynamic var disabledAlphaValue: CGFloat = 0.7 {
        didSet {
            updateTitleColor()
        }
    }

    /// The button’s background color.
    @IBInspectable open dynamic var buttonBackgroundColor: UIColor = .white {
        didSet {
            buttonBackgroundColor.getRed(nil, green: nil, blue: nil, alpha: &buttonBackgroundColorAlpha)
            backgroundColor = buttonBackgroundColor
        }
    }

    /// The button’s border color.
    @IBInspectable open dynamic var borderColor: UIColor = .clear {
        didSet {
            borderColor.getRed(nil, green: nil, blue: nil, alpha: &borderColorAlpha)
            layer.borderColor = borderColor.cgColor
            updateTitleColor()
        }
    }

    /// The button’s border width.
    @IBInspectable open dynamic var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
            updateContentInsets()
        }
    }

    /// The button’s corner radius.
    @IBInspectable open dynamic var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            button.layer.cornerRadius = cornerRadius
        }
    }

    /// The button’s vertical padding.
    @IBInspectable open dynamic var verticalPadding: CGFloat = 0.0 {
        didSet {
            updateContentInsets()
        }
    }

    /// The button’s horizontal padding.
    @IBInspectable open dynamic var horizontalPadding: CGFloat = 8.0 {
        didSet {
            updateContentInsets()
        }
    }

    // MARK: - Public functions

    /// Set a custom button progress view
    open func set(_ progress: MUActivityIndicatorProtocol) {
        guard let progressView = progress as? UIView else {
            return
        }

        (self.progress as? UIView)?.removeFromSuperview()
        progress.color = progressColor
        self.progress = progress

        addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        progressView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        progressView.frame.size = CGSize(width: 20, height: 20)
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

    // MARK: - Private functions

    private func updateContentInsets() {
        button.contentEdgeInsets = UIEdgeInsets(top: borderWidth + verticalPadding,
                                                left: borderWidth + horizontalPadding,
                                                bottom: borderWidth + verticalPadding,
                                                right: borderWidth + horizontalPadding)
    }

    private func updateTitleColor() {
        button.setTitleColor(borderColor.withAlphaComponent(borderColorAlpha * disabledAlphaValue), for: .disabled)
    }

    // MARK: - Life cycle functions

    /// Default setup to load the view from a xib file.
    override open func xibSetup() {
        super.xibSetup()

        button.layer.masksToBounds = true
        button.contentVerticalAlignment = .center
        button.titleLabel?.lineBreakMode = .byTruncatingMiddle
        button.titleLabel?.numberOfLines = 1
        button.titleLabel?.textAlignment = .center
    }

    // The natural size for the receiving view, considering only properties of the view itself.
    override open var intrinsicContentSize: CGSize {
        return .zero
    }

    /// Return the height the header will have if constraint with this width.
    open func expectedHeight(for width: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: .greatestFiniteMagnitude)

        return (button.titleLabel?.sizeThatFits(size).height ?? 0.0) + ((borderWidth + verticalPadding) * 2.0)
    }
}
