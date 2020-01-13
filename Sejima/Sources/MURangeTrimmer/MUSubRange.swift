//
//  MUSubRange.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 07/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Struct that define a sub range.
internal struct MUSubRange {
    /// Range location and length of the sub range
    internal var range: MURange<CGFloat>
    /// View for the sub range
    internal var view: MUSubRangeView
    /// Leading constraint of the sub range
    internal var leading: NSLayoutConstraint?
    /// Trailing constraint of the sub range
    internal var width: NSLayoutConstraint?

    /// Init that create a new MUSubRange
    internal init(range: MURange<CGFloat>, view: MUSubRangeView) {
        self.range = range
        self.view = view
    }
}
