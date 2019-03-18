//
//  MURadioButtonTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 15/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MURadioButtonTests: XCTestCase {

    func testDefaultValues() {
        let radio = MURadioButton()
        XCTAssertNotNil(radio)

        XCTAssertEqual(radio.selected, false)
        XCTAssertEqual(radio.borderWidth, 0)
        XCTAssertEqual(radio.borderColor, .white)
        XCTAssertEqual(radio.indicatorColor, .white)
        XCTAssertEqual(radio.indicatorPadding, 2)
    }

    func testCustomValues() {
        let radio = MURadioButton()
        XCTAssertNotNil(radio)

        radio.selected = true
        radio.borderWidth = 4
        radio.borderColor = .orange
        radio.indicatorColor = .green
        radio.indicatorPadding = 8

        radio.layoutSubviews()

        XCTAssertEqual(radio.selected, true)
        XCTAssertEqual(radio.borderWidth, 4)
        XCTAssertEqual(radio.borderColor, .orange)
        XCTAssertEqual(radio.indicatorColor, .green)
        XCTAssertEqual(radio.indicatorPadding, 8)

        radio.selected = false

        XCTAssertEqual(radio.selected, false)
    }
}
