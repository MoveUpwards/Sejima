//
//  MUTextField.swift
//  MUComponent
//
//  Created by Damien Noël Dubuisson on 05/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import MUCore

/// Delegate protocol for MUTextField.
public protocol MUTextFieldDelegate: class {
    /// Will trigger each time textfield is selected.
    func didSelect(_ textField: MUTextField)
    /// Will trigger each time textfield loose focus.
    func didReturn(_ textField: MUTextField)
    /// Will trigger each time textfield is modifying the text.
    func editingChanged(_ textField: MUTextField)
}

@IBDesignable
open class MUTextField: MUNibView {
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var underlineView: UIView!

    @IBOutlet private var underlineHeightConstraint: NSLayoutConstraint!

    override open func xibSetup() {
        super.xibSetup()

        textField.delegate = self
    }

    open weak var delegate: MUTextFieldDelegate?

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @IBInspectable open var title: String = "" {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @IBInspectable open dynamic var titleColor: UIColor = .white {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @objc open dynamic var titleFont: UIFont = .systemFont(ofSize: UIFont.systemFontSize, weight: .medium) {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @IBInspectable open var text: String = "" {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @IBInspectable open var placeholder: String = "" {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @IBInspectable open dynamic var placeholderColor: UIColor = .lightGray {
        didSet {
            setNeedsLayout()
        }
    }

    @objc open dynamic var textAlignment: NSTextAlignment = .left {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @IBInspectable open dynamic var textAlignmentInt: Int = 0 {
        didSet {
            textAlignment = NSTextAlignment(rawValue: textAlignmentInt) ?? .left
        }
    }

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @IBInspectable open dynamic var textFieldColor: UIColor = .white {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @objc open dynamic var textFieldFont: UIFont = .systemFont(ofSize: UIFont.systemFontSize, weight: .medium) {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @objc open dynamic var keyboardType: UIKeyboardType = .default {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @IBInspectable open dynamic var keyboardTypeInt: Int = 0 {
        didSet {
            keyboardType = UIKeyboardType(rawValue: keyboardTypeInt) ?? .default
        }
    }

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @objc open dynamic var keyboardAppearance: UIKeyboardAppearance = .default {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @IBInspectable open dynamic var keyboardAppearanceInt: Int = 0 {
        didSet {
            keyboardAppearance = UIKeyboardAppearance(rawValue: keyboardAppearanceInt) ?? .default
        }
    }

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @objc open dynamic var keyboardReturnKeyType: UIReturnKeyType = .default {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @objc open dynamic var keyboardEnablesReturnKeyAutomatically: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @objc open dynamic var keyboardAutocorrectionType: UITextAutocorrectionType = .default {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @IBInspectable open dynamic var isSecure: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @IBInspectable open dynamic var isEditable: Bool = true {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @IBInspectable open dynamic var underlineHeight: CGFloat = 2.0 {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @IBInspectable open dynamic var underlineColor: UIColor = .white {
        didSet {
            setNeedsLayout()
        }
    }

    open func activeKeyboard(_ isActive: Bool) {
        _ = isActive ? textField.becomeFirstResponder() : textField.resignFirstResponder()
    }

    override open func layoutSubviews() {
        super.layoutSubviews()

        label.text = title
        label.textColor = titleColor
        label.font = titleFont
        label.textAlignment = textAlignment

        textField.text = text
        textField.isSecureTextEntry = isSecure
        textField.placeholder = placeholder
        textField.attributedPlaceholder =
            NSAttributedString(string: placeholder, attributes: [.foregroundColor: placeholderColor])
        textField.textAlignment = textAlignment
        textField.textColor = textFieldColor
        textField.font = textFieldFont
        textField.keyboardType = keyboardType
        textField.keyboardAppearance = keyboardAppearance
        textField.returnKeyType = keyboardReturnKeyType
        textField.autocorrectionType = keyboardAutocorrectionType
        textField.enablesReturnKeyAutomatically = keyboardEnablesReturnKeyAutomatically

        underlineHeightConstraint.constant = underlineHeight
        underlineView.backgroundColor = underlineColor
    }

    @IBAction func selectTextField() {
        textField.becomeFirstResponder()
    }
}

extension MUTextField: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.didSelect(self)
        return isEditable
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.didReturn(self)
        return true
    }

    @IBAction func editingChanged(_ textField: UITextField) {
        text = textField.text ?? ""
        delegate?.editingChanged(self)
    }
}
