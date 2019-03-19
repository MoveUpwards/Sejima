//
//  MUOptionPickerTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 18/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUOptionPickerTests: XCTestCase {

    func testDefaultValues() {
        let picker = MUOptionPicker()
        XCTAssertNotNil(picker)

        XCTAssertEqual(picker.selectedColor, .white)
        XCTAssertEqual(picker.unselectedColor, .darkGray)
        XCTAssertEqual(picker.textFont, .systemFont(ofSize: 16.0))
        XCTAssertEqual(picker.spacing, 0.0)
        XCTAssertEqual(picker.contentHorizontalPadding, 20.0)
        XCTAssertEqual(picker.selectedIndex, nil)
    }

    func testCustomValues() {
        let picker = MUOptionPicker()
        XCTAssertNotNil(picker)

        picker.textFont = .systemFont(ofSize: 20.0, weight: .bold)
        picker.contentHorizontalPadding = 80.0
        picker.spacing = 5.0
        picker.selectedColor = .black
        picker.unselectedColor = .white
        picker.add(datas: [.init(text: ""),
                           .init(text: "")])
        picker.select(index: 1)

        XCTAssertEqual(picker.textFont, .systemFont(ofSize: 20.0, weight: .bold))
        XCTAssertEqual(picker.selectedColor, .black)
        XCTAssertEqual(picker.unselectedColor, .white)
        XCTAssertEqual(picker.selectedIndex, 1)
        XCTAssertEqual(picker.contentHorizontalPadding, 80.0)
        XCTAssertEqual(picker.spacing, 5.0)
    }

    func testMUOption() {
        let option = MUOption()
        XCTAssertNotNil(option)

        option.set(font: .systemFont(ofSize: 10.0, weight: .bold))
        option.set(selectedColor: .red)
        option.set(unselectedColor: .black)
    }
}
