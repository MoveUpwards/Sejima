//
//  MUToastTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 05/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUToastTests: XCTestCase {

    func testDefaultValues() {
        let toast = MUToast()
        XCTAssertNotNil(toast)

        XCTAssertEqual(toast.cornerRadius, 0.0)
        XCTAssertEqual(toast.headerFont, .systemFont(ofSize: 34, weight: .regular))
        XCTAssertEqual(toast.detailFont, .systemFont(ofSize: 14, weight: .semibold))
        XCTAssertEqual(toast.headerColor, .white)
        XCTAssertEqual(toast.detailColor, .white)
        XCTAssertEqual(toast.header, "")
        XCTAssertEqual(toast.detail, "")
        XCTAssertEqual(toast.textAlignment, .left)
        XCTAssertEqual(toast.textHorizontalInset, 16.0)
        XCTAssertEqual(toast.textVerticalInset, 16.0)
        XCTAssertEqual(toast.icon, nil)
        XCTAssertEqual(toast.iconLeftInset, 16.0)
        XCTAssertEqual(toast.iconVerticalInset, 16.0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
