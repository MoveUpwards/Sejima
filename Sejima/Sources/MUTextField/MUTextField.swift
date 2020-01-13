//
//  MUTextField.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 05/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Delegate protocol for MUTextField.
@objc public protocol MUTextFieldDelegate: class {
    /// Will trigger each time textfield is selected.
    func didSelect(textField: MUTextField)
    /// Will trigger each time textfield loose focus.
    func didReturn(textField: MUTextField)
    /// Will trigger each time textfield is modifying the text.
    func editingChanged(textField: MUTextField)
}

/// Class that act like UITextField with more customizable options.
@IBDesignable
open class MUTextField: MUNibView {
    @IBOutlet private var label: UILabel!
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var underlineView: UIView!

    @IBOutlet private var underlineHeightConstraint: NSLayoutConstraint!

    /// The object that acts as the delegate of the textfield.
    @IBOutlet public weak var delegate: MUTextFieldDelegate? // swiftlint:disable:this private_outlet strong_iboutlet line_length

    // MARK: - Public IBInspectable variables ONLY

    /// The current title that is shown on top of the textfield.
    @IBInspectable open var title: String = "" {
        didSet {
            label.text = title
        }
    }

    // MARK: - Public UIAppearence variables ONLY

    /// The title’s font.
    @objc open dynamic var titleFont: UIFont = .systemFont(ofSize: UIFont.systemFontSize, weight: .medium) {
        didSet {
            label.font = titleFont
        }
    }

    /// The title and textfield text horizontal alignment.
    @objc open dynamic var textAlignment: NSTextAlignment = .left {
        didSet {
            label.textAlignment = textAlignment
            textField.textAlignment = textAlignment
        }
    }

    /// The textfield’s font.
    @objc open dynamic var textFieldFont: UIFont = .systemFont(ofSize: UIFont.systemFontSize, weight: .medium) {
        didSet {
            textField.font = textFieldFont
        }
    }

    /// The keyboard style associated with the text object.
    @objc open dynamic var keyboardType: UIKeyboardType = .default {
        didSet {
            textField.keyboardType = keyboardType
        }
    }

    /// The textfield text content type. Only available from iOS 10
    @objc open dynamic var textContentType: UITextContentType? = nil {
        didSet {
            if #available(iOS 10.0, *) {
                textField.textContentType = textContentType
            }
        }
    }

    /// The appearance style of the keyboard that is associated with the text object.
    @objc open dynamic var keyboardAppearance: UIKeyboardAppearance = .default {
        didSet {
            textField.keyboardAppearance = keyboardAppearance
        }
    }

    /// The visible title of the Return key.
    @objc open dynamic var keyboardReturnKeyType: UIReturnKeyType = .default {
        didSet {
            textField.returnKeyType = keyboardReturnKeyType
        }
    }

    /// A Boolean value indicating whether the Return key is automatically enabled when the user is entering text.
    @objc open dynamic var keyboardEnablesReturnKeyAutomatically: Bool = false {
        didSet {
            textField.enablesReturnKeyAutomatically = keyboardEnablesReturnKeyAutomatically
        }
    }

    /// The autocorrection style for the text object.
    @objc open dynamic var autocorrectionType: UITextAutocorrectionType = .default {
        didSet {
            textField.autocorrectionType = autocorrectionType
        }
    }

    /// The autocorrection style for the text object.
    @objc open dynamic var autocapitalizationType: UITextAutocapitalizationType = .none {
        didSet {
            textField.autocapitalizationType = autocapitalizationType
        }
    }

    // MARK: - Public IBInspectable and UIAppearence variables

    /// The title’s color.
    @IBInspectable open dynamic var titleColor: UIColor = .white {
        didSet {
            label.textColor = titleColor
        }
    }

    /// The text displayed by the text field.
    @IBInspectable open var text: String? = nil {
        didSet {
            textField.text = text
        }
    }

    /// The string that is displayed when there is no other text in the text field.
    @IBInspectable open var placeholder: String = "" {
        didSet {
            updatePlaceholder()
        }
    }

    /// The placehodler's color.
    @IBInspectable open dynamic var placeholderColor: UIColor = .lightGray {
        didSet {
            updatePlaceholder()
        }
    }

    /// Optional: The IBInspectable version of the title and textfield text horizontal alignment.
    @IBInspectable open dynamic var textAlignmentInt: Int {
        get {
            return textAlignment.rawValue
        }
        set {
            textAlignment = NSTextAlignment(rawValue: newValue) ?? .left
        }
    }

    /// The color of the text.
    @IBInspectable open dynamic var textColor: UIColor = .white {
        didSet {
           textField.textColor = textColor
        }
    }

    /// Optional: The IBInspectable version of the return key's visible title.
    @IBInspectable open dynamic var keyboardTypeInt: Int {
        get {
            return keyboardType.rawValue
        }
        set {
            keyboardType = UIKeyboardType(rawValue: newValue) ?? .default
        }
    }

    /// Optional: The IBInspectable version of the keyboard's appearance style.
    @IBInspectable open dynamic var keyboardAppearanceInt: Int {
        get {
            return keyboardAppearance.rawValue
        }
        set {
            keyboardAppearance = UIKeyboardAppearance(rawValue: newValue) ?? .default
        }
    }

    /// Identifies whether the text object should disable text copying and in some cases hide the text being entered.
    @IBInspectable open dynamic var isSecure: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecure
        }
    }

    /// Identifies whether the text field should respond to user edit.
    @IBInspectable open dynamic var isEditable: Bool = true

    /// The underline’s height.
    @IBInspectable open dynamic var underlineHeight: CGFloat = 0.0 {
        didSet {
            underlineHeightConstraint.constant = underlineHeight
        }
    }

    /// The underline’s color.
    @IBInspectable open dynamic var underlineColor: UIColor = .clear {
        didSet {
            underlineView.backgroundColor = underlineColor
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
        delegate?.editingChanged(textField: self)
    }

    // MARK: - Private functions

    private func updatePlaceholder() {
        textField.attributedPlaceholder =
            NSAttributedString(string: placeholder, attributes: [.foregroundColor: placeholderColor])
    }

    // MARK: - Life cycle functions

    /// Default setup to load the view from a xib file.
    override open func xibSetup() {
        super.xibSetup()

        textField.delegate = self
    }

    /// The natural size for the receiving view, considering only properties of the view itself.
    override open var intrinsicContentSize: CGSize {
        return .zero
    }
}

extension MUTextField: UITextFieldDelegate {
    /// Asks the delegate if editing should begin in the specified text field.
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.didSelect(textField: self)
        return isEditable
    }

    /// Asks the delegate if the text field should process the pressing of the return button.
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.didReturn(textField: self)
        return true
    }
}
