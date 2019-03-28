//
//  MUDateSliderTests.swift
//  Tests
//
//  Created by Damien Noël Dubuisson on 04/01/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUDateSliderTests: XCTestCase {

    let minDate = Date(timeIntervalSinceNow: -3600 * 240)
    let maxDate = Date(timeIntervalSinceNow: 3600 * 240)

    func testDefaultValues() {
        let datePicker = MUDateSlider()
        XCTAssertNotNil(datePicker)

        XCTAssertEqual(datePicker.dayFont, .systemFont(ofSize: 10))
        XCTAssertEqual(datePicker.unselectedDayColor, .black)
        XCTAssertEqual(datePicker.selectedDayColor, .white)
        XCTAssertEqual(datePicker.numberFont, .boldSystemFont(ofSize: 18))
        XCTAssertEqual(datePicker.unselectedNumberColor, .black)
        XCTAssertEqual(datePicker.selectedNumberColor, .white)
        XCTAssertEqual(datePicker.monthFont, .systemFont(ofSize: 10))
        XCTAssertEqual(datePicker.unselectedMonthColor, .black)
        XCTAssertEqual(datePicker.selectedMonthColor, .white)
        XCTAssertEqual(datePicker.radius, 4)
        XCTAssertEqual(datePicker.unselectedBorderWidth, 0.0)
        XCTAssertEqual(datePicker.selectedBorderWidth, 1.0)
        XCTAssertEqual(datePicker.unselectedBorderColor, .clear)
        XCTAssertEqual(datePicker.selectedBorderColor, .black)
        XCTAssertEqual(datePicker.unselectedBackgroundColor, .white)
        XCTAssertEqual(datePicker.selectedBackgroundColor, .purple)
        XCTAssertNil(datePicker.selectedIndex)
    }

    func testCustomValues() {
        let datePicker = MUDateSlider()
        XCTAssertNotNil(datePicker)

        datePicker.dayFont = .systemFont(ofSize: 12)
        datePicker.unselectedDayColor = .white
        datePicker.selectedDayColor = .black
        datePicker.numberFont = .boldSystemFont(ofSize: 24)
        datePicker.unselectedNumberColor = .white
        datePicker.selectedNumberColor = .black
        datePicker.monthFont = .systemFont(ofSize: 12)
        datePicker.unselectedMonthColor = .white
        datePicker.selectedMonthColor = .black
        datePicker.radius = 2
        datePicker.unselectedBorderWidth = 1.0
        datePicker.selectedBorderWidth = 0.0
        datePicker.unselectedBorderColor = .green
        datePicker.selectedBorderColor = .green
        datePicker.unselectedBackgroundColor = .blue
        datePicker.selectedBackgroundColor = .blue

        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate

        XCTAssertEqual(datePicker.minimumDate, minDate)
        XCTAssertEqual(datePicker.maximumDate, maxDate)

        datePicker.select(index: 5)

        XCTAssertEqual(datePicker.dayFont, .systemFont(ofSize: 12))
        XCTAssertEqual(datePicker.unselectedDayColor, .white)
        XCTAssertEqual(datePicker.selectedDayColor, .black)
        XCTAssertEqual(datePicker.numberFont, .boldSystemFont(ofSize: 24))
        XCTAssertEqual(datePicker.unselectedNumberColor, .white)
        XCTAssertEqual(datePicker.selectedNumberColor, .black)
        XCTAssertEqual(datePicker.monthFont, .systemFont(ofSize: 12))
        XCTAssertEqual(datePicker.unselectedMonthColor, .white)
        XCTAssertEqual(datePicker.selectedMonthColor, .black)
        XCTAssertEqual(datePicker.radius, 2)
        XCTAssertEqual(datePicker.unselectedBorderWidth, 1.0)
        XCTAssertEqual(datePicker.selectedBorderWidth, 0.0)
        XCTAssertEqual(datePicker.unselectedBorderColor, .green)
        XCTAssertEqual(datePicker.selectedBorderColor, .green)
        XCTAssertEqual(datePicker.unselectedBackgroundColor, .blue)
        XCTAssertEqual(datePicker.selectedBackgroundColor, .blue)
        XCTAssertEqual(datePicker.selectedIndex, 5)
    }
}
