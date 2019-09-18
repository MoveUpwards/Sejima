//
//  MUViewGradientTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 18/09/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUViewGradientTests: XCTestCase {

    func testGradient() {
        let view = UIView()
        XCTAssertEqual(view.layer.sublayers?.count, nil) // No sublayer so still nil

        view.addGradient(with: [.black, .white])
        XCTAssertEqual(view.layer.sublayers?.count, 1)
        XCTAssertEqual(view.layer.sublayers?.first?.name, "GradientLayer")

        view.addGradient("CustomLayer", with: [.red, .blue])
        XCTAssertEqual(view.layer.sublayers?.count, 2)
        XCTAssertEqual(view.layer.sublayers?.first?.name, "CustomLayer")

        view.addGradient(with: [.yellow, .purple])
        XCTAssertEqual(view.layer.sublayers?.count, 2) // Still 2 layers as the GradientLayer is replaced
    }
}
