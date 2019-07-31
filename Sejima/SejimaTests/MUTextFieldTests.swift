//
//  MUTextFieldTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 26/02/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import XCTest
@testable import Sejima

class MUTextFieldTests: XCTestCase {

    func testDefaultValues() {
        let textField = MUTextField()
        XCTAssertNotNil(textField)

        XCTAssertEqual(textField.title, "")
        XCTAssertEqual(textField.titleColor, .white)
        XCTAssertEqual(textField.titleFont, .systemFont(ofSize: UIFont.systemFontSize, weight: .medium))
        XCTAssertEqual(textField.text, "")
        XCTAssertEqual(textField.placeholder, "")
        XCTAssertEqual(textField.placeholderColor, .lightGray)
        XCTAssertEqual(textField.textAlignment, .left)
        XCTAssertEqual(textField.textColor, .white)
        XCTAssertEqual(textField.textFieldFont, .systemFont(ofSize: UIFont.systemFontSize, weight: .medium))
        XCTAssertEqual(textField.keyboardType, .default)
        XCTAssertEqual(textField.keyboardAppearance, .default)
        XCTAssertEqual(textField.keyboardReturnKeyType, .default)
        XCTAssertEqual(textField.autocorrectionType, .default)
        XCTAssertEqual(textField.autocapitalizationType, .none)
        XCTAssertEqual(textField.isEditable, true)
        XCTAssertEqual(textField.underlineHeight, 0.0)
        XCTAssertEqual(textField.underlineColor, .clear)
        XCTAssertEqual(textField.keyboardEnablesReturnKeyAutomatically, false)
        XCTAssertEqual(textField.isSecure, false)
    }

    //swiftlint:disable:next function_body_length
    func testCustomValues() {
        let textField = MUTextField()
        XCTAssertNotNil(textField)

        textField.activeKeyboard(true)

        textField.title = "Text field"
        textField.titleColor = .lightGray
        textField.titleFont = .systemFont(ofSize: 8.0, weight: .bold)
        textField.text = "Delete me"
        textField.placeholder = "Enter your email address"
        textField.placeholderColor = .darkGray
        textField.textAlignment = .center
        textField.textColor = .black
        textField.textFieldFont = .systemFont(ofSize: 12.0, weight: .regular)
        textField.keyboardType = .emailAddress
        textField.keyboardAppearance = .dark
        textField.keyboardReturnKeyType = .done
        textField.autocorrectionType = .yes
        textField.autocapitalizationType = .sentences
        textField.isEditable = false
        textField.underlineHeight = 1.0
        textField.underlineColor = .lightGray
        textField.keyboardEnablesReturnKeyAutomatically = true
        textField.isSecure = true

        textField.layoutSubviews()

        textField.activeKeyboard(false)

        XCTAssertEqual(textField.title, "Text field")
        XCTAssertEqual(textField.titleColor, .lightGray)
        XCTAssertEqual(textField.titleFont, .systemFont(ofSize: 8.0, weight: .bold))
        XCTAssertEqual(textField.text, "Delete me")
        XCTAssertEqual(textField.placeholder, "Enter your email address")
        XCTAssertEqual(textField.placeholderColor, .darkGray)
        XCTAssertEqual(textField.textAlignment, .center)
        XCTAssertEqual(textField.textColor, .black)
        XCTAssertEqual(textField.textFieldFont, .systemFont(ofSize: 12.0, weight: .regular))
        XCTAssertEqual(textField.keyboardType, .emailAddress)
        XCTAssertEqual(textField.keyboardAppearance, .dark)
        XCTAssertEqual(textField.keyboardReturnKeyType, .done)
        XCTAssertEqual(textField.autocorrectionType, .yes)
        XCTAssertEqual(textField.autocapitalizationType, .sentences)
        XCTAssertEqual(textField.isEditable, false)
        XCTAssertEqual(textField.underlineHeight, 1.0)
        XCTAssertEqual(textField.underlineColor, .lightGray)
        XCTAssertEqual(textField.keyboardEnablesReturnKeyAutomatically, true)
        XCTAssertEqual(textField.isSecure, true)
    }

    func testTextAlignmentInt() {
        let textField = MUTextField()
        XCTAssertNotNil(textField)

        XCTAssertEqual(textField.textAlignmentInt, 0)

        textField.textAlignment = .center

        XCTAssertEqual(textField.textAlignmentInt, 1)

        textField.textAlignmentInt = 2

        XCTAssertEqual(textField.textAlignment, .right)

        textField.textAlignmentInt = -2 // Wrong value

        XCTAssertEqual(textField.textAlignment.rawValue, -2)
    }

    func testKeyboardTypeInt() {
        let textField = MUTextField()
        XCTAssertNotNil(textField)

        XCTAssertEqual(textField.keyboardTypeInt, 0)

        textField.keyboardType = .URL

        XCTAssertEqual(textField.keyboardTypeInt, 3)

        textField.keyboardTypeInt = 7

        XCTAssertEqual(textField.keyboardType, .emailAddress)

        textField.keyboardTypeInt = -2 // Wrong value

        XCTAssertEqual(textField.keyboardType.rawValue, -2)
    }

    func testKeyboardAppearanceInt() {
        let textField = MUTextField()
        XCTAssertNotNil(textField)

        XCTAssertEqual(textField.keyboardAppearanceInt, 0)

        textField.keyboardAppearance = .dark

        XCTAssertEqual(textField.keyboardAppearanceInt, 1)

        textField.keyboardAppearanceInt = 2

        XCTAssertEqual(textField.keyboardAppearance, .light)

        textField.keyboardAppearanceInt = -2 // Wrong value

        XCTAssertEqual(textField.keyboardAppearance.rawValue, -2)
    }
}
