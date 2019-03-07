//
//  MUSubRange.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 07/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit

internal struct MUSubRange {
    internal var range: MURange<CGFloat>
    internal var view: MUSubRangeView
    internal var leading: NSLayoutConstraint?
    internal var width: NSLayoutConstraint?

    internal init(range: MURange<CGFloat>, view: MUSubRangeView) {
        self.range = range
        self.view = view
    }
}
