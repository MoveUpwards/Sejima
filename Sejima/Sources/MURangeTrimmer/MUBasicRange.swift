//
//  MUBasicRange.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 14/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Struct with just range and title
public struct MUBasicRange {
    /// Specifies the range title.
    public let title: String
    /// Spécifies the range value.
    public let range: MURange<CGFloat>

    /// Init a MUBasicRange.
    public init(with title: String, range: MURange<CGFloat>) {
        self.title = title
        self.range = range
    }
}
