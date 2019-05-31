//
//  MUCircularProgressType.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 31/05/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import Foundation

/// Define the type of the circular progress.
public enum MUCircularProgressType: Int {
    /// Circular progress with min and max value
    case determinate
    /// Circular progress with indeterminate loading
    case indeterminate
}
