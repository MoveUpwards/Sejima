//
//  MUBarGraphTests.swift
//  Tests
//
//  Created by Damien Noël Dubuisson on 27/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUBarGraphTests: XCTestCase {

    func testDefaultValues() {
        let barGraph = MUBarGraph()
        XCTAssertNotNil(barGraph)

        XCTAssertEqual(barGraph.datas.isEmpty, true)
        XCTAssertEqual(barGraph.barTopInset, 0.0)
        XCTAssertEqual(barGraph.barWidth, 1.0)
        XCTAssertEqual(barGraph.indicatorMultiplier, 0.0)
        XCTAssertEqual(barGraph.indicatorFormat, "%.f")
        XCTAssertEqual(barGraph.indicatorTextFont, .systemFont(ofSize: 24.0, weight: .bold))
        XCTAssertEqual(barGraph.indicatorTextColor, .white)
        XCTAssertEqual(barGraph.indicatorWidth, 1e-07)
        XCTAssertEqual(barGraph.indicatorColor, .white)
        XCTAssertEqual(barGraph.titleFont, .systemFont(ofSize: 6, weight: .regular))
        XCTAssertEqual(barGraph.titleColor, .white)
        XCTAssertEqual(barGraph.titleTopInset, 0.0)
        XCTAssertEqual(barGraph.values, [])
        XCTAssertEqual(barGraph.valueRightInset, 0.0)
        XCTAssertEqual(barGraph.lineColor, .black)
        XCTAssertEqual(barGraph.lineWidth, 1.0)
    }

    func testCustomValues() {
        let barGraph = MUBarGraph()
        XCTAssertNotNil(barGraph)

        barGraph.datas = getDatas()
        barGraph.values = ["0", "300m", "600m", "900m", "1.2km", "1.5km"]
        barGraph.barTopInset = 5.0
        barGraph.barWidth = 2.0
        barGraph.indicatorMultiplier = 100.0
        barGraph.indicatorFormat = "%.f%%"
        barGraph.indicatorTextFont = .systemFont(ofSize: 20.0, weight: .regular)
        barGraph.indicatorTextColor = .lightGray
        barGraph.indicatorWidth = 0.5
        barGraph.indicatorColor = .black
        barGraph.titleFont = .systemFont(ofSize: 8, weight: .regular)
        barGraph.titleColor = .red
        barGraph.titleTopInset = 10.0
        barGraph.valueRightInset = 10.0
        barGraph.lineColor = .lightGray
        barGraph.lineWidth = 2.0

        barGraph.layoutSubviews()

        XCTAssertEqual(barGraph.datas.count, getDatas().count)
        XCTAssertEqual(barGraph.barTopInset, 5.0)
        XCTAssertEqual(barGraph.barWidth, 2.0)
        XCTAssertEqual(barGraph.indicatorMultiplier, 100.0)
        XCTAssertEqual(barGraph.indicatorFormat, "%.f%%")
        XCTAssertEqual(barGraph.indicatorTextFont, .systemFont(ofSize: 20.0, weight: .regular))
        XCTAssertEqual(barGraph.indicatorTextColor, .lightGray)
        XCTAssertEqual(barGraph.indicatorWidth, 0.5)
        XCTAssertEqual(barGraph.indicatorColor, .black)
        XCTAssertEqual(barGraph.titleFont, .systemFont(ofSize: 8, weight: .regular))
        XCTAssertEqual(barGraph.titleColor, .red)
        XCTAssertEqual(barGraph.titleTopInset, 10.0)
        XCTAssertEqual(barGraph.values, ["0", "300m", "600m", "900m", "1.2km", "1.5km"])
        XCTAssertEqual(barGraph.valueRightInset, 10.0)
        XCTAssertEqual(barGraph.lineColor, .lightGray)
        XCTAssertEqual(barGraph.lineWidth, 2.0)
    }

    private func getDatas() -> [MUBarGraphData] {
        return [MUBarGraphData(title: "MON", value: 0.1, color: .blue),
                MUBarGraphData(title: "TUE", value: 0.2, color: .red),
                MUBarGraphData(title: "WED", value: 0.7, color: .green),
                MUBarGraphData(title: "THU", value: 0.99, color: .lightGray),
                MUBarGraphData(title: "FRI", value: 0.1, color: .purple),
                MUBarGraphData(title: "SAT", value: 0.5, color: .cyan),
                MUBarGraphData(title: "SUN", value: 0.3, color: .yellow, showIndicator: true)]
    }
}
