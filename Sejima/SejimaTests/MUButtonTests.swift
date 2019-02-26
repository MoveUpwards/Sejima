//
//  MUButtonTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 21/02/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import XCTest
@testable import Sejima

class MUButtonTests: XCTestCase {

    func testDefaultValues() {
        let button = MUButton()
        XCTAssertNotNil(button)

        XCTAssertEqual(button.title, "")
        XCTAssertEqual(button.titleAlignment, .center)
        XCTAssertEqual(button.titleFont, .systemFont(ofSize: 17.0, weight: .regular))
        XCTAssertEqual(button.state, .normal)
        XCTAssertEqual(button.disabledAlphaValue, 0.7)
        XCTAssertEqual(button.buttonBackgroundColor, .white)
        XCTAssertEqual(button.borderColor, .clear)
        XCTAssertEqual(button.titleColor, .white)
        XCTAssertEqual(button.titleHighlightedColor, .white)
        XCTAssertEqual(button.progressColor, .white)
        XCTAssertEqual(button.borderWidth, 0.0)
        XCTAssertEqual(button.cornerRadius, 0.0)
        XCTAssertEqual(button.verticalPadding, 0.0)
        XCTAssertEqual(button.horizontalPadding, 8.0)
        XCTAssertEqual(button.isLoading, false)
    }

    func testCustomValues() {
        let button = MUButton()
        XCTAssertNotNil(button)

        button.title = "My button"
        button.titleAlignment = .left
        button.titleFont = .systemFont(ofSize: 14.0, weight: .bold)
        button.state = .disabled
        button.disabledAlphaValue = 0.6
        button.buttonBackgroundColor = .red
        button.borderColor = .orange
        button.titleColor = .blue
        button.titleHighlightedColor = .green
        button.progressColor = .yellow
        button.borderWidth = 2.0
        button.cornerRadius = 4.0
        button.verticalPadding = 6.0
        button.horizontalPadding = 0.0

        XCTAssertEqual(button.title, "My button")
        XCTAssertEqual(button.titleAlignment, .left)
        XCTAssertEqual(button.titleFont, .systemFont(ofSize: 14.0, weight: .bold))
        XCTAssertEqual(button.state, .disabled)
        XCTAssertEqual(button.disabledAlphaValue, 0.6)
        XCTAssertEqual(button.buttonBackgroundColor, .red)
        XCTAssertEqual(button.borderColor, .orange)
        XCTAssertEqual(button.titleColor, .blue)
        XCTAssertEqual(button.titleHighlightedColor, .green)
        XCTAssertEqual(button.progressColor, .yellow)
        XCTAssertEqual(button.borderWidth, 2.0)
        XCTAssertEqual(button.cornerRadius, 4.0)
        XCTAssertEqual(button.verticalPadding, 6.0)
        XCTAssertEqual(button.horizontalPadding, 0.0)
    }

    func testLoading() {
        let button = MUButton()
        XCTAssertNotNil(button)

        button.isLoading = true

        XCTAssertEqual(button.isUserInteractionEnabled, false)
        XCTAssertEqual(button.isLoading, true)
    }

}
