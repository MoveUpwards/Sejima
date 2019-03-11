//
//  MURadarGraphData.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 07/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// Struct that represent radar graph data
public struct MURadarGraphData {
    /// Defines the radar graph values
    public let values: [CGFloat]
    /// Defines the radar graph data color
    public let color: UIColor

    /// Init a radar graph data with default values
    public init(values: [CGFloat], color: UIColor = .black) {
        self.values = values
        self.color = color
    }
}
