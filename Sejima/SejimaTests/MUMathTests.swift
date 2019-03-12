//
//  MUMathTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 12/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUMathTests: XCTestCase {

    func testConversion() {
        let rightAngle = 90.0.toRadians
        XCTAssertEqual(sin(rightAngle), 1.0)
        XCTAssertEqual(rightAngle.toDegrees, 90.0)

        let straightAngle = 180.0.toRadians
        XCTAssertEqual(cos(straightAngle), -1.0)
        XCTAssertEqual(straightAngle, .pi)
        XCTAssertEqual(Double.pi.toDegrees, 180.0)

        let twoPi = 2.0 * .pi
        XCTAssertEqual(twoPi.toDegrees, 360.0)
    }
}
