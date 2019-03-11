//
//  MUCardTests.swift
//  Tests
//
//  Created by Loïc GRIFFIE on 01/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUCardTests: XCTestCase {

    func testDefaultValues() {
        let card = MUCard()
        XCTAssertNotNil(card)

        XCTAssertNil(card.backgroundColor)
        XCTAssertEqual(card.contentLeftPadding, 16)
        XCTAssertEqual(card.contentRightPadding, 16)
        XCTAssertEqual(card.topPadding, 12)
        XCTAssertEqual(card.contentTopPadding, 16)
        XCTAssertEqual(card.contentBottomPadding, 16)
        XCTAssertEqual(card.styleInt, 0)
        XCTAssertEqual(card.radius, 0)
        XCTAssertEqual(card.borderWidth, 2)
        XCTAssertEqual(card.borderColor, .white)
        XCTAssertEqual(card.textAlignment, .left)
        XCTAssertEqual(card.title, "")
        XCTAssertEqual(card.titleFont, .systemFont(ofSize: 34, weight: .regular))
        XCTAssertEqual(card.titleColor, .white)
        XCTAssertEqual(card.detail, "")
        XCTAssertEqual(card.detailFont, .systemFont(ofSize: 14, weight: .semibold))
        XCTAssertEqual(card.detailColor, .white)
    }

    func testCustomValues() {
        let card = MUCard()
        XCTAssertNotNil(card)

        card.topPadding = 50
        card.contentLeftPadding = 50
        card.contentRightPadding = 50
        card.contentTopPadding = 50
        card.contentBottomPadding = 50
        card.backgroundColor = .red
        card.radius = 10
        card.borderWidth = 10
        card.borderColor = .white
        card.textAlignment = .center
        card.title = "My tag"
        card.titleFont = .systemFont(ofSize: 34, weight: .regular)
        card.titleColor = .green
        card.detail = "My dummy information text"
        card.detailFont = .systemFont(ofSize: 14, weight: .light)
        card.detailColor = .orange

        XCTAssertEqual(card.topPadding, 50)
        XCTAssertEqual(card.contentLeftPadding, 50)
        XCTAssertEqual(card.contentRightPadding, 50)
        XCTAssertEqual(card.contentTopPadding, 50)
        XCTAssertEqual(card.contentBottomPadding, 50)
        XCTAssertEqual(card.backgroundColor, .red)
        XCTAssertEqual(card.styleInt, 0)
        XCTAssertEqual(card.radius, 10)
        XCTAssertEqual(card.borderWidth, 10)
        XCTAssertEqual(card.borderColor, .white)
        XCTAssertEqual(card.textAlignment, .center)
        XCTAssertEqual(card.title, "My tag")
        XCTAssertEqual(card.titleFont, .systemFont(ofSize: 34, weight: .regular))
        XCTAssertEqual(card.titleColor, .green)
        XCTAssertEqual(card.detail, "My dummy information text")
        XCTAssertEqual(card.detailFont, .systemFont(ofSize: 14, weight: .light))
        XCTAssertEqual(card.detailColor, .orange)
    }

    func testRadiusValues() {
        let card = MUCard()
        XCTAssertNotNil(card)

        card.styleInt = 1

        XCTAssertEqual(card.style, .custom(0))
    }

    func testAlignmentValues() {
        let card = MUCard()
        XCTAssertNotNil(card)

        card.textAlignmentInt = 2

        XCTAssertEqual(card.textAlignment, .right)
    }

    func testPaddingValues() {
        let card = MUCard()
        XCTAssertNotNil(card)

        card.title = ""
        card.detail = ""

        XCTAssertEqual(card.topPadding, 0)
        XCTAssertEqual(card.contentTopPadding, 0)
    }
}
