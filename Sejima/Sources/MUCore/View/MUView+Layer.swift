//
//  MUView+Layer.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 16/09/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit.UIView

extension UIView {
    /// Round the specified corners
    public func roundCorners(_ corners: UIRectCorner = .allCorners, value: CGFloat) {
        guard corners != .allCorners else {
            layer.cornerRadius = value
            return
        }

        guard #available(iOS 11.0, *) else {
            let path = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: value, height: value))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = bounds
            maskLayer.path = path.cgPath
            layer.mask = maskLayer

            return
        }

        layer.cornerRadius = value
        layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
    }
}
