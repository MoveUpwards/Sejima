//
//  MUTimeTests.swift
//  Tests
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUTimeTests: XCTestCase {

    func testDefaultValues() {
        let time = MUTime()
        XCTAssertNotNil(time)

        XCTAssertEqual(time.font, .systemFont(ofSize: 13, weight: .bold))
        XCTAssertEqual(time.indicatorMinValue, 0)
        XCTAssertEqual(time.indicatorMaxValue, 90)
        XCTAssertEqual(time.indicatorStartAngle, 0.0)
        XCTAssertEqual(time.indicatorEndAngle, 360.0)
        XCTAssertEqual(time.animationDuration, 0.3)
        XCTAssertEqual(time.indicatorLineCap, .round)
        XCTAssertEqual(time.color, .clear)
        XCTAssertEqual(time.timeBackgroundColor, .clear)
        XCTAssertEqual(time.indicatorColor, .clear)
        XCTAssertEqual(time.indicatorWidth, 8)
        XCTAssertEqual(time.format, "%.f")
        XCTAssertEqual(time.showValue, true)
    }

    func testCustomValues() {
        let time = MUTime()
        XCTAssertNotNil(time)

        time.backgroundColor = .white
        time.font = .systemFont(ofSize: 15)
        time.indicatorMinValue = 0
        time.indicatorMaxValue = 120
        time.indicatorStartAngle = 270
        time.indicatorEndAngle = 90
        time.animationDuration = 0.75
        time.indicatorLineCap = .round
        time.color = .black
        time.timeBackgroundColor = .orange
        time.indicatorColor = .green
        time.indicatorWidth = 2
        time.format = "%.f%%"
        time.showValue = false

        XCTAssertEqual(time.font, .systemFont(ofSize: 15))
        XCTAssertEqual(time.backgroundColor, .white)
        XCTAssertEqual(time.indicatorMinValue, 0)
        XCTAssertEqual(time.indicatorMaxValue, 120)
        XCTAssertEqual(time.indicatorStartAngle, 270.0)
        XCTAssertEqual(time.indicatorEndAngle, 90.0)
        XCTAssertEqual(time.animationDuration, 0.75)
        XCTAssertEqual(time.indicatorLineCap, .round)
        XCTAssertEqual(time.color, .black)
        XCTAssertEqual(time.timeBackgroundColor, .orange)
        XCTAssertEqual(time.indicatorColor, .green)
        XCTAssertEqual(time.indicatorWidth, 2)
        XCTAssertEqual(time.format, "%.f%%")
        XCTAssertEqual(time.showValue, false)
    }
}
