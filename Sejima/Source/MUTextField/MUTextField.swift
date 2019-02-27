//
//  MUTextField.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 05/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// Delegate protocol for MUTextField.
public protocol MUTextFieldDelegate: class {
    /// Will trigger each time textfield is selected.
    func didSelect(_ textField: MUTextField)
    /// Will trigger each time textfield loose focus.
    func didReturn(_ textField: MUTextField)
    /// Will trigger each time textfield is modifying the text.
    func editingChanged(_ textField: MUTextField)
}

/// Class that act like UITextField with more customizable options.
@IBDesignable
open class MUTextField: MUNibView {
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var underlineView: UIView!

    @IBOutlet private var underlineHeightConstraint: NSLayoutConstraint!

    /// The object that acts as the delegate of the textfield.
    open weak var delegate: MUTextFieldDelegate?

    // MARK: - Public IBInspectable variables ONLY

    /// The current title that is shown on top of the textfield.
    @IBInspectable open var title: String = "" {
        didSet {
            setNeedsLayout()
        }
    }

    // MARK: - Public UIAppearence variables ONLY

    /// The title’s font.
    @objc open dynamic var titleFont: UIFont = .systemFont(ofSize: UIFont.systemFontSize, weight: .medium) {
        didSet {
            setNeedsLayout()
        }
    }

    /// The title and textfield text horizontal alignment.
    @objc open dynamic var textAlignment: NSTextAlignment = .left {
        didSet {
            setNeedsLayout()
        }
    }

    /// The textfield’s font.
    @objc open dynamic var textFieldFont: UIFont = .systemFont(ofSize: UIFont.systemFontSize, weight: .medium) {
        didSet {
            setNeedsLayout()
        }
    }

    /// The keyboard style associated with the text object.
    @objc open dynamic var keyboardType: UIKeyboardType = .default {
        didSet {
            setNeedsLayout()
        }
    }

    /// The appearance style of the keyboard that is associated with the text object.
    @objc open dynamic var keyboardAppearance: UIKeyboardAppearance = .default {
        didSet {
            setNeedsLayout()
        }
    }

    /// The visible title of the Return key.
    @objc open dynamic var keyboardReturnKeyType: UIReturnKeyType = .default {
        didSet {
            setNeedsLayout()
        }
    }

    /// A Boolean value indicating whether the Return key is automatically enabled when the user is entering text.
    @objc open dynamic var keyboardEnablesReturnKeyAutomatically: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }

    /// The autocorrection style for the text object.
    @objc open dynamic var keyboardAutocorrectionType: UITextAutocorrectionType = .default {
        didSet {
            setNeedsLayout()
        }
    }

    // MARK: - Public IBInspectable and UIAppearence variables

    /// The title’s color.
    @IBInspectable open dynamic var titleColor: UIColor = .white {
        didSet {
            setNeedsLayout()
        }
    }

    /// The text displayed by the text field.
    @IBInspectable open var text: String = "" {
        didSet {
            setNeedsLayout()
        }
    }

    /// The string that is displayed when there is no other text in the text field.
    @IBInspectable open var placeholder: String = "" {
        didSet {
            setNeedsLayout()
        }
    }

    /// The placehodler's color.
    @IBInspectable open dynamic var placeholderColor: UIColor = .lightGray {
        didSet {
            setNeedsLayout()
        }
    }

    /// Optional: The IBInspectable version of the title and textfield text horizontal alignment.
    @IBInspectable open dynamic var textAlignmentInt: Int = 0 {
        didSet {
            textAlignment = NSTextAlignment(rawValue: textAlignmentInt) ?? .left
        }
    }

    /// The color of the text.
    @IBInspectable open dynamic var textColor: UIColor = .white {
        didSet {
            setNeedsLayout()
        }
    }

    /// Optional: The IBInspectable version of the return key's visible title.
    @IBInspectable open dynamic var keyboardTypeInt: Int = 0 {
        didSet {
            keyboardType = UIKeyboardType(rawValue: keyboardTypeInt) ?? .default
        }
    }

    /// Optional: The IBInspectable version of the keyboard's appearance style.
    @IBInspectable open dynamic var keyboardAppearanceInt: Int = 0 {
        didSet {
            keyboardAppearance = UIKeyboardAppearance(rawValue: keyboardAppearanceInt) ?? .default
        }
    }

    /// Identifies whether the text object should disable text copying and in some cases hide the text being entered.
    @IBInspectable open dynamic var isSecure: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }

    /// Identifies whether the text field should respond to user edit.
    @IBInspectable open dynamic var isEditable: Bool = true {
        didSet {
            setNeedsLayout()
        }
    }

    /// The underline’s height.
    @IBInspectable open dynamic var underlineHeight: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }

    /// The underline’s color.
    @IBInspectable open dynamic var underlineColor: UIColor = .clear {
        didSet {
            setNeedsLayout()
        }
    }

    /// Activate or deactivate the focus on the textfield. Returns true if succeed.
    @discardableResult
    open func activeKeyboard(_ isActive: Bool) -> Bool {
        return isActive ? textField.becomeFirstResponder() : textField.resignFirstResponder()
    }

    // MARK: - Private IBAction functions

    @IBAction private func selectTextField() {
        textField.becomeFirstResponder()
    }

    /// Asks the delegate if the text field change the text of the text field.
    @IBAction private func editingChanged(_ textField: UITextField) {
        text = textField.text ?? ""
        delegate?.editingChanged(self)
    }

    // MARK: - Life cycle functions

    /// Default setup to load the view from a xib file.
    override open func xibSetup() {
        super.xibSetup()

        textField.delegate = self
    }

    /// Lays out subviews.
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
        textField.textColor = textColor
        textField.font = textFieldFont
        textField.keyboardType = keyboardType
        textField.keyboardAppearance = keyboardAppearance
        textField.returnKeyType = keyboardReturnKeyType
        textField.autocorrectionType = keyboardAutocorrectionType
        textField.enablesReturnKeyAutomatically = keyboardEnablesReturnKeyAutomatically

        underlineHeightConstraint.constant = underlineHeight
        underlineView.backgroundColor = underlineColor
    }
}

extension MUTextField: UITextFieldDelegate {
    /// Asks the delegate if editing should begin in the specified text field.
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.didSelect(self)
        return isEditable
    }

    /// Asks the delegate if the text field should process the pressing of the return button.
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.didReturn(self)
        return true
    }
}
