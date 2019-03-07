//
//  MUProportionalBarTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 25/02/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import XCTest
@testable import Sejima

class MUProportionalBarTests: XCTestCase {

    func testDefaultValues() {
        let progress = MUProportionalBar()
        XCTAssertNotNil(progress)

        XCTAssertEqual(progress.style, .square)
        XCTAssertEqual(progress.styleInt, 0)
        XCTAssertEqual(progress.radius, 0.0)
        XCTAssertEqual(progress.titleOffset, 4.0)
        XCTAssertEqual(progress.titleHorizontalPadding, 4.0)
        XCTAssertEqual(progress.titleFont, .systemFont(ofSize: 12, weight: .regular))
    }

    func testCustomValues() {
        let progress = MUProportionalBar()
        XCTAssertNotNil(progress)

        progress.radius = 15.0
        progress.titleOffset = 8.0
        progress.titleHorizontalPadding = 12.0
        progress.titleFont = .systemFont(ofSize: 20)

        progress.layoutSubviews()

        XCTAssertEqual(progress.radius, 15.0)
        XCTAssertEqual(progress.titleOffset, 8.0)
        XCTAssertEqual(progress.titleHorizontalPadding, 12.0)
        XCTAssertEqual(progress.titleFont, .systemFont(ofSize: 20, weight: .regular))
    }

    func testStyleInt() {
        let progress = MUProportionalBar()
        XCTAssertNotNil(progress)

        XCTAssertEqual(progress.styleInt, 0)
        XCTAssertEqual(progress.style, .square)

        progress.styleInt = 1
        XCTAssertEqual(progress.style, .round)

        progress.styleInt = 2
        XCTAssertEqual(progress.style, .custom(0))
    }

    func testProgressRadius() {
        let progress = MUProportionalBar()
        XCTAssertNotNil(progress)

        progress.radius = 6
        XCTAssertEqual(progress.style, .custom(6))
    }

    func testItems() {
        let progress = MUProportionalBar()
        XCTAssertNotNil(progress)

        progress.items = [
            MUProportionalItem(value: 0.40, title: "Low", color: .orange)
        ]
        progress.layoutSubviews()

        guard let item = progress.items.first else {
            XCTAssert(false, "No progress item")
            return
        }

        XCTAssertEqual(item.title, "Low")
        XCTAssertEqual(item.value, 0.40)
        XCTAssertEqual(item.color, .orange)
    }
}
