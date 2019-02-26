//
//  ThemeManager.swift
//  MUSample
//
//  Created by Damien Noël Dubuisson on 21/02/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import Sejima

class ThemeManager {

    static func uiAppearenceMUButton() {
        for vc in [UIAppearenceFakeView.self] {
            MUButton.appearance(whenContainedInInstancesOf: [vc]).buttonBackgroundColor = .black
            MUButton.appearance(whenContainedInInstancesOf: [vc]).borderColor = .red
            MUButton.appearance(whenContainedInInstancesOf: [vc]).progressColor = .red
            MUButton.appearance(whenContainedInInstancesOf: [vc]).titleFont = .systemFont(ofSize: 14.0, weight: .bold)
            MUButton.appearance(whenContainedInInstancesOf: [vc]).cornerRadius = 0.0
            MUButton.appearance(whenContainedInInstancesOf: [vc]).borderWidth = 1.0
            MUButton.appearance(whenContainedInInstancesOf: [vc]).titleColor = .white
            MUButton.appearance(whenContainedInInstancesOf: [vc]).titleHighlightedColor = .lightGray
            MUButton.appearance(whenContainedInInstancesOf: [vc]).verticalPadding = 4.0
            MUButton.appearance(whenContainedInInstancesOf: [vc]).horizontalPadding = 20.0
        }
    }
}
