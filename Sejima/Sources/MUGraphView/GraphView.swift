/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 A `UIView` subclass used to graph the values retreived from sensors. The graph is made up of segments represeneted
    by child views to avoid having to redraw the whole graph with every update.
 */

import UIKit

/// Apple's GraphView
internal final class GraphView: UIView {

    // MARK: Properties

    private var segments = [GraphSegment]()
    private var currentSegment: GraphSegment? {
        return segments.last
    }

    /// The current colors to inject in the add function.
    internal var lineColors: [UIColor] = [.red, .green, .blue]
    /// The current value's ranges.
    internal var valueRanges = [-4.0...4.0, -4.0...4.0, -4.0...4.0]

    // MARK: Initialization

    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override internal init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    /// Returns an object initialized from data in a given unarchiver.
    required internal init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    private func commonInit() {
        backgroundColor = .clear
    }

    // MARK: Update methods

    /// Add new values to the graph.
    internal func add(_ values: SIMD3<Double>) {
        // Move all the segments horizontally.
        for segment in segments {
            segment.center.x += 1.0
        }

        // Add a new segment there are no segments or if the current segment is full.
        if segments.isEmpty {
            addSegment()
        } else if let segment = currentSegment, segment.isFull {
            addSegment()
            purgeSegments()
        }

        // Add the values to the current segment.
        currentSegment?.add(values, colors: lineColors)
    }

    // MARK: Private convenience methods

    private func addSegment() {
        // Determine the start point for the next segment.
        let startPoint: SIMD3<Double> = currentSegment?.dataPoints.last ?? [0.0, 0.0, 0.0]

        // Create and store a new segment.
        let segment = GraphSegment(startPoint: startPoint, valueRanges: valueRanges)
        let segmentWidth = CGFloat(segment.capacity)
        segments.append(segment)

        // Add the segment to the view.
        segment.backgroundColor = backgroundColor
        segment.frame = CGRect(x: -segmentWidth, y: 0.0, width: segmentWidth, height: bounds.size.height)
        addSubview(segment)
    }

    private func purgeSegments() {
        segments = segments.filter { segment in
            if segment.frame.origin.x < bounds.size.width {
                // Include the segment if it's still visible.
                return true
            } else {
                // Remove the segment before excluding it from the filtered array.
                segment.removeFromSuperview()
                return false
            }
        }
    }
}
