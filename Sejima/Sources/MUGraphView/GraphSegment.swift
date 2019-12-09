/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 A `UIView` subclass that represents a segment of data in a `GraphView`.
 */

import UIKit

/// Apple's GraphSegment
internal final class GraphSegment: UIView {

    // MARK: - Properties

    /// All values for this segments.
    private(set) var dataPoints = [SIMD3<Double>]()
    /// All colors for each points.
    private var lineColors: [UIColor] = [.red, .green, .blue]

    private let startPoint: SIMD3<Double>
    private let valueRanges: [ClosedRange<Double>]

    /// Maximum capacity of the segment.
    internal var capacity = 32
    /// If the maximum capacity is reached.
    internal var isFull: Bool {
        return dataPoints.count >= capacity
    }

    // MARK: - Initialization

    /// Init with starting values and the ranges.
    internal init(startPoint: SIMD3<Double>, valueRanges: [ClosedRange<Double>]) {
        self.startPoint = startPoint
        self.valueRanges = valueRanges

        super.init(frame: .zero)
    }

    /// Returns an object initialized from data in a given unarchiver.
    required internal init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Add new values to the graph.
    internal func add(_ values: SIMD3<Double>, colors: [UIColor]) {
        guard !isFull else { return }

        dataPoints.append(values)
        lineColors = colors
        setNeedsDisplay()
    }

    // MARK: - UIView

    /// Draws the receiver’s image within the passed-in rectangle.
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        // Fill the background.
        if let backgroundColor = backgroundColor?.cgColor {
            context.setFillColor(backgroundColor)
            context.fill(rect)
        }

        // Plot lines for the 3 sets of values.
        context.setShouldAntialias(false)
        context.translateBy(x: 0.0, y: bounds.size.height / 2.0)

        for lineIndex in 0..<3 {
            context.setStrokeColor(lineColors[lineIndex].cgColor)

            // Move to the start point for the current line.
            let value = startPoint[lineIndex]
            let point = CGPoint(x: bounds.size.width, y: scaledValue(for: lineIndex, value: value))
            context.move(to: point)

            // Draw lines between the data points.
            for (pointIndex, dataPoint) in dataPoints.enumerated() {
                let value = dataPoint[lineIndex]
                let point = CGPoint(x: bounds.size.width - CGFloat(pointIndex + 1),
                                    y: scaledValue(for: lineIndex, value: value))

                context.addLine(to: point)
            }

            context.strokePath()
        }
    }

    private func scaledValue(for lineIndex: Int, value: Double) -> CGFloat {
        // For simplicity, this assumes the range is centered on zero.
        let valueRange = valueRanges[lineIndex]
        let scale = Double(bounds.size.height) / (valueRange.upperBound - valueRange.lowerBound)
        return CGFloat(floor(value * -scale))
    }
}
