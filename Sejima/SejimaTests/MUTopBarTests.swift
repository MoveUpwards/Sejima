//
//  MUTopBarTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 26/02/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import XCTest
@testable import Sejima

class MUTopBarTests: XCTestCase {

    func testDefaultValues() {
        let bar = MUTopBar()
        XCTAssertNotNil(bar)

        XCTAssertEqual(bar.title, "")
        XCTAssertEqual(bar.buttonAlignment, .center)
        XCTAssertEqual(bar.titleAlignment, .center)
        XCTAssertEqual(bar.titleFont, .systemFont(ofSize: 24.0, weight: .bold))
        XCTAssertEqual(bar.buttonImage, nil)
        XCTAssertEqual(bar.buttonLeftPadding, 0.0)
        XCTAssertEqual(bar.titleColor, .white)
        XCTAssertEqual(bar.showButton, false)
    }

    func testCustomValues() {
        let bar = MUTopBar()
        XCTAssertNotNil(bar)

        bar.title = "Main Page"
        bar.buttonAlignment = .left
        bar.titleAlignment = .left
        bar.titleFont = .systemFont(ofSize: 18.0, weight: .regular)
        bar.buttonImage = UIImage(named: "left_button")
        bar.buttonLeftPadding = 4.0
        bar.titleColor = .black

        bar.layoutSubviews()

        bar.showButton = true

        bar.updateConstraints()

        XCTAssertEqual(bar.title, "Main Page")
        XCTAssertEqual(bar.buttonAlignment, .left)
        XCTAssertEqual(bar.titleAlignment, .left)
        XCTAssertEqual(bar.titleFont, .systemFont(ofSize: 18.0, weight: .regular))
        XCTAssertEqual(bar.buttonImage, nil)
        XCTAssertEqual(bar.buttonLeftPadding, 4.0)
        XCTAssertEqual(bar.titleColor, .black)
        XCTAssertEqual(bar.showButton, true)
    }

    func testTitleAlignmentInt() {
        let bar = MUTopBar()
        XCTAssertNotNil(bar)

        XCTAssertEqual(bar.titleAlignmentInt, 0)

        bar.titleAlignment = .left

        XCTAssertEqual(bar.titleAlignmentInt, 1)

        bar.titleAlignmentInt = 2

        XCTAssertEqual(bar.titleAlignment, .right)

        bar.titleAlignmentInt = -2 // Wrong value

        XCTAssertEqual(bar.titleAlignment.rawValue, -2)
    }
}
