//
//  MUTimeSliderTests.swift
//  SejimaTests
//
//  Created by Loïc GRIFFIE on 15/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUTimeSliderTests: XCTestCase {

    func testDefaultValues() {
        let slider = MUTimeSlider()
        XCTAssertNotNil(slider)

        XCTAssertEqual(slider.borderWidth, 0.0)
        XCTAssertEqual(slider.borderColor, .clear)
        XCTAssertEqual(slider.duration, 0.0)
        XCTAssertEqual(slider.indicatorWidth, 2.0)
        XCTAssertEqual(slider.indicatorColor, .white)
        XCTAssertEqual(slider.timeColor, .black)
        XCTAssertEqual(slider.timeFont, .systemFont(ofSize: 16.0))
        XCTAssertEqual(slider.timeTopPadding, 2.0)
        XCTAssertEqual(slider.timeHorizontalPadding, 2.0)
    }

    func testCustomValues() {
        let slider = MUTimeSlider()
        XCTAssertNotNil(slider)

        slider.borderWidth = 10.0
        slider.borderColor = .orange
        slider.duration = 200.0
        slider.indicatorWidth = 6.0
        slider.indicatorColor = .green
        slider.timeColor = .purple
        slider.timeFont = .systemFont(ofSize: 12.0)
        slider.timeTopPadding = 5.0
        slider.timeHorizontalPadding = 12.0

        XCTAssertEqual(slider.borderWidth, 10.0)
        XCTAssertEqual(slider.borderColor, .orange)
        XCTAssertEqual(slider.duration, 200.0)
        XCTAssertEqual(slider.indicatorWidth, 6.0)
        XCTAssertEqual(slider.indicatorColor, .green)
        XCTAssertEqual(slider.timeColor, .purple)
        XCTAssertEqual(slider.timeFont, .systemFont(ofSize: 12.0))
        XCTAssertEqual(slider.timeTopPadding, 5.0)
        XCTAssertEqual(slider.timeHorizontalPadding, 12.0)
    }

    func testSliderPosition() {
        let slider = MUTimeSlider(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        XCTAssertNotNil(slider)

        slider.duration = 200
        XCTAssertEqual(slider.currentTime, 0)

        slider.set(percentage: 10)
        XCTAssertEqual(slider.currentTime, 20)

        slider.layoutSubviews()

        slider.set(positionX: 130)
        XCTAssertEqual(slider.currentPositionX, 130)
    }

}
