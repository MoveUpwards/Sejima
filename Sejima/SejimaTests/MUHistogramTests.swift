//
//  MUHistogramTests.swift
//  Tests
//
//  Created by Damien Noël Dubuisson on 31/01/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUHistogramTests: XCTestCase {

    func testDefaultValues() {
        let histogram = MUHistogram()
        XCTAssertNotNil(histogram)

        XCTAssertEqual(histogram.barColor, .white)
        XCTAssertEqual(histogram.borderWidth, 0.0)
        XCTAssertEqual(histogram.cornerRadius, 0.0)
        XCTAssertEqual(histogram.borderColor, .white)
        XCTAssertEqual(histogram.contentHorizontalPadding, 0.0)
        XCTAssertEqual(histogram.contentVerticalPadding, 0.0)
    }

    func testCustomValues() {
        let histogram = MUHistogram()
        XCTAssertNotNil(histogram)

        histogram.barColor = .black
        histogram.borderWidth = 4.0
        histogram.cornerRadius = 20.0
        histogram.borderColor = .orange
        histogram.contentHorizontalPadding = 10.0
        histogram.contentVerticalPadding = 10.0

        XCTAssertEqual(histogram.barColor, .black)
        XCTAssertEqual(histogram.borderWidth, 4.0)
        XCTAssertEqual(histogram.cornerRadius, 20.0)
        XCTAssertEqual(histogram.borderColor, .orange)
        XCTAssertEqual(histogram.contentHorizontalPadding, 10.0)
        XCTAssertEqual(histogram.contentVerticalPadding, 10.0)
    }

    func testHistogramValues() {
        let histogram = MUHistogram()
        XCTAssertNotNil(histogram)

        histogram.values = histoData
        XCTAssertEqual(histogram.values.count, 70)
    }

    private let histoData = (0..<70).map { _ in
        CGFloat.random(in: 0 ... 5)
    }
}
