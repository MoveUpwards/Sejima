//
//  MURadarGraphChart.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 19/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// Class that handle radar graph view
final internal class MURadarGraphChart: UIImageView {
    /// Define the chart view inset
    internal var viewInset: CGFloat = 25.0 {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the graph datas
    internal var data: MURadarGraphData? = nil {
        didSet {
            if let values = data?.values {
                valuesCount = values.count
                angle = 2.0 * CGFloat.pi / CGFloat(valuesCount)
            }
            setNeedsLayout()
        }
    }

    /// Define the chart border width
    internal var chartBorderWidth: CGFloat = 1.0 {
        didSet {
            setNeedsLayout()
        }
    }

    // MARK: - Private variables

    private var maxSize = CGFloat(0.0)
    private var valuesCount = 0
    private var angle = 2.0 * CGFloat.pi

    // MARK: - Private functions

    private func drawChart(in context: CGContext) {
        guard let data = data else {
            return
        }

        var currentX = CGFloat(0.0)
        var currentY = CGFloat(0.0)

        // Draw lines
        context.setLineWidth(chartBorderWidth)
        context.setAllowsAntialiasing(true)
        let path = CGMutablePath()

        for spoke in 0..<valuesCount {
            let value = data.values[spoke] * maxSize
            let fullAngle = angle * CGFloat(spoke) - CGFloat.pi / 2.0
            let nextX = value * cos(fullAngle)
            let nextY = value * sin(fullAngle)

            if currentX == 0.0 && currentY == 0.0 {
                path.move(to: CGPoint(x: nextX, y: nextY))
                currentX = nextX
                currentY = nextY
            } else {
                path.addLine(to: CGPoint(x: nextX, y: nextY))
            }
        }
        path.addLine(to: CGPoint(x: currentX, y: currentY))

        context.addPath(path)
        context.setFillColor(data.color.cgColor)
        context.fillPath()

        context.setStrokeColor(data.color.cgColor)
        context.addPath(path)
        context.strokePath()
    }

    private func drawChartImage() {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        defer {
            UIGraphicsEndImageContext()
        }

        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        context.translateBy(x: bounds.size.width * 0.5, y: bounds.size.height * 0.5)
        maxSize = bounds.size.width < bounds.size.height ?
            bounds.size.width * 0.5 - viewInset : bounds.size.height * 0.5 - viewInset

        drawChart(in: context)

        // Draw the image and set it to the UIImageView
        if let cgImage = context.makeImage() {
            UIGraphicsPopContext()
            image = .init(cgImage: cgImage)
        }
    }

    // MARK: - Life cycle functions

    /// Lays out subviews.
    override internal func layoutSubviews() {
        super.layoutSubviews()

        drawChartImage()
    }
}
