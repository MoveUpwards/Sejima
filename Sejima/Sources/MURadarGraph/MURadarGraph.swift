//
//  MURadarGraph.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 19/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Class that provide radar graph with multiple charts data.
@IBDesignable
open class MURadarGraph: MUNibView {
    @IBOutlet private var background: MURadarGraphBackground!
    @IBOutlet private var charts: UIView!

    // MARK: - General

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var viewInset: CGFloat = 25.0 {
        didSet {
            background.viewInset = viewInset
        }
    }

    // MARK: - MURadarGraphBackground

    /// Define the style for each background line from center to outside
    @objc open dynamic var backgroundLines: [MURadarGraphBackgroundLine] = [] {
        didSet {
            background.backgroundLines = backgroundLines
        }
    }

    /// Define the width of the spoke line
    @IBInspectable open dynamic var spokeLineThickness: CGFloat = 1.0 {
        didSet {
            background.spokeLineThickness = spokeLineThickness
        }
    }

    /// Define the color of the spoke line
    @IBInspectable open dynamic var spokeLineColor: UIColor = .white {
        didSet {
            background.spokeLineColor = spokeLineColor
        }
    }

    /// Define the color of the spoke line
    @IBInspectable open dynamic var spokeTitleColor: UIColor = .white {
        didSet {
            background.spokeTitleColor = spokeTitleColor
        }
    }

    /**
     Define the painted segment and unpainted segment, and so on

     How to use:
     - []: The line will be continue
     - [10.0]: The dash and the space will have the same size of 10 pixels
     - [10.0, 5.0]: The width's dash will be 10 pixels and the width's space will be 5 pixels
     - [10.0, 5.0, 2.0, 5.0]: That will create a line with dash and dot spacing with 5 pixels
     */
    @objc open dynamic var spokeLinePattern: [CGFloat] = [] {
        didSet {
            background.spokeLinePattern = spokeLinePattern
        }
    }

    /// Define the name of each spoke
    @objc open dynamic var spokeTitles: [String] = [] {
        didSet {
            background.spokeTitles = spokeTitles
        }
    }

    /// Define the font of each spoke title
    @objc open dynamic var spokeTitleFont: UIFont = .systemFont(ofSize: 12, weight: .regular) {
        didSet {
            background.spokeTitleFont = spokeTitleFont
        }
    }

    /// Define the spokes title horizontal offset
    @objc open dynamic var spokeTitleHorizontalOffset: CGFloat = 8 {
        didSet {
            background.spokeTitleHorizontalOffset = spokeTitleHorizontalOffset
        }
    }

    /// Define the spokes title vertical offset
    @objc open dynamic var spokeTitleVerticalOffset: CGFloat = 8 {
        didSet {
            background.spokeTitleVerticalOffset = spokeTitleVerticalOffset
        }
    }

    /// Define the appearance of the bkg
    open var backgroundStyle: MURadarGraphStyle = .circular {
        didSet {
            background.style = backgroundStyle
        }
    }

    /// Define the appearance of the bkg (using Int value)
    @IBInspectable open dynamic var backgroundStyleInt: Int = 0 {
        didSet {
            backgroundStyle = MURadarGraphStyle(rawValue: backgroundStyleInt) ?? .circular
        }
    }

    /// Define the width of the bkg line
    @IBInspectable open dynamic var dotRadius: CGFloat = 0.0 {
        didSet {
            background.dotRadius = dotRadius
        }
    }

    /// Define the width of the bkg line
    @IBInspectable open dynamic var dotLineThickness: CGFloat = 1.0 {
        didSet {
            background.dotLineThickness = dotLineThickness
        }
    }

    /// Define the color of the bkg line
    @IBInspectable open dynamic var dotLineColor: UIColor = .white {
        didSet {
            background.dotLineColor = dotLineColor
        }
    }

    /// Define the color of the bkg line
    @IBInspectable open dynamic var dotFillColor: UIColor = .clear {
        didSet {
            background.dotFillColor = dotFillColor
        }
    }

    // MARK: - MURadarGraphChart

    /// Define the border width of the chart
    @IBInspectable open dynamic var chartBorderWidth: CGFloat = 1.0 {
        didSet {
            charts.subviews.map({ $0 as? MURadarGraphChart }).forEach { chart in
                chart?.chartBorderWidth = chartBorderWidth
            }
        }
    }

    // MARK: - Public functions

    /// Add graph data to chart with fade out animation
    open func addChart(data: MURadarGraphData,
                       duration: TimeInterval = 0.0,
                       delay: TimeInterval = 0.0,
                       completion: ((Bool) -> Void)? = nil) {
        let chart = MURadarGraphChart()
        chart.translatesAutoresizingMaskIntoConstraints = false

        charts.addSubview(chart)
        charts.topAnchor.constraint(equalTo: chart.topAnchor).isActive = true
        charts.trailingAnchor.constraint(equalTo: chart.trailingAnchor).isActive = true
        charts.bottomAnchor.constraint(equalTo: chart.bottomAnchor).isActive = true
        charts.leadingAnchor.constraint(equalTo: chart.leadingAnchor).isActive = true

        chart.viewInset = viewInset
        chart.chartBorderWidth = chartBorderWidth
        chart.data = data
        chart.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)

        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
            chart.transform = .identity
        }, completion: completion)
    }

    /// Bring chart data to front
    open func bringChartToFront(at index: Int) {
        guard index < charts.subviews.count, index >= 0 else {
            return
        }
        charts.bringSubviewToFront(charts.subviews[index])
    }

    /// Send chart data to back
    open func sendChartToBack(at index: Int) {
        guard index < charts.subviews.count, index >= 0 else {
            return
        }
        charts.sendSubviewToBack(charts.subviews[index])
    }

    /// Remove graph data from chart with fade out animation
    open func removeChart(at index: Int,
                          duration: TimeInterval = 0.0,
                          delay: TimeInterval = 0.0,
                          completion: ((Bool) -> Void)? = nil) {
        guard index < charts.subviews.count, index >= 0 else {
            return
        }
        let chart = charts.subviews[index]
        chart.transform = .identity

        UIView.animate(withDuration: duration,
                       delay: delay,
                       animations: {
            chart.alpha = 0.0
        }, completion: { completed in
            chart.removeFromSuperview()
            completion?(completed)
        })
    }

    /// Define the data graph to chart
    open var datas: [MURadarGraphData] {
        var datas = [MURadarGraphData]()
        charts.subviews.map({ $0 as? MURadarGraphChart }).forEach { chart in
            if let data = chart?.data {
                datas.append(data)
            }
        }
        return datas
    }

    /// Return graph data for a given chart index.
    open func data(at index: Int) -> MURadarGraphData? {
        guard index < charts.subviews.count, index >= 0,
            let chart = charts.subviews[index] as? MURadarGraphChart else {
            return nil
        }
        return chart.data
    }
}
