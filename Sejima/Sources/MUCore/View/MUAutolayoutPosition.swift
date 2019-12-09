//
//  MUAutolayoutPosition.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 13/09/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

//swiftlint:disable comma

/// All possible position for autolayout
public enum MUAutolayoutPosition {
    // 9 positions to set 2 autolayout constraints in on time
    case topLeft,       topCenter,      topRight
    case leftCenter,    center,         rightCenter
    case bottomLeft,    bottomCenter,   bottomRight

    // 6 positions to set only 1 autolayout constraint
    case top, left, right, bottom, centerX, centerY
}

//swiftlint:enable comma
