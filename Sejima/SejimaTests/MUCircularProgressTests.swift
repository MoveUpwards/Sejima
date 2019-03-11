//
//  MUCircularProgressTests.swift
//  Tests
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUCircularProgressTests: XCTestCase {

    func testDefaultValues() {
        let progress = MUCircularProgress()
        XCTAssertNotNil(progress)

        XCTAssertNil(progress.icon)
        XCTAssertEqual(progress.iconMargin, .zero)
        XCTAssertEqual(progress.titleFont, .systemFont(ofSize: 34, weight: .regular))
        XCTAssertEqual(progress.detailFont, .systemFont(ofSize: 14, weight: .semibold))
        XCTAssertEqual(progress.titleColor, .white)
        XCTAssertEqual(progress.detailColor, .white)
        XCTAssertEqual(progress.title, "")
        XCTAssertEqual(progress.detail, "")
        XCTAssertEqual(progress.textVerticalInset, 0.0)
        XCTAssertEqual(progress.textPaddingInset, 0.0)
        XCTAssertEqual(progress.trackLineColor, .white)
        XCTAssertEqual(progress.trackLineWidth, 8)
        XCTAssertEqual(progress.trackLineCap, .round)
        XCTAssertEqual(progress.trackStartAngle, 0)
        XCTAssertEqual(progress.trackValue, 0)
        XCTAssertEqual(progress.progressLineColor, .white)
        XCTAssertEqual(progress.progressLineCap, .round)
        XCTAssertEqual(progress.progressLineWidth, 8)
        XCTAssertEqual(progress.progressStartAngle, 0)
        XCTAssertEqual(progress.progressValue, 0)
        XCTAssertEqual(progress.animationDuration, 0.3)
    }

    func testCustomValues() {
        let progress = MUCircularProgress()
        XCTAssertNotNil(progress)

        progress.titleFont = .systemFont(ofSize: 16, weight: .bold)
        progress.detailFont = .systemFont(ofSize: 10, weight: .light)
        progress.titleColor = .orange
        progress.detailColor = .blue
        progress.title = "My header"
        progress.detail = "My detail text"
        progress.textVerticalInset = 10.0
        progress.textPaddingInset = 80.0
        progress.trackLineColor = .green
        progress.trackLineWidth = 2
        progress.trackLineCap = .square
        progress.trackStartAngle = 33
        progress.progressLineColor = .purple
        progress.progressLineCap = .butt
        progress.progressLineWidth = 16
        progress.progressStartAngle = -90
        progress.trackValue = 0.8
        progress.progressValue = 0.4
        progress.animationDuration = 0.5

        XCTAssertEqual(progress.titleFont, .systemFont(ofSize: 16, weight: .bold))
        XCTAssertEqual(progress.detailFont, .systemFont(ofSize: 10, weight: .light))
        XCTAssertEqual(progress.titleColor, .orange)
        XCTAssertEqual(progress.detailColor, .blue)
        XCTAssertEqual(progress.title, "My header")
        XCTAssertEqual(progress.detail, "My detail text")
        XCTAssertEqual(progress.textVerticalInset, 10.0)
        XCTAssertEqual(progress.textPaddingInset, 80.0)
        XCTAssertEqual(progress.trackLineColor, .green)
        XCTAssertEqual(progress.trackLineWidth, 2)
        XCTAssertEqual(progress.trackLineCap, .square)
        XCTAssertEqual(progress.trackStartAngle, 33)
        XCTAssertEqual(progress.progressLineColor, .purple)
        XCTAssertEqual(progress.progressLineCap, .butt)
        XCTAssertEqual(progress.progressLineWidth, 16)
        XCTAssertEqual(progress.progressStartAngle, -90)
        XCTAssertEqual(progress.trackValue, 0.8)
        XCTAssertEqual(progress.progressValue, 0.4)
        XCTAssertEqual(progress.animationDuration, 0.5)
    }

    func testIcon() {
        let progress = MUCircularProgress()
        XCTAssertNotNil(progress)

        progress.icon = UIImage()
        progress.iconMargin = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        XCTAssertNotNil(progress.icon)
        XCTAssertEqual(progress.iconMargin, UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

    func testResetProgress() {
        let progress = MUCircularProgress()
        XCTAssertNotNil(progress)

        progress.progressValue = 0.8
        XCTAssertEqual(progress.progressValue, 0.8)

        progress.reset()
        XCTAssertEqual(progress.progressValue, 0.0)
    }

    func testValues() {
        let progress = MUCircularProgress()
        XCTAssertNotNil(progress)

        progress.trackValue = 1.8
        progress.progressValue = 1.8

        XCTAssertEqual(progress.trackValue, 1.0)
        XCTAssertEqual(progress.progressValue, 1.0)
    }
}
