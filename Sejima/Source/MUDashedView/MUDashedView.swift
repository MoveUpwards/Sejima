//
//  MUDashedView.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 16/09/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import UIKit.UIView

open class MUDashedView: UIView {

    /// Specifies the dash's value color.
    @IBInspectable open dynamic var dashColor: UIColor = .clear {
        didSet {
            layoutSubviews()
        }
    }

    /// Define the dash's width.
    @IBInspectable open dynamic var dashWidth: Float = 1.0 {
        didSet {
            layoutSubviews()
        }
    }

    /// Define the gap's width.
    @IBInspectable open dynamic var gapWidth: Float = 1.0 {
        didSet {
            layoutSubviews()
        }
    }

    /// Define the dash line's orientation.
    open var orientation = NSLayoutConstraint.Axis.horizontal {
        didSet {
            layoutSubviews()
        }
    }

    /// Lays out subviews.
    override open func layoutSubviews() {
        super.layoutSubviews()

        // Recreate the dashed line each time the view resize.
        layer.sublayers?.removeAll()
        addDash([NSNumber(value: dashWidth), NSNumber(value: gapWidth)], color: dashColor, orientation: orientation)
    }
}
