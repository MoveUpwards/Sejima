//
//  MUQuad+UIView.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 12/09/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit.UIView

extension UIView {
    /// Transform view to fit givent Quad.
    public func transformToFit(quad: MUQuad) {
        layer.transform = CATransform3DIdentity // Keeps current transform from interfering
        frame = quad.boundingBox

        let transform = CATransform3D(toFit: quad - frame.origin, from: bounds)

        //  To account for anchor point, we must translate (pos), transform, translate (neg)
        let anchorOffset = CGPoint(x: layer.position.x - frame.origin.x, y: layer.position.y - frame.origin.y)
        let transPos = CATransform3DMakeTranslation(anchorOffset.x, anchorOffset.y, 0.0)
        let transNeg = CATransform3DMakeTranslation(-anchorOffset.x, -anchorOffset.y, 0.0)
        let fullTransform = CATransform3DConcat(CATransform3DConcat(transPos, transform), transNeg)

        //  Now we set our transform
        layer.transform = fullTransform
    }
}
