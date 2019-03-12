//
//  MUImageTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 12/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUImageTests: XCTestCase {

    func testHistogramImage() {
        let image = UIImage(histogram: [1.0, 3.0, 2.0], bar: .blue, size: CGSize(width: 200.0, height: 50.0))
        XCTAssertNotNil(image)
    }
}
