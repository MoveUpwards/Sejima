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
    @IBOutlet private var horizontalBarChart2: MUBarChart!
    @IBOutlet private var barChart2: MUBarChart!

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
            barGraphData.append(MUBarGraphData(title: String(format: "%02d", offset+1),
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
        barChart1.valueFont = UIFont.systemFont(ofSize: 8.0, weight: .semibold)
        barChart1.maxDataValue = maxDataValue
        barChart1.barWidth = 0.4
        barChart1.showTotalValue = true
        barChart1.valueFormat = "%.1f"
        barChart1.barRadius = 4.0

        barChart1.values = values
        datas.enumerated().forEach { offset, value in
            let value = MUBarChartData(title: String(format: "%02d", offset+1),
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
        horizontalBarChar1.valueFont = UIFont.systemFont(ofSize: 8.0, weight: .semibold)
        horizontalBarChar1.orientation = .horizontal
        horizontalBarChar1.maxDataValue = 12000
        horizontalBarChar1.barWidth = 0.6
        horizontalBarChar1.showTotalValue = true
        horizontalBarChar1.barRadius = 4.0
        horizontalBarChar1.roundCorners([.topLeft, .topRight], value: 5.0)

        horizontalBarChar1.values = ["0", "3000", "6000", "9000", "12000"]
        let datas2 = [CGFloat(9947), 9935, 9179, 9128, 8889, 8504, 8406, 8278, 8070, 3207, 1696, 827]
        datas2.enumerated().forEach { offset, value in
            horizontalBarChar1.datas.append(MUBarChartData(title: "\(String(format: "%02d", offset+1))", value: MUBarChartValue(value: value, color: .denim)))
//            horizontalBarChar1.datas.append(MUBarChartData(title: "\(String(format: "%02d", offset+1))",
//                values: [MUBarChartValue(value: value, color: .denim), MUBarChartValue(value: 200.0, color: .lima)]))
        }
        horizontalBarChar1.compute()

        // MARK: - Horizontal MUBarChart 2

        horizontalBarChart2.backgroundColor = .clear
        horizontalBarChart2.leftLabelsInset = 4.0
        horizontalBarChart2.bottomLabelsInset = 4.0
        horizontalBarChart2.labelFont = UIFont.systemFont(ofSize: 8.0, weight: .semibold)
        horizontalBarChart2.valueFont = UIFont.systemFont(ofSize: 8.0, weight: .semibold)
        horizontalBarChart2.orientation = .horizontal
        horizontalBarChart2.maxDataValue = 2000
        horizontalBarChart2.barWidth = 0.7
        horizontalBarChart2.showTotalValue = true
        horizontalBarChart2.barRadius = 4.0

        horizontalBarChart2.values = ["0", "500", "1000", "1500", "2000"]
        let datas3 = [CGFloat(1518), 1516, 1180, 1038, 1011, 819, 648, 586, 380, 356, 293, 95]
        datas3.enumerated().forEach { offset, value in
            let blueValue = CGFloat.random(in: value*0.5 ... value*0.8) // Between 50% and 80%
            let redValue = CGFloat.random(in: value*0.05 ... value*0.15) // Between 5% and 15%

            horizontalBarChart2.datas.append(
                MUBarChartData(title: String(format: "%02d", offset+1),
                               values: [MUBarChartValue(value: blueValue, color: .denim),
                                        MUBarChartValue(value: value - blueValue - redValue, color: .outrageousOrange),
                                        MUBarChartValue(value: redValue, color: .venetianRed)])
            )

//            horizontalBarChart2.datas
        }

        horizontalBarChart2.compute()

        // MARK: - MUBarChart 2

        barChart2.backgroundColor = .white
        barChart2.leftLabelsInset = 4.0
        barChart2.bottomLabelsInset = 4.0
        barChart2.labelFont = UIFont.systemFont(ofSize: 8.0, weight: .bold)
        barChart2.labelColor = .black
        barChart2.valueFont = UIFont.systemFont(ofSize: 8.0, weight: .semibold)
        barChart2.valueColor = .black
        barChart2.orientation = .vertical
        barChart2.maxDataValue = 1200
        barChart2.barWidth = 0.6
        barChart2.showTotalValue = true
        barChart2.barRadius = 2.0

        let stackedValues = [[CGFloat(486), 333, 293],
                             [518, 313, 203],
                             [521, 277, 137],
                             [472, 260, 129],
                             [388, 249, 197],
                             [572, 205, 39],
                             [339, 241, 202],
                             [369, 245, 160],
                             [509, 175, 44],
                             [300, 157, 183],
                             [205, 146, 181],
                             [111, 85, 50],
                             [58, 69, 90]]
        var stackedData = [MUBarChartData]()
        stackedValues.enumerated().forEach { offset, arrayValues in
            let c = UnicodeScalar(65 + offset) // A and so on...
            var str = ""
            if let c = c {
                str = String(UnicodeScalar(c))
            }

            var b = [MUBarChartValue]()
            arrayValues.enumerated().forEach { index, floatValue in
                let color: UIColor
                switch index {
                case 1:
                    color = .orange
                case 2:
                    color = .red
                default:
                    color = .yellow
                }
                b.append(MUBarChartValue(value: floatValue, color: color))
            }

            let a = MUBarChartData(title: String(repeating: str, count: 3),
                                   values: b,
                                   showValue: true)

            stackedData.append(a)
        }
        barChart2.values = ["0", "200", "400", "600", "800", "1000", "1200"]
        barChart2.datas = stackedData
        barChart2.compute()
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

    class var outrageousOrange: UIColor {
        return UIColor(hex: 0xF3522B)
    }

    class var venetianRed: UIColor {
        return UIColor(hex: 0xB60910)
    }
}
