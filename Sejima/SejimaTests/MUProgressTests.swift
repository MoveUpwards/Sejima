//
//  MUProgressTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 25/02/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import XCTest
@testable import Sejima

class MUProgressTests: XCTestCase {

    func testDefaultValues() {
        let progress = MUProgress()
        XCTAssertNotNil(progress)

        XCTAssertEqual(progress.title, "")
        XCTAssertEqual(progress.titleFont, .systemFont(ofSize: 12, weight: .regular))
        XCTAssertEqual(progress.titleColor, .black)
        XCTAssertEqual(progress.trackColor, .white)
        XCTAssertEqual(progress.currentValue, 0.0)
        XCTAssertEqual(progress.thickness, 3.0)
        XCTAssertEqual(progress.color, .blue)
        XCTAssertEqual(progress.showIndicator, false)
        XCTAssertEqual(progress.indicatorMultiplier, 0.0)
        XCTAssertEqual(progress.indicatorFormat, "%.f")
        XCTAssertEqual(progress.indicatorWidth, 1.0)
        XCTAssertEqual(progress.indicatorFont, .systemFont(ofSize: 12, weight: .regular))
        XCTAssertEqual(progress.indicatorColor, .white)
        XCTAssertEqual(progress.indicatorValueColor, .black)
        XCTAssertEqual(progress.indicatorCornerRadius, 4.0)
        XCTAssertEqual(progress.indicatorBottomInset, 4.0)
    }

    func testCustomValues() {
        let progress = MUProgress()
        XCTAssertNotNil(progress)

        progress.title = "MY PROGRESS"
        progress.titleFont = .systemFont(ofSize: 20, weight: .bold)
        progress.titleColor = .orange
        progress.trackColor = .green
        progress.thickness = 15.0
        progress.color = .blue
        progress.showIndicator = true
        progress.indicatorMultiplier = 100
        progress.indicatorFormat = "%.2f"
        progress.indicatorWidth = 1.3
        progress.indicatorFont = .systemFont(ofSize: 15, weight: .semibold)
        progress.indicatorColor = .gray
        progress.indicatorValueColor = .purple
        progress.indicatorCornerRadius = 8.0
        progress.indicatorBottomInset = 10.0

        XCTAssertEqual(progress.title, "MY PROGRESS")
        XCTAssertEqual(progress.titleFont, .systemFont(ofSize: 20, weight: .bold))
        XCTAssertEqual(progress.titleColor, .orange)
        XCTAssertEqual(progress.trackColor, .green)
        XCTAssertEqual(progress.currentValue, 0.0)
        XCTAssertEqual(progress.thickness, 15.0)
        XCTAssertEqual(progress.color, .blue)
        XCTAssertEqual(progress.showIndicator, true)
        XCTAssertEqual(progress.indicatorMultiplier, 100.0)
        XCTAssertEqual(progress.indicatorFormat, "%.2f")
        XCTAssertEqual(progress.indicatorWidth, 1.3)
        XCTAssertEqual(progress.indicatorFont, .systemFont(ofSize: 15, weight: .semibold))
        XCTAssertEqual(progress.indicatorColor, .gray)
        XCTAssertEqual(progress.indicatorValueColor, .purple)
        XCTAssertEqual(progress.indicatorCornerRadius, 8.0)
        XCTAssertEqual(progress.indicatorBottomInset, 10.0)
    }

    func testProgressValue() {
        let progress = MUProgress()
        XCTAssertNotNil(progress)

        XCTAssertEqual(progress.currentValue, 0.0)

        progress.set(progress: 80)
        XCTAssertEqual(progress.currentValue, 80.0)
    }
}
