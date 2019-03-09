//
//  MUIndicatorTests.swift
//  Tests
//
//  Created by Damien Noël Dubuisson on 27/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUIndicatorTests: XCTestCase {

    func testDefaultValues() {
        let indicator = MUIndicator()
        XCTAssertNotNil(indicator)

        XCTAssertEqual(indicator.color, .white)
        XCTAssertEqual(indicator.cornerRadius, 2.0)
        XCTAssertEqual(indicator.valueFont, .systemFont(ofSize: 14, weight: .regular))
        XCTAssertEqual(indicator.valueColor, .white)
        XCTAssertEqual(indicator.format, "%.f")
        XCTAssertEqual(indicator.animationType, .linear)
    }

    func testCustomValues() {
        let indicator = MUIndicator()
        XCTAssertNotNil(indicator)

        indicator.color = .black
        indicator.cornerRadius = 4.0
        indicator.valueFont = .systemFont(ofSize: 8, weight: .regular)
        indicator.valueColor = .lightGray
        indicator.format = "%.fm"
        indicator.animationType = .easeInOut

        XCTAssertEqual(indicator.color, .black)
        XCTAssertEqual(indicator.cornerRadius, 4.0)
        XCTAssertEqual(indicator.valueFont, .systemFont(ofSize: 8, weight: .regular))
        XCTAssertEqual(indicator.valueColor, .lightGray)
        XCTAssertEqual(indicator.format, "%.fm")
        XCTAssertEqual(indicator.animationType, .easeInOut)
    }

}
