//
//  MUGraphView.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 13/05/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//
//  See: https://developer.apple.com/library/archive/samplecode/MotionGraphs/Introduction/Intro.html#//apple_ref/doc/uid/DTS40012333
//

import UIKit
import simd

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

    /// The value's range on X axis.
    public var yRange: ClosedRange<Double> = -4.0...4.0 {
        didSet {
            graphView.valueRanges[1] = yRange
        }
    }

    /// The value's range on X axis.
    public var zRange: ClosedRange<Double> = -4.0...4.0 {
        didSet {
            graphView.valueRanges[2] = zRange
        }
    }

    // MARK: Update methods

    /// Add a new values' entry on the left of the view.
    public func add(x: Double, y: Double, z: Double) {
        graphView.add(double3([x, y, z]))
    }
}
