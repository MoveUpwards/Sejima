//
//  MUView+Dash.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 17/09/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import UIKit.UIView

extension UIView {
    public func addDash(_ dashPattern: [NSNumber],
                        color: UIColor,
                        orientation: NSLayoutConstraint.Axis = .horizontal) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = orientation == .horizontal ? frame.height : frame.width
        shapeLayer.lineDashPattern = dashPattern

        let path = CGMutablePath()
        switch orientation {
        case .horizontal:
            let middleHeight = frame.height * 0.5
            path.addLines(between: [CGPoint(x: 0.0, y: middleHeight), CGPoint(x: frame.width, y: middleHeight)])
        case .vertical:
            let middleWidth = frame.width * 0.5
            path.addLines(between: [CGPoint(x: middleWidth, y: 0.0), CGPoint(x: middleWidth, y: frame.height)])
        @unknown default:
            path.addLines(between: [.zero, .zero])
        }

        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
}
