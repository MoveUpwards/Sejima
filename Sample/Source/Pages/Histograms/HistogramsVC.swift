//
//  HistogramsVC.swift
//  Sample
//
//  Created by Damien Noël Dubuisson on 10/09/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import UIKit
import Sejima

final class HistogramsVC: UIViewController {
    @IBOutlet private var histo1: MUHistogram!
    @IBOutlet private var barGraph1: MUBarGraph!
    @IBOutlet private var barChart1: MUBarChart!
    @IBOutlet private var horizontalBarChar1: MUBarChart!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blackPearl

        // MARK: - MUHistogram

        histo1.backgroundColor = .darkGray
        histo1.barColor = .lightGray
        histo1.contentHorizontalPadding = 20.0
        //        histo1.contentVerticalPadding = 50.0 // No top padding :(

        var histogramValues = [CGFloat]()
        for _ in 0...10 {
            histogramValues.append(CGFloat.random(in: Range(uncheckedBounds: (lower: CGFloat(0.0), upper: CGFloat(10.0)))))
        }

        histo1.values = histogramValues
        // No highlight max bar :(

        // MARK: - MUBarGraph

        let maxDataValue = CGFloat(25.0)
        let datas = [CGFloat(20.1), 19.5, 18.2, 14.6, 23.6, 17.3, 16.0, 16.7, 16.0, 15.0, 14.5, 16.7]
        let values = ["0", "5", "10", "15", "20", "25"]

        barGraph1.backgroundColor = .blackPearl
        barGraph1.barWidth = 0.4
        barGraph1.barTopInset = 20.0
        barGraph1.indicatorMultiplier = maxDataValue
        barGraph1.indicatorFormat = "%.1f"
        barGraph1.indicatorWidth = 1.0
        barGraph1.indicatorTextColor = .white
        barGraph1.indicatorColor = .clear
        barGraph1.indicatorTextFont = UIFont.systemFont(ofSize: 8.0, weight: .semibold)
        barGraph1.titleTopInset = 4.0
        barGraph1.titleFont = UIFont.systemFont(ofSize: 8.0, weight: .semibold)
        barGraph1.valueRightInset = 4.0
        barGraph1.lineColor = UIColor.white.withAlphaComponent(0.5)
        barGraph1.lineWidth = 0.5

        barGraph1.values = values
        var barGraphData = [MUBarGraphData]()

        let maxValue = datas.max() ?? 0.0
        datas.enumerated().forEach { offset, value in
            barGraphData.append(MUBarGraphData(title: "\(String(format: "%02d", offset+1))",
                                               value: value / maxDataValue,
                                               color: value == maxValue ? .lima : .denim,
                                               showIndicator: true))
        }
        barGraph1.datas = barGraphData

        // MARK: - MUBarChart

        barChart1.backgroundColor = .clear
        barChart1.leftLabelsInset = 4.0
        barChart1.bottomLabelsInset = 4.0
        barChart1.labelFont = UIFont.systemFont(ofSize: 8.0, weight: .semibold)
        barChart1.maxDataValue = maxDataValue
        barChart1.barWidth = 0.4

        barChart1.values = values
        datas.enumerated().forEach { offset, value in
            let value = MUBarChartData(title: "\(String(format: "%02d", offset+1))",
                                       value: MUBarChartValue(value: value, color: value == maxValue ? .lima : .denim))
//            let value = MUBarChartData(title: "\(String(format: "%02d", offset+1))",
//                                       values: [MUBarChartValue(value: value, color: .denim), MUBarChartValue(value: 2.0, color: .lima)])
            barChart1.datas.append(value)
        }
        barChart1.compute()

        // MARK: - Horizontal MUBarChart

        horizontalBarChar1.backgroundColor = .clear
        horizontalBarChar1.leftLabelsInset = 4.0
        horizontalBarChar1.bottomLabelsInset = 4.0
        horizontalBarChar1.labelFont = UIFont.systemFont(ofSize: 8.0, weight: .semibold)
        horizontalBarChar1.orientation = .horizontal
        horizontalBarChar1.maxDataValue = 12000
        horizontalBarChar1.barWidth = 0.6

        horizontalBarChar1.values = ["0", "3000", "6000", "9000", "12000"] // ["0", "500", "1000", "1500", "2000"]
        let datas2 = [CGFloat(9947), 9935, 9179, 9128, 8889, 8504, 8406, 8278, 8070, 3207, 1696, 827]
        datas2.enumerated().forEach { offset, value in
            horizontalBarChar1.datas.append(MUBarChartData(title: "\(String(format: "%02d", offset+1))", value: MUBarChartValue(value: value, color: .denim)))
//            horizontalBarChar1.datas.append(MUBarChartData(title: "\(String(format: "%02d", offset+1))",
//                values: [MUBarChartValue(value: value, color: .denim), MUBarChartValue(value: 200.0, color: .lima)]))
        }
        horizontalBarChar1.compute()
    }
}


extension UIColor {
    class var denim: UIColor { // Blue
        return UIColor(hex: 0x0D60B5)
    }

    class var lima: UIColor { // Green
        return UIColor(hex: 0x80B622)
    }

    class var blackPearl: UIColor {
        return UIColor(hex: 0x00171F)
    }
}
