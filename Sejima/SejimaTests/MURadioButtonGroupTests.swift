//
//  MURadioButtonGroupTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 15/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MURadioButtonGroupTests: XCTestCase {

    func testDefaultValues() {
        let radioGroup = MURadioButtonGroup()
        XCTAssertNotNil(radioGroup)
    }

    func testCustomValues() {
        let radioOne = MURadioButton()
        let radioTwo = MURadioButton()

        let radioGroup = MURadioButtonGroup(with: [radioOne])
        XCTAssertNotNil(radioGroup)

        radioGroup.select(index: 0)
        radioGroup.add(button: radioTwo)
        radioGroup.select(index: 1)
        radioGroup.select(index: -1) // Invalid index
    }
}
