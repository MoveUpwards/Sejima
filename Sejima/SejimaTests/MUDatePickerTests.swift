//
//  MUDatePickerTests.swift
//  Tests
//
//  Created by Damien Noël Dubuisson on 17/01/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUDatePickerTests: XCTestCase {

    func testDefaultValues() {
        let datePicker = MUDatePicker()
        XCTAssertNotNil(datePicker)

        XCTAssertEqual(datePicker.textColor, .black)
        XCTAssertEqual(datePicker.backgroundColor, nil)
        XCTAssertEqual(datePicker.separatorHeight, 1.0)

        XCTAssertEqual(datePicker.minimumDate, nil)
        XCTAssertEqual(datePicker.maximumDate, nil)
    }

    func testCustomValues() {
        let datePicker = MUDatePicker()
        XCTAssertNotNil(datePicker)

        let now = Date()
        let lastYear = Date(timeIntervalSinceNow: -36000)
        let lastMonth = Date(timeIntervalSinceNow: 36000)

        datePicker.textColor = .white
        datePicker.backgroundColor = .black
        datePicker.separatorHeight = 2.0
        datePicker.minimumDate = lastYear
        datePicker.maximumDate = now
        datePicker.selectedDate = lastMonth

        XCTAssertEqual(datePicker.textColor, .white)
        XCTAssertEqual(datePicker.backgroundColor, .black)
        XCTAssertEqual(datePicker.separatorHeight, 2.0)

        XCTAssertEqual(datePicker.minimumDate, lastYear)
        XCTAssertEqual(datePicker.maximumDate, now)
        XCTAssertEqual(datePicker.selectedDate, lastMonth)
    }

}
