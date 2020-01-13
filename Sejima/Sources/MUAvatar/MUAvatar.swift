//
//  MUAvatar.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Delegate protocol for MUAvatar.
@objc public protocol MUAvatarDelegate: class {
    /// Will trigger each time avatar is tapped.
    func didTap(avatar: MUAvatar)
}

/// Class that act like UIButton with more customizable options.
@IBDesignable
open class MUAvatar: MUNibView {
    @IBOutlet private var avatar: UIImageView!

    /// The object that acts as the delegate of the avatar.
    @IBOutlet public weak var delegate: MUAvatarDelegate? // swiftlint:disable:this private_outlet strong_iboutlet line_length

    /// The avatar’s border width.
    @IBInspectable open dynamic var borderWidth: CGFloat = 0.0 {
        didSet {
            avatar.layer.borderWidth = borderWidth
        }
    }

    /// The avatar’s border color.
    @IBInspectable open dynamic var borderColor: UIColor = .clear {
        didSet {
            avatar.layer.borderColor = borderColor.cgColor
        }
    }

    /// The avatar's style.
    open var style: MUCornerStyle = .square {
        didSet {
            updateStyle()
        }
    }

    /// Optional: The IBInspectable version of the avatar's style.
    @IBInspectable open dynamic var styleInt: Int = 0 {
        didSet {
            switch styleInt {
            case 0:
                style = .square
            case 1:
                style = .round
            default:
                style = .custom(radius)
            }
        }
    }

    /// The avatar's corner radius.
    @IBInspectable open dynamic var radius: CGFloat = 0.0 {
        didSet {
            guard radius > 0 else {
                return
            }
            style = .custom(radius)
        }
    }

    /// The avatar’s image.
    @IBInspectable open dynamic var avatarImage: UIImage? {
        didSet {
            guard avatarImage != nil else {
                avatar.image = placeholderImage
                return
            }

            avatar.image = avatarImage
        }
    }

    /// The avatar’s placeholder image shown if no image defined.
    @IBInspectable open dynamic var placeholderImage: UIImage? {
        didSet {
            guard avatarImage == nil else {
                return
            }
            avatar.image = placeholderImage
        }
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

        avatar.layer.cornerRadius = layer.cornerRadius
    }

    // MARK: - Private IBAction functions

    @IBAction private func didTap(_ sender: Any?) {
        delegate?.didTap(avatar: self)
    }

    // MARK: - Life cycle functions

    /// Default setup to load the view from a xib file.
    override open func xibSetup() {
        super.xibSetup()

        layer.masksToBounds = true
        avatar.layer.masksToBounds = true
    }

    /// Lays out subviews.
    override open func layoutSubviews() {
        super.layoutSubviews()

        updateStyle()
    }

    /// The natural size for the receiving view, considering only properties of the view itself.
    override open var intrinsicContentSize: CGSize {
        return CGSize(width: 64.0, height: 64.0)
    }
}
