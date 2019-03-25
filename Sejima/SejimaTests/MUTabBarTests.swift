//
//  MUTabBarTests.swift
//  Tests
//
//  Created by Damien Noël Dubuisson on 07/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUTabBarTests: XCTestCase {

    func testDefaultValues() {
        let tabBar = MUTabBar()
        XCTAssertNotNil(tabBar)

        XCTAssertEqual(tabBar.selectedColor, .white)
        XCTAssertEqual(tabBar.unselectedColor, .white)
        XCTAssertEqual(tabBar.separatorColor, .white)
        XCTAssertEqual(tabBar.separatorHeight, 1)
    }

    func testCustomValues() {
        let tabBar = MUTabBar()
        XCTAssertNotNil(tabBar)

        tabBar.selectedColor = .orange
        tabBar.unselectedColor = .green
        tabBar.separatorColor = .blue
        tabBar.separatorHeight = 2.0

        tabBar.items = [UITabBarItem(tabBarSystemItem: .contacts, tag: 0),
                        UITabBarItem(tabBarSystemItem: .more, tag: 1)]
        tabBar.select(at: 0)

        XCTAssertEqual(tabBar.selectedColor, .orange)
        XCTAssertEqual(tabBar.unselectedColor, .green)
        XCTAssertEqual(tabBar.separatorColor, .blue)
        XCTAssertEqual(tabBar.separatorHeight, 2)
    }
}
