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
        XCTAssertEqual(textField.isEditable, true)
        XCTAssertEqual(textField.underlineHeight, 0.0)
        XCTAssertEqual(textField.underlineColor, .clear)
        XCTAssertEqual(textField.keyboardEnablesReturnKeyAutomatically, false)
    }

    func testCustomValues() {
        let textField = MUTextField()
        XCTAssertNotNil(textField)

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
        textField.isEditable = false
        textField.underlineHeight = 1.0
        textField.underlineColor = .lightGray
        textField.keyboardEnablesReturnKeyAutomatically = true

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
        XCTAssertEqual(textField.isEditable, false)
        XCTAssertEqual(textField.underlineHeight, 1.0)
        XCTAssertEqual(textField.underlineColor, .lightGray)
        XCTAssertEqual(textField.keyboardEnablesReturnKeyAutomatically, true)
    }

}
