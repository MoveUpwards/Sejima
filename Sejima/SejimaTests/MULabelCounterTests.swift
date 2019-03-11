//
//  MULabelCounterTests.swift
//  Tests
//
//  Created by Damien Noël Dubuisson on 27/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import XCTest
import UIKit
@testable import Sejima

class MULabelCounterTests: XCTestCase {

    func testDefaultValues() {
        let counter = MULabelCounter()
        XCTAssertNotNil(counter)

        XCTAssertEqual(counter.textFont, .systemFont(ofSize: 24, weight: .bold))
        XCTAssertEqual(counter.textColor, .black)
        XCTAssertEqual(counter.format, "%.f")
        XCTAssertEqual(counter.textAlignment, .center)
        XCTAssertEqual(counter.animationType, .linear)
        XCTAssertEqual(counter.rate, 0)
    }

    func testCustomValues() {
        let counter = MULabelCounter()
        XCTAssertNotNil(counter)

        counter.textFont = .systemFont(ofSize: 8, weight: .regular)
        counter.textColor = .orange
        counter.format = "%.2f%%"
        counter.textAlignment = .right
        counter.animationType = .easeInOut
        counter.rate = 4

        XCTAssertEqual(counter.textFont, .systemFont(ofSize: 8, weight: .regular))
        XCTAssertEqual(counter.textColor, .orange)
        XCTAssertEqual(counter.format, "%.2f%%")
        XCTAssertEqual(counter.textAlignment, .right)
        XCTAssertEqual(counter.animationType, .easeInOut)
        XCTAssertEqual(counter.rate, 4)
    }

    func testCount() {
        let counter = MULabelCounter()
        XCTAssertNotNil(counter)

        counter.count(to: 50, duration: 2) {
            XCTAssertEqual(counter.currentValue, 50.0)
        }
    }
}
