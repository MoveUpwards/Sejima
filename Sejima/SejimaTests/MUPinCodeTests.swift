//
//  MUPinCodeTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 25/02/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import XCTest
@testable import Sejima

class MUPinCodeTests: XCTestCase {

    func testDefaultValues() {
        let pinCode = MUPinCode()
        XCTAssertNotNil(pinCode)

        XCTAssertEqual(pinCode.pinCount, 4)
        XCTAssertEqual(pinCode.allowCharactersInt, 0)
        XCTAssertEqual(pinCode.allowCharacters, .all)
        XCTAssertEqual(pinCode.keyboardType, .default)
        XCTAssertEqual(pinCode.keyboardTypeInt, 0)
        XCTAssertEqual(pinCode.keyboardAppearance, .default)
        XCTAssertEqual(pinCode.keyboardAppearanceInt, 0)
        XCTAssertEqual(pinCode.cellColor, .white)
        XCTAssertEqual(pinCode.cellCornerRadius, 10.0)
        XCTAssertEqual(pinCode.cellSpacing, 10.0)
        XCTAssertEqual(pinCode.cellFont, .systemFont(ofSize: UIFont.systemFontSize, weight: .medium))
        XCTAssertEqual(pinCode.emptyCharacter, "•")
    }

    func testCustomValues() {
        let pinCode = MUPinCode()
        XCTAssertNotNil(pinCode)

        pinCode.pinCount = 8
        pinCode.allowCharacters = .letter
        pinCode.keyboardType = .numberPad
        pinCode.keyboardAppearance = .dark
        pinCode.cellColor = .orange
        pinCode.cellCornerRadius = 4.0
        pinCode.cellSpacing = 2.0
        pinCode.cellFont = .systemFont(ofSize: 12)
        pinCode.emptyCharacter = "🦊"

        XCTAssertEqual(pinCode.pinCount, 8)
        XCTAssertEqual(pinCode.allowCharacters, .letter)
        XCTAssertEqual(pinCode.keyboardType, .numberPad)
        XCTAssertEqual(pinCode.keyboardAppearance, .dark)
        XCTAssertEqual(pinCode.cellColor, .orange)
        XCTAssertEqual(pinCode.cellCornerRadius, 4.0)
        XCTAssertEqual(pinCode.cellSpacing, 2.0)
        XCTAssertEqual(pinCode.cellFont, .systemFont(ofSize: 12))
        XCTAssertEqual(pinCode.emptyCharacter, "🦊")
    }

    func testAllowedCharacters() {
        let pinCode = MUPinCode()
        XCTAssertNotNil(pinCode)

        pinCode.allowCharactersInt = 2
        XCTAssertEqual(pinCode.allowCharacters, .alphanumeric)

        pinCode.allowCharactersInt = 0
        XCTAssertEqual(pinCode.allowCharacters, .number)

        pinCode.allowCharactersInt = 1
        XCTAssertEqual(pinCode.allowCharacters, .letter)

        pinCode.allowCharactersInt = -2 // All invalid values will be .all
        XCTAssertEqual(pinCode.allowCharacters, .all)

        pinCode.allowCharactersInt = 3 // Custom not available with int property
        XCTAssertEqual(pinCode.allowCharacters, .all)
    }

    func testActiveKeyboard() {
        let pinCode = MUPinCode()
        XCTAssertNotNil(pinCode)

        pinCode.activeKeyboard(true) // Show keyboard
        pinCode.activeKeyboard(false) // Hide keyboard
    }

    func testKeyboardType() {
        let pinCode = MUPinCode()
        XCTAssertNotNil(pinCode)

        pinCode.keyboardTypeInt = 4
        XCTAssertEqual(pinCode.keyboardType, .numberPad)
    }

    func testKeyboardAppearance() {
        let pinCode = MUPinCode()
        XCTAssertNotNil(pinCode)

        pinCode.keyboardAppearanceInt = 1
        XCTAssertEqual(pinCode.keyboardAppearance, .dark)
    }

    func testCode() {
        let pinCode = MUPinCode()
        XCTAssertNotNil(pinCode)
        XCTAssertEqual(pinCode.code, "")

        pinCode.set(code: "ABCD")

        XCTAssertEqual(pinCode.code, "ABCD")

        pinCode.reset()

        XCTAssertEqual(pinCode.code, "")

        pinCode.pinCount = 2
        pinCode.set(code: "ABCD")

        XCTAssertEqual(pinCode.code, "")

        pinCode.set(code: "AB")

        XCTAssertEqual(pinCode.code, "AB")

        pinCode.set(code: "ABCD")

        XCTAssertEqual(pinCode.code, "AB")
    }
}
