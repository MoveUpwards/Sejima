//
//  MUNavigationBar.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// Delegate protocol for MUNavigationBar.
public protocol MUNavigationBarDelegate: class {
    /// Will trigger on cancel / back button tap.
    func leftDidTap(_ navigationBar: MUNavigationBar)
    /// Will trigger on main / validate button tap.
    func rightDidTap(_ navigationBar: MUNavigationBar)
}

/// Class that act like UINavigationBar with more customizable options.
@IBDesignable
open class MUNavigationBar: MUNibView {
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var separatorView: UIView!
    @IBOutlet private weak var rightButton: MUButton!

    /// The object that acts as the delegate of the navigation bar.
    open weak var delegate: MUNavigationBarDelegate?

    // MARK: - Public IBInspectable variables ONLY

    /// The main button's title.
    @IBInspectable open var rightButtonTitle: String = "" {
        didSet {
            setNeedsLayout()
        }
    }

    // MARK: - Public UIAppearence variables ONLY

    /// The main button’s state. (Won't work with application's state and reserved state).
    @objc open dynamic var rightButtonState: UIControl.State = .normal {
        didSet {
            setNeedsLayout()
        }
    }

    // MARK: - Public IBInspectable and UIAppearence variables

    /// A UIImage for the left button.
    @IBInspectable open dynamic var leftButtonImage: UIImage? = nil {
        didSet {
            setNeedsLayout()
        }
    }

    /// The separator’s color.
    @IBInspectable open dynamic var separatorColor: UIColor = .white {
        didSet {
            setNeedsLayout()
        }
    }

    /// Show or hide the progress indicator.
    @IBInspectable open dynamic var isLoading: Bool {
        get {
            return rightButton.isLoading
        }
        set {
            rightButton.isLoading = newValue
        }
    }

    // MARK: - Private IBAction functions

    @IBAction private func leftButtonDidTap(_ sender: Any?) {
        delegate?.leftDidTap(self)
    }

    // MARK: - Life cycle functions

    /// Lays out subviews.
    override open func layoutSubviews() {
        super.layoutSubviews()

        leftButton.setImage(leftButtonImage, for: .normal)
        separatorView.backgroundColor = separatorColor
        rightButton.title = rightButtonTitle
        rightButton.state = rightButtonState
        rightButton.delegate = self
    }
}

extension MUNavigationBar: MUButtonDelegate {
    /// Will trigger each time the main button is tapped.
    public func didTap(_ button: MUButton) {
        delegate?.rightDidTap(self)
    }
}
