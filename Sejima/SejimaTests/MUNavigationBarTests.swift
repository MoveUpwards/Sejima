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

        XCTAssertEqual(navBar.leftButtonImage, nil)
        XCTAssertEqual(navBar.separatorColor, .white)
        XCTAssertEqual(navBar.separatorWidth, 1.0)
        XCTAssertEqual(navBar.separatorHeightMultiplier, 0.3)

        XCTAssertNotNil(navBar.mainButton)
        // Do not duplicate MUButton unit tests
    }

    func testCustomValues() {
        let navBar = MUNavigationBar()
        XCTAssertNotNil(navBar)

        navBar.leftButtonImage = UIImage(named: "left_button")
        navBar.separatorColor = .black
        navBar.separatorWidth = 2.0
        navBar.separatorHeightMultiplier = 1.0

        navBar.layoutSubviews()

        XCTAssertEqual(navBar.leftButtonImage, nil)
        XCTAssertEqual(navBar.separatorColor, .black)
        XCTAssertEqual(navBar.separatorWidth, 2.0)
        XCTAssertEqual(navBar.separatorHeightMultiplier, 1.0)
    }

    func testLoading() {
        let navBar = MUNavigationBar()
        XCTAssertNotNil(navBar)

//        navBar.isLoading = true
//
//        XCTAssertEqual(navBar.rightButtonState, .normal)
//        XCTAssertEqual(navBar.isLoading, true)
    }
}
