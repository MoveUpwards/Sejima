//
//  MUSegmentedControlTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 05/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUSegmentedControlTests: XCTestCase {

    func testDefaultValues() {
        let segmented = MUSegmentedControl()
        XCTAssertNotNil(segmented)

        XCTAssertEqual(segmented.cornerRadius, 0.0)
        XCTAssertEqual(segmented.borderWidth, 0.0)
        XCTAssertEqual(segmented.titleFont, .systemFont(ofSize: 12.0))
        XCTAssertEqual(segmented.titleColor, .black)
        XCTAssertEqual(segmented.selectedTitleColor, .white)
        XCTAssertEqual(segmented.selectedColor, .lightGray)
        XCTAssertEqual(segmented.indicatorInset, 4.0)
        XCTAssertEqual(segmented.segmentSpacing, 0.0)
        XCTAssertTrue(segmented.allowPanningGesture)
        XCTAssertEqual(segmented.numberOfSegments, 0)
        XCTAssertEqual(segmented.selectedSegmentIndex, 0)
    }

    func testCustomValues() {
        let segmented = MUSegmentedControl()
        XCTAssertNotNil(segmented)

        segmented.cornerRadius = 5.0
        segmented.borderWidth = 2.0
        segmented.titleFont = .systemFont(ofSize: 14.0, weight: .bold)
        segmented.titleColor = .blue
        segmented.selectedTitleColor = .black
        segmented.selectedColor = .orange
        segmented.indicatorInset = 0.0
        segmented.segmentSpacing = 10.0
        segmented.allowPanningGesture = false

        XCTAssertEqual(segmented.cornerRadius, 5.0)
        XCTAssertEqual(segmented.borderWidth, 2.0)
        XCTAssertEqual(segmented.titleFont, .systemFont(ofSize: 14.0, weight: .bold))
        XCTAssertEqual(segmented.titleColor, .blue)
        XCTAssertEqual(segmented.selectedTitleColor, .black)
        XCTAssertEqual(segmented.selectedColor, .orange)
        XCTAssertEqual(segmented.indicatorInset, 0.0)
        XCTAssertEqual(segmented.segmentSpacing, 10.0)
        XCTAssertFalse(segmented.allowPanningGesture)
    }

    func testSegments() {
        let segmented = MUSegmentedControl()
        XCTAssertNotNil(segmented)

        segmented.segments = [MUSegmentItem(title: "ONE")]
        segmented.layoutSubviews()

        XCTAssertEqual(segmented.numberOfSegments, 1)
        XCTAssertEqual(segmented.selectedSegmentIndex, 0)

        segmented.segments = [MUSegmentItem(title: "ONE"), MUSegmentItem(title: "TWO"), MUSegmentItem(title: "THREE")]
        segmented.layoutSubviews()

        XCTAssertEqual(segmented.numberOfSegments, 3)
        XCTAssertEqual(segmented.selectedSegmentIndex, 0)

        segmented.set(index: 2)

        XCTAssertEqual(segmented.selectedSegmentIndex, 2)
    }

    func testCustomSegmentsWithTexts() {
        let segmented = MUSegmentedControl()
        XCTAssertNotNil(segmented)

        segmented.segments = [MUSegmentItem(title: "ONE",
                                            titleFont: .boldSystemFont(ofSize: 11.0),
                                            titleColor: .red,
                                            selectedTitleColor: .orange,
                                            selectedColor: .white),
                              MUSegmentItem(title: "TWO",
                                            titleFont: .italicSystemFont(ofSize: 12.0),
                                            titleColor: .blue,
                                            selectedTitleColor: .yellow,
                                            selectedColor: .black),
                              MUSegmentItem(title: "THREE",
                                            titleFont: .systemFont(ofSize: 10.0, weight: .regular),
                                            titleColor: .lightGray,
                                            selectedTitleColor: .purple,
                                            selectedColor: .brown)]
        segmented.layoutSubviews()

        XCTAssertEqual(segmented.numberOfSegments, 3)

        segmented.titleFont = .systemFont(ofSize: 14.0, weight: .light)
        segmented.titleColor = .darkGray
        segmented.selectedTitleColor = .black
        segmented.selectedColor = .red
        segmented.cornerRadius = 6.0
        segmented.layoutSubviews()

        XCTAssertEqual(segmented.numberOfSegments, 3)
    }

    func testCustomSegmentsWithImages() {
        let segmented = MUSegmentedControl()
        XCTAssertNotNil(segmented)

        segmented.segments = [MUSegmentItem(image: UIImage(),
                                            imageColor: .orange,
                                            selectedImage: UIImage(),
                                            selectedImageColor: .red,
                                            selectedColor: .blue)]
        segmented.layoutSubviews()

        XCTAssertEqual(segmented.numberOfSegments, 1)
    }

    func testIndexes() {
        let segmented = MUSegmentedControl()
        XCTAssertNotNil(segmented)

        segmented.segments = [MUSegmentItem(title: "ONE"), MUSegmentItem(title: "TWO"), MUSegmentItem(title: "THREE")]
        segmented.set(index: 1)

        XCTAssertEqual(segmented.numberOfSegments, 3)
        XCTAssertEqual(segmented.selectedSegmentIndex, 1)

        segmented.set(index: 4)

        XCTAssertEqual(segmented.selectedSegmentIndex, 1)
    }
}
