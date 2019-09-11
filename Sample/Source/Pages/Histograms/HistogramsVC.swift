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

        let maxGraphValue = CGFloat(25.0)
        let barGraphValues = [CGFloat](arrayLiteral: 20.1, 19.5, 18.2, 14.6, 23.6, 17.3, 16.0, 16.7, 16.0, 15.0, 14.5, 16.7)

        barGraph1.backgroundColor = .blackPearl
        barGraph1.barWidth = 0.4
        barGraph1.barTopInset = 20.0
        barGraph1.indicatorMultiplier = maxGraphValue
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

        barGraph1.values = ["0", "5", "10", "15", "20", "25"]
        var barGraphData = [MUBarGraphData]()

        let maxValue = barGraphValues.max() ?? 0.0
        barGraphValues.enumerated().forEach { offset, value in
            barGraphData.append(MUBarGraphData(title: "\(String(format: "%02d", offset+1))",
                                               value: value / maxGraphValue,
                                               color: value == maxValue ? .lima : .denim,
                                               showIndicator: true))
        }
        barGraph1.datas = barGraphData
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
