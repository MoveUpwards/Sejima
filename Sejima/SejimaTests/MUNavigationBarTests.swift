//
//  MUNavigationBarTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 28/02/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUNavigationBarTests: XCTestCase {

    func testDefaultValues() {
        let navBar = MUNavigationBar()
        XCTAssertNotNil(navBar)

        XCTAssertEqual(navBar.rightButtonTitle, "")
        XCTAssertEqual(navBar.rightButtonState, .normal)
        XCTAssertEqual(navBar.leftButtonImage, nil)
        XCTAssertEqual(navBar.separatorColor, .white)
        XCTAssertEqual(navBar.isLoading, false)
    }

    func testCustomValues() {
        let navBar = MUNavigationBar()
        XCTAssertNotNil(navBar)

        navBar.rightButtonTitle = "Validate"
        navBar.rightButtonState = .disabled
        navBar.leftButtonImage = UIImage(named: "left_button")
        navBar.separatorColor = .black
        navBar.isLoading = false

        navBar.layoutSubviews()

        XCTAssertEqual(navBar.rightButtonTitle, "Validate")
        XCTAssertEqual(navBar.rightButtonState, .disabled)
        XCTAssertEqual(navBar.leftButtonImage, nil)
        XCTAssertEqual(navBar.separatorColor, .black)
        XCTAssertEqual(navBar.isLoading, false)
    }

    func testLoading() {
        let navBar = MUNavigationBar()
        XCTAssertNotNil(navBar)

        navBar.isLoading = true

        XCTAssertEqual(navBar.rightButtonState, .normal)
        XCTAssertEqual(navBar.isLoading, true)
    }
}
