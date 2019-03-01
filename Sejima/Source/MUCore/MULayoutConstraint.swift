//
//  MULayoutConstraint.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 01/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    /**
     Change the multiplier variable of a specific constraint

     - parameter multiplier:     The new multiplier value.
     - parameter constraint:     The constraint to change.
     - returns:                  The new constraint if possible.
     */
    internal static func change(multiplier: CGFloat, for constraint: NSLayoutConstraint) -> NSLayoutConstraint {
        guard let constraintItem = constraint.firstItem else {
            return constraint
        }

        let newConstraint = NSLayoutConstraint(
            item: constraintItem,
            attribute: constraint.firstAttribute,
            relatedBy: constraint.relation,
            toItem: constraint.secondItem,
            attribute: constraint.secondAttribute,
            multiplier: multiplier,
            constant: constraint.constant)
        newConstraint.priority = constraint.priority

        NSLayoutConstraint.deactivate([constraint])
        NSLayoutConstraint.activate([newConstraint])

        return newConstraint
    }
}
