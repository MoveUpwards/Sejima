//
//  MUWeakProxy.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 01/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import Foundation

/// A class that create a weak target to avoid retain cycles.
final public class MUWeakProxy: NSObject {
    private weak var target: NSObjectProtocol?

    /// Initialize a new object with the target to retain weakly.
    public init(_ target: NSObjectProtocol) {
        self.target = target
        super.init()
    }

    /// Returns a Boolean value that indicates whether the receiver implements or inherits
    /// a method that can respond to a specified message.
    override public func responds(to aSelector: Selector) -> Bool {
        guard let target = target else {
            return super.responds(to: aSelector)
        }
        return target.responds(to: aSelector)
    }

    /// Returns the object to which unrecognized messages should first be directed.
    override public func forwardingTarget(for aSelector: Selector) -> Any? {
        return target
    }
}
