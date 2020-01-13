//
//  MUPinCode.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 05/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Delegate protocol for MUPinCode.
@objc public protocol MUPinCodeDelegate: class {
    /// Will trigger each time an entry is added.
    func didUpdate(pinCode: MUPinCode, with code: String)
}

/// Class that provide a pin code like component with customizable options.
@IBDesignable
open class MUPinCode: MUNibView {
    @IBOutlet private var stackView: UIStackView!
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var tapView: UIView!

    /// The object that acts as the delegate of the pin code.
    @IBOutlet public weak var delegate: MUPinCodeDelegate? // swiftlint:disable:this private_outlet strong_iboutlet line_length

    /// Describes the pin code caracters set allowed
    open var allowCharacters: MUPinCodeCharacterSet = .all

    /// Return the current code
    open var code: String {
        return textField.text ?? ""
    }

    // MARK: - Public IBInspectable variables ONLY

    /// Describes the MUPinCode's cell's number shown
    @IBInspectable open dynamic var pinCount: Int = 4 {
        didSet {
            layoutPinCodeCell()
        }
    }

    /// Optional: The IBInspectable version of the pin code allowCharacters.
    @IBInspectable open dynamic var allowCharactersInt: Int = 0 {
        didSet {
            allowCharacters = {
                switch allowCharactersInt {
                case 0:
                    return .number
                case 1:
                    return .letter
                case 2:
                    return .alphanumeric
                default: // Int value doesn't allow custom setting
                    return .all
                }
            }()
        }
    }

    // MARK: - Public IBInspectable and UIAppearence variables

    /// Describes the pin code related keyboard type
    @objc open dynamic var keyboardType: UIKeyboardType = .default {
        didSet {
            textField.keyboardType = keyboardType
        }
    }

    /// Describes the pin code related keyboard appearance
    @objc open dynamic var keyboardAppearance: UIKeyboardAppearance = .default {
        didSet {
            textField.keyboardAppearance = keyboardAppearance
        }
    }

    /// Describes the MUPinCode's cell's background color appearance while it shows
    @IBInspectable open dynamic var cellColor: UIColor = .white {
        didSet {
            stackView.arrangedSubviews.forEach({ ($0 as? MUPinCodeCell)?.backgroundColor = cellColor })
        }
    }

    /// Describes the MUPinCode's cell's corner radius appearance while it shows
    @IBInspectable open dynamic var cellCornerRadius: CGFloat = 10.0 {
        didSet {
            stackView.arrangedSubviews.forEach({ ($0 as? MUPinCodeCell)?.layer.cornerRadius = cellCornerRadius })
        }
    }

    /// Describes the MUPinCode's cell's spacing appearance while it shows
    @IBInspectable open dynamic var cellSpacing: CGFloat = 10.0 {
        didSet {
            stackView.spacing = cellSpacing
        }
    }

    /// Describes the MUPinCode's font appearance while it shows
    @objc open dynamic var cellFont: UIFont = .systemFont(ofSize: UIFont.systemFontSize, weight: .medium) {
        didSet {
            stackView.arrangedSubviews.forEach({ ($0 as? MUPinCodeCell)?.set(font: cellFont) })
        }
    }

    /// Describes the MUPinCode's cell's empty text while it shows
    @IBInspectable open dynamic var emptyCharacter: String = "•" {
        didSet {
            stackView.arrangedSubviews.forEach({ ($0 as? MUPinCodeCell)?.set(emptyCharacter: emptyCharacter) })
        }
    }

    /// Describes the MUPinCode's cell's empty text while it shows
    @IBInspectable open dynamic var secureCharacter: String? = nil {
        didSet {
            if #available(iOS 10.0, *) {
                stackView.arrangedSubviews.forEach({ ($0 as? MUPinCodeCell)?.set(secureCharacter: secureCharacter) })
            } else {
                print("Unavailable on iOS 9 and earlier")
            }
        }
    }

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @IBInspectable open dynamic var keyboardTypeInt: Int = 0 {
        didSet {
            keyboardType = UIKeyboardType(rawValue: keyboardTypeInt) ?? .default
        }
    }

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @IBInspectable open dynamic var keyboardAppearanceInt: Int = 0 {
        didSet {
            keyboardAppearance = UIKeyboardAppearance(rawValue: keyboardAppearanceInt) ?? .default
        }
    }

    // MARK: - Public functions

    /// Reset all pin cell caracters to default
    open func reset() {
        textField.text = ""
        stackView.arrangedSubviews.forEach({ ($0 as? MUPinCodeCell)?.empty() })
    }

    /// Fill pin code with a given code
    open func set(code: String) {
        guard code.count <= stackView.subviews.count else {
            return
        }
        textField.text = code

        code.enumerated().forEach { index, char in
            (stackView.subviews[index] as? MUPinCodeCell)?.set(text: String(char))
        }
    }

    /// Show / hide keyboard
    open func activeKeyboard(_ isActive: Bool) {
        _ = isActive ? textField.becomeFirstResponder() : textField.resignFirstResponder()
    }

    // MARK: - Private functions

    private func layoutPinCodeCell() {
        stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })

        stackView.distribution = .fillEqually
        stackView.spacing = cellSpacing

        for _ in 1...pinCount {
            let cell = MUPinCodeCell(frame: .zero)
            cell.backgroundColor = cellColor
            cell.layer.cornerRadius = cellCornerRadius
            cell.set(font: cellFont)
                .set(emptyCharacter: emptyCharacter)
                .empty()
            stackView.addArrangedSubview(cell)
        }
    }

    private func isValid(_ string: String) -> Bool {
        switch allowCharacters {
        case .number:
            return string.isDigits
        case .letter:
            return string.isLetters
        case .alphanumeric:
            return string.isAlphanumerics
        case .custom(let rexep):
            return string.isValidRegex(rexep)
        case .all:
            return true
        }
    }

    @objc
    private func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            activeKeyboard(true)
        }
    }

    // MARK: - Life cycle functions

    /// Default setup to load the view from a xib file.
    override open func xibSetup() {
        super.xibSetup()

        textField.delegate = self

        tapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:))))
        tapView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleTap(sender:))))

        layoutPinCodeCell()
    }

    /// The natural size for the receiving view, considering only properties of the view itself.
    override open var intrinsicContentSize: CGSize {
        return CGSize(width: 250, height: 50)
    }
}

extension MUPinCode: UITextFieldDelegate {
    /// Handle pin code caracter replacement check
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return false
        }

        let textCount = text.utf16.count
        let addOneChar = string.count == 1 && isValid(string) && range.location == textCount && range.length == 0
        var removeOneChar = string == "" && range.location + range.length == textCount
        if removeOneChar, let lastCharacter = text.last {
            removeOneChar = range.length == String(lastCharacter).utf16.count
        }

        let index = text.count - (removeOneChar ? 1 : 0)
        guard addOneChar || removeOneChar,
            index < stackView.subviews.count else {
            return false
        }

        let cell = stackView.subviews[index] as? MUPinCodeCell
        if addOneChar {
            cell?.set(text: string.uppercased())
        } else {
            cell?.empty()
        }

        delegate?.didUpdate(pinCode: self, with: addOneChar ? text + string : String(text.dropLast()))

        return true
    }
}
