//
//  MURangeTrimmerTests.swift
//  Tests
//
//  Created by Damien Noël Dubuisson on 05/02/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MURangeTrimmerTests: XCTestCase {

    func testDefaultValues() {
        let trimmer = MURangeTrimmer()
        XCTAssertNotNil(trimmer)

        XCTAssertEqual(trimmer.borderColor, .white)
        XCTAssertEqual(trimmer.borderWidth, 0.0)
        XCTAssertEqual(trimmer.cornerRadius, 0.0)
        XCTAssertEqual(trimmer.titleColor, .black)
        XCTAssertEqual(trimmer.titleFont, .systemFont(ofSize: 16.0, weight: .regular))
        XCTAssertEqual(trimmer.defaultTitle, "")
    }

    func testCustomValues() {
        let trimmer = MURangeTrimmer()
        XCTAssertNotNil(trimmer)

        trimmer.borderColor = .green
        trimmer.borderWidth = 4.0
        trimmer.cornerRadius = 4.0
        trimmer.titleColor = .white
        trimmer.titleFont = .systemFont(ofSize: 12.0, weight: .medium)
        trimmer.defaultTitle = "Period "

        XCTAssertEqual(trimmer.borderColor, .green)
        XCTAssertEqual(trimmer.borderWidth, 4.0)
        XCTAssertEqual(trimmer.cornerRadius, 4.0)
        XCTAssertEqual(trimmer.titleColor, .white)
        XCTAssertEqual(trimmer.titleFont, .systemFont(ofSize: 12.0, weight: .medium))
        XCTAssertEqual(trimmer.defaultTitle, "Period ")
    }

    func testFunctions() {
        let trimmer = MURangeTrimmer()
        XCTAssertNotNil(trimmer)

        trimmer.split(at: 0)

        XCTAssertEqual(trimmer.ranges.count, 2)
        XCTAssertEqual(trimmer.ranges[0].range.location, 0.0)
        XCTAssertEqual(trimmer.ranges[0].range.length, 50.0)
        XCTAssertEqual(trimmer.ranges[1].range.location, 50.0)
        XCTAssertEqual(trimmer.ranges[1].range.length, 50.0)

        trimmer.split(at: 0)

        test3Parts(trimmer: trimmer)

        XCTAssertEqual(trimmer.set(maximumCount: 3), true)
        trimmer.split(at: 0)

        test3Parts(trimmer: trimmer)

        XCTAssertEqual(trimmer.set(maximumCount: 2), false)
        XCTAssertEqual(trimmer.set(minimumPercentage: 26.0), false)

        trimmer.remove(at: 1)

        test2Parts(trimmer: trimmer)

        trimmer.remove(at: 2)

        test2Parts(trimmer: trimmer)

        trimmer.remove(at: 0)

        XCTAssertEqual(trimmer.ranges.count, 1)
        XCTAssertEqual(trimmer.ranges[0].range.location, 50.0)
        XCTAssertEqual(trimmer.ranges[0].range.length, 50.0)

        trimmer.remove(at: 0)

        XCTAssertEqual(trimmer.ranges.count, 1)
        XCTAssertEqual(trimmer.ranges[0].range.location, 50.0)
        XCTAssertEqual(trimmer.ranges[0].range.length, 50.0)
    }

    private func test2Parts(trimmer: MURangeTrimmer) {
        XCTAssertEqual(trimmer.ranges.count, 2)
        XCTAssertEqual(trimmer.ranges[0].range.location, 0.0)
        XCTAssertEqual(trimmer.ranges[0].range.length, 25.0)
        XCTAssertEqual(trimmer.ranges[1].range.location, 50.0)
        XCTAssertEqual(trimmer.ranges[1].range.length, 50.0)
    }

    private func test3Parts(trimmer: MURangeTrimmer) {
        XCTAssertEqual(trimmer.ranges.count, 3)
        XCTAssertEqual(trimmer.ranges[0].range.location, 0.0)
        XCTAssertEqual(trimmer.ranges[0].range.length, 25.0)
        XCTAssertEqual(trimmer.ranges[1].range.location, 25.0)
        XCTAssertEqual(trimmer.ranges[1].range.length, 25.0)
        XCTAssertEqual(trimmer.ranges[2].range.location, 50.0)
        XCTAssertEqual(trimmer.ranges[2].range.length, 50.0)
    }
}
