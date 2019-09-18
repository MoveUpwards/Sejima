//
//  MUToastTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 05/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUToastTests: XCTestCase {

    func testDefaultValues() {
        let toast = MUToast()
        XCTAssertNotNil(toast)

        XCTAssertEqual(toast.cornerRadius, 0.0)

        XCTAssertEqual(toast.title, "")
        XCTAssertEqual(toast.titleFont, .systemFont(ofSize: 34.0, weight: .regular))
        XCTAssertEqual(toast.titleColor, .black)
        XCTAssertEqual(toast.detail, "")
        XCTAssertEqual(toast.detailFont, .systemFont(ofSize: 14.0, weight: .semibold))
        XCTAssertEqual(toast.detailColor, .black)
        XCTAssertEqual(toast.textAlignment, .left)
        XCTAssertEqual(toast.spacing, 0.0)
        XCTAssertEqual(toast.headerHorizontalPadding, 16.0)
        XCTAssertEqual(toast.headerVerticalPadding, 16.0)

        XCTAssertNil(toast.icon)
        XCTAssertEqual(toast.iconLeftPadding, 16.0)
        XCTAssertEqual(toast.iconWidth, 36.0)

        XCTAssertEqual(toast.indicatorWidth, 0.0)
        XCTAssertEqual(toast.indicatorColor, .clear)

        XCTAssertEqual(toast.animationDuration, 0.3)
        XCTAssertEqual(toast.displayDuration, 3.0)
        XCTAssertEqual(toast.displayPosition, .top)
        XCTAssertEqual(toast.displayPriority, .info)
        XCTAssertEqual(toast.horizontalPadding, 16.0)
        XCTAssertEqual(toast.verticalPadding, 16.0)

        XCTAssertEqual(toast.buttonSpacing, 16.0)
        XCTAssertEqual(toast.buttonHeight, 0.0)
    }

    //swiftlint:disable:next function_body_length
    func testCustomValues() {
        let toast = MUToast()
        XCTAssertNotNil(toast)

        toast.cornerRadius = 4.0

        toast.title = "Title"
        toast.titleFont = .systemFont(ofSize: 24.0, weight: .bold)
        toast.titleColor = .lightGray
        toast.detail = "Long detail description"
        toast.detailFont = .systemFont(ofSize: 12.0, weight: .regular)
        toast.detailColor = .white
        toast.textAlignment = .center
        toast.spacing = 0.0
        toast.headerHorizontalPadding = 10.0
        toast.headerVerticalPadding = 10.0

        toast.icon = UIImage()
        toast.iconLeftPadding = 10.0
        toast.iconWidth = 50.0

        toast.indicatorWidth = 10.0
        toast.indicatorColor = .red

        toast.animationDuration = 0.5
        toast.displayDuration = 4.0
        toast.displayPosition = .bottom
        toast.displayPriority = .alert
        toast.horizontalPadding = 20.0
        toast.verticalPadding = 20.0

        toast.buttonSpacing = 16.0
        toast.buttonHeight = 30.0

        XCTAssertEqual(toast.cornerRadius, 4.0)

        XCTAssertEqual(toast.title, "Title")
        XCTAssertEqual(toast.titleFont, .systemFont(ofSize: 24.0, weight: .bold))
        XCTAssertEqual(toast.titleColor, .lightGray)
        XCTAssertEqual(toast.detail, "Long detail description")
        XCTAssertEqual(toast.detailFont, .systemFont(ofSize: 12.0, weight: .regular))
        XCTAssertEqual(toast.detailColor, .white)
        XCTAssertEqual(toast.textAlignment, .center)
        XCTAssertEqual(toast.spacing, 0.0)
        XCTAssertEqual(toast.headerHorizontalPadding, 10.0)
        XCTAssertEqual(toast.headerVerticalPadding, 10.0)

        XCTAssertNotNil(toast.icon)
        XCTAssertEqual(toast.iconLeftPadding, 10.0)
        XCTAssertEqual(toast.iconWidth, 50.0)

        XCTAssertEqual(toast.indicatorWidth, 10.0)
        XCTAssertEqual(toast.indicatorColor, .red)

        XCTAssertEqual(toast.animationDuration, 0.5)
        XCTAssertEqual(toast.displayDuration, 4.0)
        XCTAssertEqual(toast.displayPosition, .bottom)
        XCTAssertEqual(toast.displayPriority, .alert)
        XCTAssertEqual(toast.horizontalPadding, 20.0)
        XCTAssertEqual(toast.verticalPadding, 20.0)

        XCTAssertEqual(toast.buttonSpacing, 16.0)
        XCTAssertEqual(toast.buttonHeight, 30.0)
    }

    func testShow() {
        let topToast = MUToast()
        XCTAssertNotNil(topToast)

        let dummyVC = UIViewController()

        topToast.show(in: dummyVC)

        let bottomToast = MUToast()
        XCTAssertNotNil(bottomToast)
        bottomToast.displayPosition = .bottom
        bottomToast.animationDuration = 0.01
        bottomToast.displayDuration = 0.2 // Not too long to don't block unit tests

        let expectation = XCTestExpectation(description: "Toast animation")
        bottomToast.show(in: dummyVC, completion: { succeed in
            XCTAssertFalse(succeed) // Will be false as dummyVC can't show it
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1.0)
    }
}
