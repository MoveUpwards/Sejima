//
//  MURadarGraphTests.swift
//  Tests
//
//  Created by Damien Noël Dubuisson on 20/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MURadarGraphTests: XCTestCase {

    func testDefaultValues() {
        let radar = MURadarGraph()
        XCTAssertNotNil(radar)

        XCTAssertEqual(radar.viewInset, 25.0)
        XCTAssertEqual(radar.spokeLineThickness, 1.0)
        XCTAssertEqual(radar.spokeLineColor, .white)
        XCTAssertEqual(radar.spokeLinePattern, [])
        XCTAssertEqual(radar.spokeTitles, [])
        XCTAssertEqual(radar.spokeTitleFont, .systemFont(ofSize: 12, weight: .regular))
        XCTAssertEqual(radar.spokeTitleColor, .white)
        XCTAssertEqual(radar.backgroundStyle, .circular)
        XCTAssertEqual(radar.backgroundLines, [])
        XCTAssertEqual(radar.dotRadius, 0.0)
        XCTAssertEqual(radar.dotLineThickness, 1.0)
        XCTAssertEqual(radar.dotLineColor, .white)
        XCTAssertEqual(radar.dotFillColor, .clear)
        XCTAssertEqual(radar.datas.count, 0)
        XCTAssertEqual(radar.chartBorderWidth, 1.0)
    }

    func testCustomValues() {
        let radar = getRadarForTest()
        XCTAssertNotNil(radar)

        XCTAssertEqual(radar.viewInset, 20.0)
        XCTAssertEqual(radar.spokeLineThickness, 3.0)
        XCTAssertEqual(radar.spokeLineColor, .cyan)
        XCTAssertEqual(radar.spokeLinePattern, [10.0, 5.0, 2.0, 5.0])
        XCTAssertEqual(radar.spokeTitles, ["One", "Two", "Three"])
        XCTAssertEqual(radar.spokeTitleFont, .systemFont(ofSize: 13, weight: .bold))
        XCTAssertEqual(radar.spokeTitleColor, .darkGray)
        XCTAssertEqual(radar.backgroundStyle, .spiderWeb)
        XCTAssertEqual(radar.backgroundLines.count, 4)
        XCTAssertEqual(radar.backgroundLines[0].strokeThickness, 4.0)
        XCTAssertEqual(radar.backgroundLines[0].strokeColor, .red)
        XCTAssertEqual(radar.dotRadius, 2.0)
        XCTAssertEqual(radar.dotLineThickness, 0.5)
        XCTAssertEqual(radar.dotLineColor, .red)
        XCTAssertEqual(radar.dotFillColor, .red)
        XCTAssertEqual(radar.chartBorderWidth, 1.0)
        XCTAssertEqual(radar.datas.count, 2)
        XCTAssertEqual(radar.data(at: 0)?.color, .blue)
    }

    private func getRadarForTest() -> MURadarGraph {
        let radar = MURadarGraph()
        let title = ["One", "Two", "Three"]
        let colors = [UIColor(red: 0.545, green: 0.906, blue: 0.996, alpha: 1.0),
                      UIColor(red: 0.706, green: 0.929, blue: 0.988, alpha: 1.0),
                      UIColor(red: 0.831, green: 0.949, blue: 0.984, alpha: 1.0),
                      UIColor(red: 0.922, green: 0.976, blue: 0.988, alpha: 1.0)]
        let lines = colors.map({ MURadarGraphBackgroundLine(fillColor: $0, strokeColor: .red, strokeThickness: 4.0) })

        radar.viewInset = 20.0
        radar.spokeTitles = title
        radar.spokeTitleFont = .systemFont(ofSize: 13, weight: .bold)
        radar.spokeLineThickness = 3.0
        radar.spokeLineColor = .cyan
        radar.spokeLinePattern = [10.0, 5.0, 2.0, 5.0]
        radar.spokeTitleColor = .darkGray
        radar.backgroundStyle = .spiderWeb
        radar.backgroundLines = lines
        radar.dotRadius = 2.0
        radar.dotLineThickness = 0.5
        radar.dotLineColor = .red
        radar.dotFillColor = .red
        radar.addChart(data: MURadarGraphData(values: [0.92, 0.55, 0.43], color: .blue))
        radar.addChart(data: MURadarGraphData(values: [0.42, 0.33, 0.76], color: .red))

        return radar
    }
}
