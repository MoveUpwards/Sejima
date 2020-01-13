//
//  MURangeTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 12/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
import Neumann
@testable import Sejima

class MURangeTests: XCTestCase {

    func testRangeValues() {
        var range = MURange<Double>(location: 2.0, length: 5.0)
        XCTAssertNotNil(range)
        XCTAssertEqual(range.location, 2.0)
        XCTAssertEqual(range.length, 5.0)
        XCTAssertEqual(range.lowerBound, 2.0)
        XCTAssertEqual(range.upperBound, 2.0 + 5.0)

        range.length = 3.0

        XCTAssertEqual(range.location, 2.0)
        XCTAssertEqual(range.length, 3.0)
        XCTAssertEqual(range.lowerBound, 2.0)
        XCTAssertEqual(range.upperBound, 2.0 + 3.0)

        range.location = 1.0

        XCTAssertEqual(range.location, 1.0)
        XCTAssertEqual(range.length, 3.0)
        XCTAssertEqual(range.lowerBound, 1.0)
        XCTAssertEqual(range.upperBound, 1.0 + 3.0)

        range.lowerBound = 0.0

        XCTAssertEqual(range.location, 0.0)
        XCTAssertEqual(range.length, 3.0)
        XCTAssertEqual(range.lowerBound, 0.0)
        XCTAssertEqual(range.upperBound, 0.0 + 3.0)

        range.upperBound = 2.0

        XCTAssertEqual(range.location, 0.0)
        XCTAssertEqual(range.length, 2.0)
        XCTAssertEqual(range.lowerBound, 0.0)
        XCTAssertEqual(range.upperBound, 0.0 + 2.0)
    }
}
