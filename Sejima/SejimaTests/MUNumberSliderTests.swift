//
//  MUNumberSliderTests.swift
//  SejimaTests
//
//  Created by Loïc GRIFFIE on 18/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUNumberSliderTests: XCTestCase {

    func testDefaultValues() {
        let slider = MUNumberSlider()
        XCTAssertNotNil(slider)

        XCTAssertEqual(slider.selectedColor, .white)
        XCTAssertEqual(slider.unselectedColor, .black)
        XCTAssertEqual(slider.font, .systemFont(ofSize: 16, weight: .regular))
        XCTAssertEqual(slider.cellWidth, 40)
        XCTAssertEqual(slider.heightMultiplier, 1.0)
        XCTAssertNil(slider.image)
        XCTAssertEqual(slider.minValue, 0)
        XCTAssertEqual(slider.maxValue, 100)
        XCTAssertEqual(slider.selectedScaleValue, 2.0)
    }

    func testCustomValues() {
        let slider = MUNumberSlider()
        XCTAssertNotNil(slider)

        slider.selectedColor = .orange
        slider.unselectedColor = .green
        slider.font = .systemFont(ofSize: 15)
        slider.cellWidth = 10
        slider.heightMultiplier = 5.0
        slider.image = UIImage()
        slider.minValue = 30
        slider.maxValue = 80
        slider.selectedScaleValue = 2.5

        XCTAssertEqual(slider.selectedColor, .orange)
        XCTAssertEqual(slider.unselectedColor, .green)
        XCTAssertEqual(slider.font, .systemFont(ofSize: 15))
        XCTAssertEqual(slider.cellWidth, 10)
        XCTAssertEqual(slider.heightMultiplier, 5.0)
        XCTAssertNotNil(slider.image)
        XCTAssertEqual(slider.minValue, 30)
        XCTAssertEqual(slider.maxValue, 80)
        XCTAssertEqual(slider.selectedScaleValue, 2.5)
    }

    func testIndex() {
        let slider = MUNumberSlider()
        XCTAssertNotNil(slider)

        XCTAssertEqual(slider.minValue, 0)
        XCTAssertEqual(slider.maxValue, 100)

        slider.layoutSubviews()

        slider.currentValue = 50
        XCTAssertEqual(slider.currentValue, 0) // Check before animation is completed

        slider.currentValue = -10 // Invalid value
        XCTAssertEqual(slider.currentValue, 0)

        slider.currentValue = 110 // Invalid value
        XCTAssertEqual(slider.currentValue, 0)
    }

}
