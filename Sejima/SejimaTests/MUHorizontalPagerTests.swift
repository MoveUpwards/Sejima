//
//  MUHorizontalPagerTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 27/02/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUHorizontalPagerTests: XCTestCase {

    func testDefaultValues() {
        let pager = MUHorizontalPager()
        XCTAssertNotNil(pager)

        XCTAssertEqual(pager.horizontalMargin, 0.0)
    }

    func testCustomValues() {
        let pager = MUHorizontalPager()
        XCTAssertNotNil(pager)

        pager.horizontalMargin = 20.0

        XCTAssertEqual(pager.horizontalMargin, 20.0)
    }

    func testPageControl() {
        let pageControl = MUPageControl()
        XCTAssertNotNil(pageControl)

        let pager = MUHorizontalPager()
        XCTAssertNotNil(pager)

        pager.pageControl = pageControl
        pager.add(views: [UIView(), UIView(), UIView()])

        XCTAssertEqual(pageControl.numberOfPages, 3)
    }
}
