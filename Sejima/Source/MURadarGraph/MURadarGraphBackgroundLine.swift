//
//  MURadarGraphBackgroundLine.swift
//  SejimaTests
//
//  Created by Loïc GRIFFIE on 07/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// Class that defines radar graph bachground line layout.
public final class MURadarGraphBackgroundLine: NSObject {
    /// Define the radar graph's background line fill color.
    public var fillColor: UIColor = .clear
    /// Define the radar graph's background line stroke color.
    public var strokeColor: UIColor = .white
    /// Define the radar graph's background line thickness.
    public var strokeThickness: CGFloat = 0.0

    /// Init radar graph background line style with default values.
    public convenience init(fillColor: UIColor = .clear,
                            strokeColor: UIColor = .white,
                            strokeThickness: CGFloat = 0.0) {
        self.init()
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.strokeThickness = strokeThickness
    }
}
