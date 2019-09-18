//
//  MUBarChartTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 18/09/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUBarChartTests: XCTestCase {

    func testDefaultValues() {
        let barChart = MUBarChart()
        XCTAssertNotNil(barChart)

        XCTAssertEqual(barChart.leftLabelsInset, 0.0)
        XCTAssertEqual(barChart.bottomLabelsInset, 0.0)

        XCTAssertEqual(barChart.leftLineColor, .white)
        XCTAssertEqual(barChart.leftSeparatorWidth, 1.0)
        XCTAssertEqual(barChart.bottomLineColor, .white)
        XCTAssertEqual(barChart.bottomSeparatorHeight, 1.0)

        XCTAssertEqual(barChart.bkgLineColor, UIColor.white.withAlphaComponent(0.5))
        XCTAssertEqual(barChart.bkgLineWidth, 0.5)
        XCTAssertEqual(barChart.bkgLineDashWidth, 1.0)
        XCTAssertEqual(barChart.bkgLineGapWidth, 0.0)

        XCTAssertEqual(barChart.labelFont, .systemFont(ofSize: 6.0, weight: .regular))
        XCTAssertEqual(barChart.labelColor, .white)
        XCTAssertEqual(barChart.valueFont, .systemFont(ofSize: 6.0, weight: .regular))
        XCTAssertEqual(barChart.valueColor, .white)
        XCTAssertEqual(barChart.valueFormat, "%.f")

        XCTAssertEqual(barChart.type, .stacked)
        XCTAssertEqual(barChart.orientation, .vertical)
        XCTAssertEqual(barChart.showTotalValue, false)
        XCTAssertEqual(barChart.totalValueOffset, 5.0)
        XCTAssertEqual(barChart.values.count, 0)
        XCTAssertEqual(barChart.datas.count, 0)
        XCTAssertEqual(barChart.maxDataValue, 0.0)
        XCTAssertEqual(barChart.barWidth, 1.0)
        XCTAssertEqual(barChart.barRadius, 0.0)
    }

    //swiftlint:disable:next function_body_length
    func testCustomValues() {
        let barChart = MUBarChart()
        XCTAssertNotNil(barChart)

        barChart.leftLabelsInset = 5.0
        barChart.bottomLabelsInset = 4.0

        barChart.leftLineColor = .black
        barChart.leftSeparatorWidth = 2.0
        barChart.bottomLineColor = .darkGray
        barChart.bottomSeparatorHeight = 3.0

        barChart.bkgLineColor = .red
        barChart.bkgLineWidth = 0.25
        barChart.bkgLineDashWidth = 6.0
        barChart.bkgLineGapWidth = 3.0

        barChart.labelFont = .systemFont(ofSize: 8.0, weight: .semibold)
        barChart.labelColor = .orange
        barChart.valueFont = .systemFont(ofSize: 7.0, weight: .bold)
        barChart.valueColor = .purple
        barChart.valueFormat = "%.1f"

        barChart.type = .sideBySide
        barChart.orientation = .horizontal
        barChart.showTotalValue = true
        barChart.totalValueOffset = 7.0
        barChart.maxDataValue = 100.0
        barChart.barWidth = 0.8
        barChart.barRadius = 10.0

        barChart.values = ["0", "50", "100"]
        barChart.datas = [MUBarChartData(title: "Single",
                                         value: MUBarChartValue(value: 26.8, color: .brown),
                                         showValue: true),
                          MUBarChartData(title: "Multiple",
                                         values: [MUBarChartValue(value: 75.2, color: .lightGray),
                                                  MUBarChartValue(value: 55.9, color: .blue)],
                                         showValue: false)]

        barChart.compute()

        XCTAssertEqual(barChart.leftLabelsInset, 5.0)
        XCTAssertEqual(barChart.bottomLabelsInset, 4.0)

        XCTAssertEqual(barChart.leftLineColor, .black)
        XCTAssertEqual(barChart.leftSeparatorWidth, 2.0)
        XCTAssertEqual(barChart.bottomLineColor, .darkGray)
        XCTAssertEqual(barChart.bottomSeparatorHeight, 3.0)

        XCTAssertEqual(barChart.bkgLineColor, .red)
        XCTAssertEqual(barChart.bkgLineWidth, 0.25)
        XCTAssertEqual(barChart.bkgLineDashWidth, 6.0)
        XCTAssertEqual(barChart.bkgLineGapWidth, 3.0)

        XCTAssertEqual(barChart.labelFont, .systemFont(ofSize: 8.0, weight: .semibold))
        XCTAssertEqual(barChart.labelColor, .orange)
        XCTAssertEqual(barChart.valueFont, .systemFont(ofSize: 7.0, weight: .bold))
        XCTAssertEqual(barChart.valueColor, .purple)
        XCTAssertEqual(barChart.valueFormat, "%.1f")

        XCTAssertEqual(barChart.type, .sideBySide)
        XCTAssertEqual(barChart.orientation, .horizontal)
        XCTAssertEqual(barChart.showTotalValue, true)
        XCTAssertEqual(barChart.totalValueOffset, 7.0)
        XCTAssertEqual(barChart.values.count, 3)
        XCTAssertEqual(barChart.datas.count, 2)
        XCTAssertEqual(barChart.maxDataValue, 100.0)
        XCTAssertEqual(barChart.barWidth, 0.8)
        XCTAssertEqual(barChart.barRadius, 10.0)

        barChart.orientation = .vertical
        barChart.compute()
    }
}
