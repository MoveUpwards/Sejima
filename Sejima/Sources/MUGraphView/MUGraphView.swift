//
//  MUGraphView.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 13/05/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//
//swiftlint:disable:next line_length
//  See: https://developer.apple.com/library/archive/samplecode/MotionGraphs/Introduction/Intro.html#//apple_ref/doc/uid/DTS40012333
//

import UIKit
import Neumann

/// Class that act like Apple's GraphView with more customizable options.
public final class MUGraphView: MUNibView {
    @IBOutlet private var graphView: GraphView!

    /// The color on X axis.
    @IBInspectable public dynamic var xColor: UIColor = .red {
        didSet {
            graphView.lineColors[0] = xColor
        }
    }

    /// The color on Y axis.
    @IBInspectable public dynamic var yColor: UIColor = .green {
        didSet {
            graphView.lineColors[1] = yColor
        }
    }

    /// The color on Z axis.
    @IBInspectable public dynamic var zColor: UIColor = .blue {
        didSet {
            graphView.lineColors[2] = zColor
        }
    }

    /// The value's range on X axis.
    public var xRange: ClosedRange<Double> = -4.0...4.0 {
        didSet {
            graphView.valueRanges[0] = xRange
        }
    }

    /// The value's range on Y axis.
    public var yRange: ClosedRange<Double> = -4.0...4.0 {
        didSet {
            graphView.valueRanges[1] = yRange
        }
    }

    /// The value's range on Z axis.
    public var zRange: ClosedRange<Double> = -4.0...4.0 {
        didSet {
            graphView.valueRanges[2] = zRange
        }
    }

    /// The color on the middle axis.
    @IBInspectable public dynamic var mainAxisColor: UIColor = .lightGray

    /// The color on the others axis.
    @IBInspectable public dynamic var othersAxisColor: UIColor = .darkGray

    // MARK: Update methods

    /// Add a new values' entry on the left of the view.
    public func add(x: Double, y: Double, z: Double) {
        graphView.add([x, y, z])
    }

    // MARK: UIView overrides

    public override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()

        // Configure context settings.
        context?.saveGState()
        context?.setShouldAntialias(false)
        context?.translateBy(x: 0.0, y: bounds.size.height / 2.0)

        // Add lines to the context.
        let gridLineSpacing = bounds.size.height / 8.0
        for index in -3...3 {
            // Skip the center line.
            guard index != 0 else { continue }

            let position = floor(gridLineSpacing * CGFloat(index))
            context?.move(to: CGPoint(x: 0.0, y: position))
            context?.addLine(to: CGPoint(x: bounds.size.width, y: position))
        }

        // Stroke the lines.
        context?.setStrokeColor(othersAxisColor.cgColor)
        context?.strokePath()

        // Add and stroke the center line.
        context?.move(to: .zero)
        context?.addLine(to: CGPoint(x: bounds.size.width, y: 0.0))

        context?.setStrokeColor(mainAxisColor.cgColor)
        context?.strokePath()

        // Restore the context state.
        context?.restoreGState()
    }
}
