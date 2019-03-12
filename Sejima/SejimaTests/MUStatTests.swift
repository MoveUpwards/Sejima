//
//  MUStatTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 12/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUStatTests: XCTestCase {

    func testDefaultValues() {
        let stat = MUStat()
        XCTAssertNotNil(stat)

        XCTAssertEqual(stat.showSeparator, true)
        XCTAssertEqual(stat.separatorColor, .white)
        XCTAssertEqual(stat.separatorWidth, 1.0)
        XCTAssertEqual(stat.separatorLeftPadding, 0.0)
        XCTAssertEqual(stat.icon, nil)
        XCTAssertEqual(stat.iconLeftPadding, 0.0)
        XCTAssertEqual(stat.value, 0.0)
        XCTAssertEqual(stat.valueFont, .systemFont(ofSize: 12.0, weight: .regular))
        XCTAssertEqual(stat.valueColor, .black)
        XCTAssertEqual(stat.format, "%.f")
        XCTAssertEqual(stat.detail, "")
        XCTAssertEqual(stat.detailFont, .systemFont(ofSize: 12.0, weight: .regular))
        XCTAssertEqual(stat.detailColor, .black)
        XCTAssertEqual(stat.unit, "")
        XCTAssertEqual(stat.unitFont, .systemFont(ofSize: 12.0, weight: .regular))
        XCTAssertEqual(stat.unitColor, .black)
        XCTAssertEqual(stat.verticalPadding, 8.0)
    }

    func testCustomValues() {
        let stat = MUStat()
        XCTAssertNotNil(stat)

        let myImage = UIImage()

        stat.showSeparator = false
        stat.separatorColor = .green
        stat.separatorWidth = 0.0
        stat.separatorLeftPadding = 8.0
        stat.icon = myImage
        stat.iconLeftPadding = 8.0
        stat.value = 1.23
        stat.valueFont = .systemFont(ofSize: 18.0, weight: .bold)
        stat.valueColor = .white
        stat.format = "%.2f"
        stat.detail = "My detail"
        stat.detailFont = .systemFont(ofSize: 10.0, weight: .light)
        stat.detailColor = .lightGray
        stat.unit = "My Unit"
        stat.unitFont = .systemFont(ofSize: 14.0, weight: .semibold)
        stat.unitColor = .green
        stat.verticalPadding = 0.0

        XCTAssertEqual(stat.showSeparator, false)
        XCTAssertEqual(stat.separatorColor, .green)
        XCTAssertEqual(stat.separatorWidth, 0.0)
        XCTAssertEqual(stat.separatorLeftPadding, 8.0)
        XCTAssertEqual(stat.icon, myImage)
        XCTAssertEqual(stat.iconLeftPadding, 8.0)
        XCTAssertEqual(stat.value, 1.23)
        XCTAssertEqual(stat.valueFont, .systemFont(ofSize: 18.0, weight: .bold))
        XCTAssertEqual(stat.valueColor, .white)
        XCTAssertEqual(stat.format, "%.2f")
        XCTAssertEqual(stat.detail, "My detail")
        XCTAssertEqual(stat.detailFont, .systemFont(ofSize: 10.0, weight: .light))
        XCTAssertEqual(stat.detailColor, .lightGray)
        XCTAssertEqual(stat.unit, "My Unit")
        XCTAssertEqual(stat.unitFont, .systemFont(ofSize: 14.0, weight: .semibold))
        XCTAssertEqual(stat.unitColor, .green)
        XCTAssertEqual(stat.verticalPadding, 0.0)
    }

    func testFormat() {
        let stat = MUStat()
        XCTAssertNotNil(stat)

        stat.value = 1.23
        stat.format = "%.1f"

        stat.format = "%d"

        stat.format = "Plain text"
    }

    func testSetData() {
        let stat = MUStat()
        XCTAssertNotNil(stat)

        let myImage = UIImage()

        let data = MUStatData(image: myImage,
                              format: "%f",
                              value: 1.234,
                              unit: "unit",
                              detail: "my custom detail",
                              showSeparator: false)
        stat.set(data: data)

        XCTAssertEqual(stat.showSeparator, false)
        XCTAssertEqual(stat.icon, myImage)
        XCTAssertEqual(stat.value, 1.234)
        XCTAssertEqual(stat.format, "%f")
        XCTAssertEqual(stat.detail, "my custom detail")
        XCTAssertEqual(stat.unit, "unit")
    }
}
