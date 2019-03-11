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
}
