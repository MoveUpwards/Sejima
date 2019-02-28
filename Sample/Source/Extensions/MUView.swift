//
//  MUView.swift
//  Sample
//
//  Created by Loïc GRIFFIE on 27/02/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import UIKit

extension UIView {
    public func addGradient(_ colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
