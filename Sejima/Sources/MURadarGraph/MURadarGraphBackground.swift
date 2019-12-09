//
//  MURadarGraphBackground.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 19/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// Class that handle radar graph background view
final internal class MURadarGraphBackground: UIImageView {
    /// Define the view inset
    internal var viewInset: CGFloat = 25.0 {
        didSet {
            setNeedsLayout()
        }
    }

    // MARK: - Private variables

    private var maxSize = CGFloat(0.0)
    private var angle = 2.0 * CGFloat.pi

    /// Define the spoke line thickness
    internal var spokeLineThickness: CGFloat = 1.0 {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the spoke line color
    internal var spokeLineColor: UIColor = .white {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the spoke line pattern
    internal var spokeLinePattern: [CGFloat] = [] {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the spokes title
    internal var spokeTitles: [String] = [] {
        didSet {
            angle = 2.0 * CGFloat.pi / CGFloat(spokeTitles.count)
            setNeedsLayout()
        }
    }

    /// Define the spokes title font
    internal var spokeTitleFont: UIFont = .systemFont(ofSize: 12, weight: .regular) {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the spokes title color
    internal var spokeTitleColor: UIColor = .white {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the spokes title horizontal offset
    internal var spokeTitleHorizontalOffset: CGFloat = 8 {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the spokes title vertical offset
    internal var spokeTitleVerticalOffset: CGFloat = 8 {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the graph style
    internal var style: MURadarGraphStyle = .circular {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the background lines
    internal var backgroundLines: [MURadarGraphBackgroundLine] = [] {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the dot graph radius
    internal var dotRadius: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the dot line thickness
    internal var dotLineThickness: CGFloat = 1.0 {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the dot line color
    internal var dotLineColor: UIColor = .white {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the dot color
    internal var dotFillColor: UIColor = .clear {
        didSet {
            setNeedsLayout()
        }
    }

    // MARK: - Private functions

    private func drawGraph() {
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

        drawBackgroundLine(in: context)
        drawSpokeLines(count: spokeTitles.count, in: context)
        drawDot(in: context)

        // Draw the image and set it to the UIImageView
        if let cgImage = context.makeImage() {
            UIGraphicsPopContext()
            image = .init(cgImage: cgImage)
        }
    }

    private func drawBackgroundLine(in context: CGContext) {
        guard !backgroundLines.isEmpty else {
            return
        }

        for index in (1...backgroundLines.count).reversed() {
            context.setStrokeColor(backgroundLines[index - 1].strokeColor.cgColor)
            let path: UIBezierPath

            switch style {
            case .circular:
                path = createCircularPath(at: index)
            case .spiderWeb:
                path = createWebPath(at: index)
            }

            backgroundLines[index - 1].fillColor.setFill()

            path.lineWidth = backgroundLines[index - 1].strokeThickness
            path.fill()
            path.stroke()
        }
    }

    private func createCircularPath(at index: Int) -> UIBezierPath {
        return getCircle(at: .zero, radius: CGFloat(index * Int(maxSize) / backgroundLines.count))
    }

    private func createWebPath(at index: Int) -> UIBezierPath {
        let path = UIBezierPath()

        for spoke in 0...spokeTitles.count {
            let coord = getCoord(at: index, for: spoke)
            if spoke == 0 {
                path.move(to: coord)
            } else {
                path.addLine(to: coord)
            }
        }
        path.close()

        return path
    }

    private func drawSpokeLines(count: Int, in context: CGContext) {
        context.setLineWidth(spokeLineThickness)
        for index in 0..<count {
            let fullAngle = angle * CGFloat(index) - CGFloat.pi / 2.0
            var point = CGPoint(x: (maxSize - 2.0) * cos(fullAngle), y: (maxSize - 2.0) * sin(fullAngle))

            context.move(to: .zero)
            context.setStrokeColor(spokeLineColor.cgColor)
            context.setLineDash(phase: 0.0, lengths: spokeLinePattern)
            context.addLine(to: point)
            context.strokePath()

            let title = spokeTitles[index]
            let size = title.constrainedSize(font: spokeTitleFont)

            point.x += point.x / maxSize * size.width * 0.5
            if point.x > 0.1 || point.x < -0.1 {
                point.x += point.x > 0.0 ? -spokeTitleHorizontalOffset : spokeTitleHorizontalOffset
            }
            point.x -= size.width * 0.5
            point.y += point.y > 0.0 ? spokeTitleVerticalOffset : -(spokeTitleVerticalOffset + spokeTitleFont.pointSize)

            context.setFillColor(spokeLineColor.cgColor)
            title.draw(with: CGRect(origin: point, size: size),
                       options: .usesLineFragmentOrigin,
                       attributes: [.font: spokeTitleFont, .foregroundColor: spokeTitleColor],
                       context: nil)
        }
    }

    private func drawDot(in context: CGContext) {
        guard !backgroundLines.isEmpty, dotRadius > 0.0 else {
            return
        }

        context.setLineDash(phase: 0.0, lengths: [])
        context.setStrokeColor(dotLineColor.cgColor)
        context.setFillColor(dotFillColor.cgColor)

        for index in (1...backgroundLines.count).reversed() {
            for spoke in 0...spokeTitles.count {
                let path = getCircle(at: getCoord(at: index, for: spoke), radius: dotRadius)
                path.lineWidth = dotLineThickness
                path.fill()
                path.stroke()
            }
        }
    }

    private func getCoord(at index: Int, for spoke: Int) -> CGPoint {
        let innerRadius = CGFloat(index) / CGFloat(backgroundLines.count) * maxSize
        var coord = CGPoint(x: CGFloat(0.0), y: -innerRadius)

        if spoke != 0 && spoke != spokeTitles.count {
            coord.x = -innerRadius * sin(angle * CGFloat(spoke))
            coord.y = -innerRadius * cos(angle * CGFloat(spoke))
        }

        return coord
    }

    private func getCircle(at center: CGPoint, radius: CGFloat) -> UIBezierPath {
        return UIBezierPath(arcCenter: center,
                            radius: radius,
                            startAngle: 0.0,
                            endAngle: .pi * 2.0,
                            clockwise: true)
    }

    // MARK: - Life cycle functions

    /// Lays out subviews.
    override internal func layoutSubviews() {
        super.layoutSubviews()

        guard !spokeTitles.isEmpty else {
            return
        }

        drawGraph()
    }
}
