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
     NSLayoutConstraint with default values to reduce init function length in most cases

     - parameter view1: Any
     - parameter attr1: NSLayoutConstraint.Attribute
     - parameter relation: CGFloat
     - parameter view2: Any? Will be view1 if nil
     - parameter attr2: NSLayoutConstraint.Attribute? Will be attr1 if nil
     - parameter multiplier: CGFloat Will be 1.0 if missing
     - parameter c: CGFloat Will be 0.0 if missing
     - returns: NSLayoutConstraint
     */
    internal convenience init(item view1: Any,
                              attribute attr1: NSLayoutConstraint.Attribute,
                              relatedBy relation: NSLayoutConstraint.Relation,
                              toItem view2: Any?,
                              attribute attr2: NSLayoutConstraint.Attribute?,
                              multiplier: CGFloat = 1.0,
                              constant c: CGFloat = 0.0) {
        self.init(item: view1,
                  attribute: attr1,
                  relatedBy: relation,
                  toItem: view2 ?? view1,
                  attribute: attr2 ?? attr1,
                  multiplier: multiplier,
                  constant: c)
    }

    /**
     Change the multiplier variable of a specific constraint

     - parameter multiplier:     The new multiplier value.
     - parameter constraint:     The constraint to change.
     - returns:                  The new constraint if possible.
     */
    public static func change(multiplier: CGFloat, for constraint: NSLayoutConstraint) -> NSLayoutConstraint {
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
