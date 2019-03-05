//
//  MUSegmentIndicatorView.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 05/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// View that define the current indicator.
final internal class MUSegmentIndicatorView: UIView {
    private let segmentMaskView = UIView()

    /// The view’s Core Animation layer used for rendering.
    internal var layerMask: CALayer {
        return segmentMaskView.layer
    }

    /// The button’s corner radius.
    internal var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            segmentMaskView.layer.cornerRadius = cornerRadius
        }
    }

    /// The frame rectangle, which describes the view’s location and size in its superview’s coordinate system.
    override internal var frame: CGRect {
        didSet {
            segmentMaskView.frame = frame
        }
    }

    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override internal init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    /// Returns an object initialized from data in a given unarchiver.
    required internal init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    /// Initializes and returns a newly allocated view object with a zero frame rectangle.
    convenience internal init() {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func setup() {
        layer.masksToBounds = true
        addSubview(segmentMaskView)
        segmentMaskView.layer.masksToBounds = true
        segmentMaskView.backgroundColor = .black
    }
}
