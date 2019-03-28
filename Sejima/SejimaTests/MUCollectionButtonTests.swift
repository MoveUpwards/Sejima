//
//  MUCollectionButtonTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 25/02/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import XCTest
@testable import Sejima

class MUCollectionButtonTests: XCTestCase {

    func testDefaultValues() {
        let collection = MUCollectionButton()
        XCTAssertNotNil(collection)

        XCTAssertEqual(collection.isLoading, false)
        XCTAssertEqual(collection.indicatorColor, .white)
        XCTAssertEqual(collection.borderWidth, 0.0)
        XCTAssertEqual(collection.borderColor, .clear)
        XCTAssertEqual(collection.spacing, 0.0)
        XCTAssertEqual(collection.hasSeparator, false)
        XCTAssertEqual(collection.separatorHeightMultiplier, 1.0)
        XCTAssertEqual(collection.textColor, .black)
        XCTAssertEqual(collection.selectedTextColor, .lightGray)
        XCTAssertEqual(collection.textFont, .systemFont(ofSize: 17, weight: .regular))
        XCTAssertEqual(collection.horizontalPadding, 0.0)
        XCTAssertTrue(collection.items.isEmpty)
    }

    func testCustomValues() {
        let collection = MUCollectionButton()
        XCTAssertNotNil(collection)

        collection.isLoading = true
        collection.indicatorColor = .orange
        collection.borderWidth = 10.0
        collection.borderColor = .orange
        collection.spacing = 5.0
        collection.hasSeparator = true
        collection.separatorHeightMultiplier = 0.2
        collection.textColor = .green
        collection.selectedTextColor = .blue
        collection.textFont = .systemFont(ofSize: 24, weight: .regular)
        collection.horizontalPadding = 20.0

        collection.layoutSubviews()

        XCTAssertEqual(collection.isLoading, true)
        XCTAssertEqual(collection.indicatorColor, .orange)
        XCTAssertEqual(collection.borderWidth, 10.0)
        XCTAssertEqual(collection.borderColor, .orange)
        XCTAssertEqual(collection.spacing, 5.0)
        XCTAssertEqual(collection.hasSeparator, true)
        XCTAssertEqual(collection.separatorHeightMultiplier, 0.2)
        XCTAssertEqual(collection.textColor, .green)
        XCTAssertEqual(collection.selectedTextColor, .blue)
        XCTAssertEqual(collection.textFont, .systemFont(ofSize: 24, weight: .regular))
        XCTAssertEqual(collection.horizontalPadding, 20.0)
        XCTAssertTrue(collection.items.isEmpty)
    }

    func testItem() {
        let item = MUCollectionItem(text: "My text", image: UIImage())
        XCTAssertNotNil(item)

        XCTAssertEqual(item.text, "My text")
        XCTAssertNotNil(item.image)
    }

    func testCollectionButtonItems() {
        let collection = MUCollectionButton()
        XCTAssertNotNil(collection)
        XCTAssertTrue(collection.items.isEmpty)

        var items = [MUCollectionItem]()
        for i in 0 ..< 5 {
            items.append(MUCollectionItem(text: "\(i)"))
        }
        collection.items = items
        XCTAssertEqual(collection.items.count, 5)

        let last = items.last
        XCTAssertEqual(last?.text, "4")
    }

    func testEnable() {
        let collection = MUCollectionButton()
        XCTAssertNotNil(collection)

        var items = [MUCollectionItem]()
        for i in 0 ..< 5 {
            items.append(MUCollectionItem(text: "\(i)"))
        }
        collection.items = items
        XCTAssertEqual(collection.items.count, 5)

        collection.set(enabled: false, at: 2)
    }

    func testCustomIndicator() {
        let collection = MUCollectionButton()
        XCTAssertNotNil(collection)

        let indicator = UIActivityIndicatorView(style: .gray)
        collection.set(indicator)
    }
}
