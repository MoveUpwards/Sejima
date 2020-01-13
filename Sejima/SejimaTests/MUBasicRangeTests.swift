//
//  MUBasicRangeTests.swift
//  SejimaTests
//
//  Created by Loïc GRIFFIE on 14/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
import Neumann
@testable import Sejima

class MUBasicRangeTests: XCTestCase {

    func testBasicRange() {
        let range = MUBasicRange(with: "My range", range: MURange<CGFloat>(location: 0, length: 50))
        XCTAssertNotNil(range)

        XCTAssertEqual(range.title, "My range")
        XCTAssertEqual(range.range.location, 0)
        XCTAssertEqual(range.range.length, 50)
        XCTAssertEqual(range.range.lowerBound, 0)
        XCTAssertEqual(range.range.upperBound, 50)
    }
}
