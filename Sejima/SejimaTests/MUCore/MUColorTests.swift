//
//  MUColorTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 18/09/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUColorTests: XCTestCase {

    func testColorComponents() {
        let color = UIColor(red: 0.123, green: 0.987, blue: 0.456, alpha: 0.479)

        XCTAssertEqual(color.r, 0.123)
        XCTAssertEqual(color.g, 0.987)
        XCTAssertEqual(color.b, 0.456)
        XCTAssertEqual(color.a, 0.479)
    }

    func testHexInit() {
        let r = CGFloat(123)
        let g = CGFloat(234)
        let b = CGFloat(56)
        let a = CGFloat(128)

        let hex = Int(r) << 16 + Int(g) << 8 + Int(b)
        let colorHex = UIColor(hex: hex)
        let color = UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)

        XCTAssertEqual(color, colorHex)

        let colorAlphaHex = UIColor(hex: hex, alpha: Int(a))
        let colorAlpha = UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a / 255.0)

        XCTAssertEqual(colorAlpha, colorAlphaHex)

        let wrongColor = UIColor(hex: 0x123456)

        XCTAssertNotEqual(color, wrongColor)
    }
}
