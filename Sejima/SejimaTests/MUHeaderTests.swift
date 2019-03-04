//
//  MUHeaderTests.swift
//  SejimaTests
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
        XCTAssertEqual(header.titleColor, .black)
        XCTAssertEqual(header.detail, "")
        XCTAssertEqual(header.detailFont, .systemFont(ofSize: 14, weight: .semibold))
        XCTAssertEqual(header.detailColor, .black)
        XCTAssertEqual(header.spacing, 8.0)
    }

    func testCustomValues() {
        let header = MUHeader()
        XCTAssertNotNil(header)

        header.textAlignment = .center
        header.title = "My title"
        header.titleFont = .systemFont(ofSize: 30, weight: .light)
        header.titleColor = .lightGray
        header.detail = "My long description"
        header.detailFont = .systemFont(ofSize: 12, weight: .regular)
        header.detailColor = .lightGray
        header.spacing = 4.0

        header.layoutSubviews()

        XCTAssertEqual(header.textAlignment, .center)
        XCTAssertEqual(header.title, "My title")
        XCTAssertEqual(header.titleFont, .systemFont(ofSize: 30, weight: .light))
        XCTAssertEqual(header.titleColor, .lightGray)
        XCTAssertEqual(header.detail, "My long description")
        XCTAssertEqual(header.detailFont, .systemFont(ofSize: 12, weight: .regular))
        XCTAssertEqual(header.detailColor, .lightGray)
        XCTAssertEqual(header.spacing, 4.0)
    }

    func testTextAlignmentInt() {
        let header = MUHeader()
        XCTAssertNotNil(header)

        XCTAssertEqual(header.textAlignmentInt, 0)

        header.textAlignment = .center

        XCTAssertEqual(header.textAlignmentInt, 1)

        header.textAlignmentInt = 2

        XCTAssertEqual(header.textAlignment, .right)

        header.textAlignmentInt = -2 // Wrong value

        XCTAssertEqual(header.textAlignment.rawValue, -2)
    }

    func testTitleDetailWidth() {
        let header = MUHeader()
        XCTAssertNotNil(header)

        let titleLabel = UILabel()
        titleLabel.font = header.titleFont

        let detailLabel = UILabel()
        detailLabel.font = header.detailFont

        header.title = "Title"

        titleLabel.text = "Title"
        titleLabel.sizeToFit()

        var width = header.debugSize().width
        XCTAssertEqual(width, titleLabel.bounds.width, accuracy: width * 1.07) // accuracy of 7%

        header.detail = "Long detail description."

        detailLabel.text = "Long detail description."
        detailLabel.sizeToFit()

        width = header.debugSize().width
        XCTAssertEqual(width, detailLabel.bounds.width, accuracy: width * 1.07) // accuracy of 7%

        header.title = "Title very long to exceed the detail"

        titleLabel.text = "Title very long to exceed the detail"
        titleLabel.sizeToFit()

        width = header.debugSize().width
        XCTAssertEqual(width, titleLabel.bounds.width, accuracy: width * 1.07) // accuracy of 7%
    }
}
