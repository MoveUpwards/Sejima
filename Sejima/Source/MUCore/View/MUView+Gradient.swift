//
//  MUView+Gradient.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 13/09/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit.UIView

extension UIView {
    /// Add gradient colors in sublayer at index 0.
    public func addGradient(_ name: String = "GradientLayer",
                            with colors: [UIColor],
                            startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0),
                            endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0),
                            type: CAGradientLayerType = .axial) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map({ $0.cgColor })
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.name = name
        gradientLayer.type = type
        guard let old = layer.sublayers?.filter({ $0.name == name }).first else {
            layer.insertSublayer(gradientLayer, at: 0)
            return
        }

        layer.replaceSublayer(old, with: gradientLayer)
    }
}
