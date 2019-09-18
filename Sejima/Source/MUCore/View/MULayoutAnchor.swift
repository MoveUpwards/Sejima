//
//  MULayoutAnchor.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 13/09/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit.NSLayoutAnchor

extension NSLayoutXAxisAnchor {
    /// Add an active constraint
    public func addConstraint(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0.0) {
        constraint(equalTo: anchor, constant: constant).isActive = true
    }
}

extension NSLayoutYAxisAnchor {
    /// Add an active constraint
    public func addConstraint(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0.0) {
        constraint(equalTo: anchor, constant: constant).isActive = true
    }
}

extension NSLayoutDimension {
    /// Add an active constraint
    public func addConstraint(to anchor: NSLayoutDimension, multiplier: CGFloat = 1.0) {
        constraint(equalTo: anchor, multiplier: multiplier).isActive = true
    }
}
