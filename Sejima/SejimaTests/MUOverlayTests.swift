//
//  MUOverlayTests.swift
//  Tests
//
//  Created by Loïc GRIFFIE on 14/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import XCTest
import UIKit
@testable import Sejima

class MUOverlayTests: XCTestCase {
    func testDefaultValues() {
        let overlay = MUOverlay()
        XCTAssertNotNil(overlay)

        XCTAssertEqual(overlay.style, .square)
        XCTAssertEqual(overlay.borderWidth, 0.0)
        XCTAssertEqual(overlay.radius, 0)
        XCTAssertEqual(overlay.borderColor, .black)
    }

    func testCustomValues() {
        let overlay = MUOverlay()
        XCTAssertNotNil(overlay)

        overlay.style = .custom(8)
        XCTAssertEqual(overlay.style, .custom(8))

        overlay.backgroundColor = .red
        overlay.borderWidth = 10
        overlay.borderColor = .orange

        XCTAssertEqual(overlay.backgroundColor, .red)
        XCTAssertEqual(overlay.borderWidth, 10)
        XCTAssertEqual(overlay.borderColor, .orange)

        overlay.radius = 4
        XCTAssertEqual(overlay.style, .custom(4))
        XCTAssertEqual(overlay.radius, 4)
    }

    func testOverlayTypeInt() {
        let overlay = MUOverlay()
        XCTAssertNotNil(overlay)

        XCTAssertEqual(overlay.styleInt, 0)
        XCTAssertEqual(overlay.style, .square)

        overlay.styleInt = 1
        XCTAssertEqual(overlay.style, .round)

        overlay.styleInt = 2
        XCTAssertEqual(overlay.style, .custom(0))
    }

    func testOverlayRadius() {
        let overlay = MUOverlay()
        XCTAssertNotNil(overlay)

        overlay.radius = 6
        XCTAssertEqual(overlay.style, .custom(6))
    }
}
