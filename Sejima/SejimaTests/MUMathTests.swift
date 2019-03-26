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

    func testEpsilon() {
        XCTAssertFalse(CGFloat.epsilon.isNaN)
        XCTAssertFalse(Double.epsilon.isNaN)
        XCTAssertFalse(Float.epsilon.isNaN)
        XCTAssertFalse(Float32.epsilon.isNaN)
        XCTAssertFalse(Float64.epsilon.isNaN)
        #if !os(Windows) && (arch(i386) || arch(x86_64))
        XCTAssertFalse(Float80.epsilon.isNaN)
        #endif
    }

    func testToRadians() {
        XCTAssertEqual(CGFloat(180).toRadians, .pi)
        XCTAssertEqual(Double(180).toRadians, .pi)
        XCTAssertEqual(Float(180).toRadians, .pi)
        XCTAssertEqual(Float32(180).toRadians, .pi)
        XCTAssertEqual(Float64(180).toRadians, .pi)
        #if !os(Windows) && (arch(i386) || arch(x86_64))
        XCTAssertEqual(Float80(180).toRadians, .pi)
        #endif

        XCTAssertEqual(CGFloat(321).toRadians, 5.602506898901797)
        XCTAssertEqual(Double(321).toRadians, 5.602506898901797)
        XCTAssertEqual(Float(321).toRadians, 5.6025066)
        XCTAssertEqual(Float32(321).toRadians, 5.6025066)
        XCTAssertEqual(Float64(321).toRadians, 5.602506898901797)
        #if !os(Windows) && (arch(i386) || arch(x86_64))
        XCTAssertEqual(Float80(321).toRadians, 5.602506898901797942)
        #endif
    }

    func testToDegrees() {
        XCTAssertEqual(CGFloat.pi.toDegrees, 180)
        XCTAssertEqual(Double.pi.toDegrees, 180)
        XCTAssertEqual(Float.pi.toDegrees, 180)
        XCTAssertEqual(Float32.pi.toDegrees, 180)
        XCTAssertEqual(Float64.pi.toDegrees, 180)
        #if !os(Windows) && (arch(i386) || arch(x86_64))
        XCTAssertEqual(Float80.pi.toDegrees, 180)
        #endif

        XCTAssertEqual(CGFloat(1.23).toDegrees, 70.47380880109127)
        XCTAssertEqual(Double(1.23).toDegrees, 70.47380880109127)
        XCTAssertEqual(Float(1.23).toDegrees, 70.473816)
        XCTAssertEqual(Float32(1.23).toDegrees, 70.473816)
        XCTAssertEqual(Float64(1.23).toDegrees, 70.47380880109127)
        #if !os(Windows) && (arch(i386) || arch(x86_64))
        XCTAssertEqual(Float80(1.23).toDegrees, 70.47380880109125468)
        #endif
    }
}
