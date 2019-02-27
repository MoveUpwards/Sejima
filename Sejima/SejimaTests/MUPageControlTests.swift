//
//  MUPageControlTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 27/02/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUPageControlTests: XCTestCase {

    func testDefaultValues() {
        let pageControl = MUPageControl()
        XCTAssertNotNil(pageControl)

        XCTAssertEqual(pageControl.numberOfPages, 0)
        XCTAssertEqual(pageControl.currentPage, 0)
        XCTAssertEqual(pageControl.tintColors, [])
        XCTAssertEqual(pageControl.enableTouchEvents, false)
        XCTAssertEqual(pageControl.elementSize, CGSize(width: 8.0, height: 8.0))
        XCTAssertEqual(pageControl.activeElementWidth, 16.0)
        XCTAssertEqual(pageControl.padding, 8.0)
        XCTAssertEqual(pageControl.radius, 4.0)
        XCTAssertEqual(pageControl.hidesForSinglePage, false)
        XCTAssertEqual(pageControl.borderWidth, 0.0)
        XCTAssertEqual(pageControl.borderColor, .clear)
        XCTAssertEqual(pageControl.currentPageIndicatorTintColor, .black)
        XCTAssertEqual(pageControl.pageIndicatorTintColor, .lightGray)
        XCTAssertEqual(pageControl.horizontalMargin, 0.0)
    }

    func testCustomValues() {
        let pageControl = MUPageControl()
        XCTAssertNotNil(pageControl)

        pageControl.numberOfPages = 5
        pageControl.set(page: 1, animated: false)
        pageControl.tintColors = [.blue, .white, .red]
        pageControl.enableTouchEvents = true
        pageControl.elementSize = CGSize(width: 8.0, height: 8.0)
        pageControl.activeElementWidth = 20.0
        pageControl.padding = 10.0
        pageControl.radius = 0.0
        pageControl.hidesForSinglePage = true
        pageControl.borderWidth = 1.0
        pageControl.borderColor = .white
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .black
        pageControl.horizontalMargin = 20.0

        XCTAssertEqual(pageControl.numberOfPages, 5)
        XCTAssertEqual(pageControl.currentPage, 1)
        XCTAssertEqual(pageControl.tintColors, [.blue, .white, .red])
        XCTAssertEqual(pageControl.enableTouchEvents, true)
        XCTAssertEqual(pageControl.elementSize, CGSize(width: 8.0, height: 8.0))
        XCTAssertEqual(pageControl.activeElementWidth, 20.0)
        XCTAssertEqual(pageControl.padding, 10.0)
        XCTAssertEqual(pageControl.radius, 0.0)
        XCTAssertEqual(pageControl.hidesForSinglePage, true)
        XCTAssertEqual(pageControl.borderWidth, 1.0)
        XCTAssertEqual(pageControl.borderColor, .white)
        XCTAssertEqual(pageControl.currentPageIndicatorTintColor, .white)
        XCTAssertEqual(pageControl.pageIndicatorTintColor, .black)
        XCTAssertEqual(pageControl.horizontalMargin, 20.0)
    }
}
