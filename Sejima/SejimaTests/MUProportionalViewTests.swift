//
//  MUProportionalViewTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 12/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUProportionalViewTests: XCTestCase {

    func testViewValues() {
        let view = MUProportionalView()
        XCTAssertNotNil(view)
        XCTAssertEqual(view.intrinsicContentSize.width, 1.0)
        XCTAssertEqual(view.intrinsicContentSize.height, 1.0)

        view.set(width: 1.7)

        XCTAssertEqual(view.intrinsicContentSize.width, 1.7)

        view.set(height: 0.8)

        XCTAssertEqual(view.intrinsicContentSize.height, 0.8)
    }
}
