//
//  MUMeasurePickerTests.swift
//  Tests
//
//  Created by Damien Noël Dubuisson on 17/01/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUMeasurePickerTests: XCTestCase {

    func testDefaultValues() {
        let picker = MUMeasurePicker()
        XCTAssertNotNil(picker)

        XCTAssertEqual(picker.backgroundColor, nil)
        XCTAssertEqual(picker.textColor, .black)
        XCTAssertEqual(picker.separatorHeight, 2.0)
        XCTAssertEqual(picker.contentHorizontalPadding, 8.0)
        XCTAssertEqual(picker.centerSpacing, 8.0)
        XCTAssertEqual(picker.minValue, 0)
        XCTAssertEqual(picker.maxValue, 100)
        XCTAssertEqual(picker.units, [])
    }

    func testCustomValues() {
        let picker = MUMeasurePicker()
        XCTAssertNotNil(picker)

        picker.backgroundColor = .black
        picker.textColor = .white
        picker.textFont = .systemFont(ofSize: 20.0, weight: .bold)
        picker.separatorHeight = 1.0
        picker.contentHorizontalPadding = 16.0
        picker.centerSpacing = 32.0
        picker.minValue = 50
        picker.maxValue = 210
        picker.currentValue = 170
        picker.units = ["inches", "cm"]
        picker.currentUnitIndex = 1

        XCTAssertEqual(picker.backgroundColor, .black)
        XCTAssertEqual(picker.textColor, .white)
        XCTAssertEqual(picker.separatorHeight, 1.0)
        XCTAssertEqual(picker.contentHorizontalPadding, 16.0)
        XCTAssertEqual(picker.centerSpacing, 32.0)
        XCTAssertEqual(picker.minValue, 50)
        XCTAssertEqual(picker.maxValue, 210)
        XCTAssertEqual(picker.currentValue, 170)
        XCTAssertEqual(picker.units, ["inches", "cm"])
        XCTAssertEqual(picker.currentUnitIndex, 1)
    }

    func testSetData() {
        let picker = MUMeasurePicker()
        XCTAssertNotNil(picker)

        let data = MUMeasureData(min: 50, max: 210, units: ["inches", "cm"])
        XCTAssertNotNil(data)

        picker.set(data)

        XCTAssertEqual(picker.minValue, 50)
        XCTAssertEqual(picker.maxValue, 210)
        XCTAssertEqual(picker.units, ["inches", "cm"])
    }
}
