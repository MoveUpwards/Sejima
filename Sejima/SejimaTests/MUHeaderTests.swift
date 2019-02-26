//
//  MUHeaderTests.swift
//  MUComponentTests
//
//  Created by Damien Noël Dubuisson on 25/02/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import XCTest
@testable import Sejima

class MUHeaderTests: XCTestCase {

    func testDefaultValues() {
        let header = MUHeader()
        XCTAssertNotNil(header)

        XCTAssertEqual(header.textAlignment, .left)
        XCTAssertEqual(header.title, "")
        XCTAssertEqual(header.titleFont, .systemFont(ofSize: 34, weight: .regular))
        XCTAssertEqual(header.titleColor, .white)
        XCTAssertEqual(header.detail, "")
        XCTAssertEqual(header.detailFont, .systemFont(ofSize: 14, weight: .semibold))
        XCTAssertEqual(header.detailColor, .white)
        XCTAssertEqual(header.spacing, 8.0)
    }

    func testCustomValues() {
        let header = MUHeader()
        XCTAssertNotNil(header)

        header.textAlignment = .center
        header.title = "My title"
        header.titleFont = .systemFont(ofSize: 30, weight: .light)
        header.titleColor = .black
        header.detail = "My long description"
        header.detailFont = .systemFont(ofSize: 12, weight: .regular)
        header.detailColor = .lightGray
        header.spacing = 4.0

        XCTAssertEqual(header.textAlignment, .center)
        XCTAssertEqual(header.title, "My title")
        XCTAssertEqual(header.titleFont, .systemFont(ofSize: 30, weight: .light))
        XCTAssertEqual(header.titleColor, .black)
        XCTAssertEqual(header.detail, "My long description")
        XCTAssertEqual(header.detailFont, .systemFont(ofSize: 12, weight: .regular))
        XCTAssertEqual(header.detailColor, .lightGray)
        XCTAssertEqual(header.spacing, 4.0)
    }

}
