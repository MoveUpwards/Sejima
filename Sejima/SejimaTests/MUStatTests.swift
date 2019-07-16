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

        XCTAssertEqual(stat.showVerticalSeparator, true)
        XCTAssertEqual(stat.verticalSeparatorColor, .clear)
        XCTAssertEqual(stat.verticalSeparatorWidth, 1.0)
        XCTAssertEqual(stat.verticalSeparatorLeftPadding, 0.0)
        XCTAssertEqual(stat.icon, nil)
        XCTAssertEqual(stat.iconWidth, 50.0)
        XCTAssertEqual(stat.iconLeftPadding, 0.0)
        XCTAssertEqual(stat.value, "")
        XCTAssertEqual(stat.valueFont, .systemFont(ofSize: 12.0, weight: .regular))
        XCTAssertEqual(stat.valueColor, .black)
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

        stat.showVerticalSeparator = false
        stat.verticalSeparatorColor = .green
        stat.verticalSeparatorWidth = 0.0
        stat.verticalSeparatorLeftPadding = 8.0
        stat.icon = myImage
        stat.iconWidth = 64.0
        stat.iconLeftPadding = 8.0
        stat.value = MUStatData.value(for: 1.23, format: "%.2f")
        stat.valueFont = .systemFont(ofSize: 18.0, weight: .bold)
        stat.valueColor = .white
        stat.detail = "My detail"
        stat.detailFont = .systemFont(ofSize: 10.0, weight: .light)
        stat.detailColor = .lightGray
        stat.unit = "My Unit"
        stat.unitFont = .systemFont(ofSize: 14.0, weight: .semibold)
        stat.unitColor = .green
        stat.verticalPadding = 0.0

        XCTAssertEqual(stat.showVerticalSeparator, false)
        XCTAssertEqual(stat.verticalSeparatorColor, .green)
        XCTAssertEqual(stat.verticalSeparatorWidth, 0.0)
        XCTAssertEqual(stat.verticalSeparatorLeftPadding, 8.0)
        XCTAssertEqual(stat.icon, myImage)
        XCTAssertEqual(stat.iconWidth, 64.0)
        XCTAssertEqual(stat.iconLeftPadding, 8.0)
        XCTAssertEqual(stat.value, "1.23")
        XCTAssertEqual(stat.valueFont, .systemFont(ofSize: 18.0, weight: .bold))
        XCTAssertEqual(stat.valueColor, .white)
        XCTAssertEqual(stat.detail, "My detail")
        XCTAssertEqual(stat.detailFont, .systemFont(ofSize: 10.0, weight: .light))
        XCTAssertEqual(stat.detailColor, .lightGray)
        XCTAssertEqual(stat.unit, "My Unit")
        XCTAssertEqual(stat.unitFont, .systemFont(ofSize: 14.0, weight: .semibold))
        XCTAssertEqual(stat.unitColor, .green)
        XCTAssertEqual(stat.verticalPadding, 0.0)
    }

    func testSetData() {
        let stat = MUStat()
        XCTAssertNotNil(stat)

        let myImage = UIImage()

        let data = MUStatData(image: myImage,
                              value: MUStatData.value(for: 1.234, format: "%.fm"),
                              unit: "unit",
                              detail: "my custom detail",
                              showVerticalSeparator: false)
        stat.set(data: data)

        XCTAssertEqual(stat.showVerticalSeparator, false)
        XCTAssertEqual(stat.icon, myImage)
        XCTAssertEqual(stat.value, "1m")
        XCTAssertEqual(stat.detail, "my custom detail")
        XCTAssertEqual(stat.unit, "unit")
    }
}
