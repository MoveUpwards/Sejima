//
//  MURadioButton.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 13/12/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Class that act like an UISwitch and can be group.
@IBDesignable
open class MURadioButton: MUNibView, MURadioButtonProtocol {
    @IBOutlet private var button: UIButton!
    @IBOutlet private var indicator: UIView!

    // MARK: - MURadioButtonProtocol

    /// The object that acts as the delegate of the radio button.
    @IBOutlet public weak var delegate: MURadioButtonDelegate? // swiftlint:disable:this private_outlet strong_iboutlet

    /// The radio button's selected state.
    @IBInspectable open dynamic var selected: Bool = false {
        didSet {
            animateState()
        }
    }

    /// The radio button’s border width.
    @IBInspectable open dynamic var borderWidth: CGFloat = 0 {
        didSet {
            button.layer.borderWidth = borderWidth
        }
    }

    /// The radio button’s border color.
    @IBInspectable open dynamic var borderColor: UIColor = .white {
        didSet {
            button.layer.borderColor = borderColor.cgColor
        }
    }

    /// Specifies the indicator's color.
    @IBInspectable open dynamic var indicatorColor: UIColor = .white {
        didSet {
            indicator.backgroundColor = indicatorColor
        }
    }

    /// Specifies the indicator's padding.
    @IBInspectable open dynamic var indicatorPadding: CGFloat = 2.0 {
        didSet {
            indicator.layer.borderWidth = indicatorPadding * 2
        }
    }

    // MARK: - Private IBAction functions

    @IBAction private func didTap(_ sender: Any?) {
        selected = !selected
        selected ? delegate?.didSelect(button: self) : delegate?.didUnselect(button: self)
    }

    // MARK: - Private functions

    private func configure() {
        layer.masksToBounds = true
        clipsToBounds = true

        button.backgroundColor = .clear
        button.layer.masksToBounds = true
        button.layer.borderColor = borderColor.cgColor
        button.layer.borderWidth = borderWidth

        indicator.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        indicator.backgroundColor = indicatorColor
        indicator.layer.borderWidth = indicatorPadding * 2
    }

    private func animateState() {
        let to: CGFloat = selected ? 1.0 : 0.001
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.6,
                       options: [.beginFromCurrentState, .curveEaseOut],
                       animations: { [weak indicator] in
                        indicator?.transform = CGAffineTransform.identity.scaledBy(x: to, y: to)
        })
    }

    // MARK: - Life cycle

    /// Default setup to load the view from a xib file.
    open override func xibSetup() {
        super.xibSetup()
        configure()
    }

    /// Lays out subviews.
    override open func layoutSubviews() {
        super.layoutSubviews()

        let radius = min(bounds.width, bounds.height) * 0.5
        layer.cornerRadius = radius
        button.layer.cornerRadius = radius

        indicator.layer.cornerRadius = radius
        indicator.layer.borderColor = backgroundColor?.cgColor
    }

    /// The natural size for the receiving view, considering only properties of the view itself.
    override open var intrinsicContentSize: CGSize {
        return CGSize(width: 50, height: 50)
    }
}
