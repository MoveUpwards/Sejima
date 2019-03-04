//
//  MUAvatarTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 25/02/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import XCTest
@testable import Sejima

class MUAvatarTests: XCTestCase {

    func testDefaultValues() {
        let avatar = MUAvatar()
        XCTAssertNotNil(avatar)

        XCTAssertEqual(avatar.radius, 0)
        XCTAssertEqual(avatar.borderWidth, 2)
        XCTAssertEqual(avatar.borderColor, .black)
        XCTAssertEqual(avatar.style, .round)
        XCTAssertNil(avatar.avatarImage)
        XCTAssertNil(avatar.placeholderImage)
    }

    func testCustomValues() {
        let avatar = MUAvatar()
        XCTAssertNotNil(avatar)

        avatar.borderWidth = 10
        avatar.borderColor = .orange
        avatar.style = .square
        avatar.avatarImage = UIImage()
        avatar.placeholderImage = UIImage()

        avatar.layoutSubviews()

        XCTAssertEqual(avatar.radius, 0)
        XCTAssertEqual(avatar.borderWidth, 10)
        XCTAssertEqual(avatar.borderColor, .orange)
        XCTAssertEqual(avatar.style, .square)
        XCTAssertNotNil(avatar.avatarImage)
        XCTAssertNotNil(avatar.placeholderImage)
    }

    func testAvatarTypeInt() {
        let avatar = MUAvatar()
        XCTAssertNotNil(avatar)

        XCTAssertEqual(avatar.avatarStyleInt, 0)
        XCTAssertEqual(avatar.style, .round)

        avatar.avatarStyleInt = 1
        XCTAssertEqual(avatar.style, .square)

        avatar.avatarStyleInt = 2
        XCTAssertEqual(avatar.style, .custom(0))
    }

    func testAvatarRadius() {
        let avatar = MUAvatar()
        XCTAssertNotNil(avatar)

        avatar.radius = 6
        XCTAssertEqual(avatar.style, .custom(6))
    }
}
