//
//  TimeIndicator.swift
//  Sample
//
//  Created by Damien Noël Dubuisson on 05/03/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import UIKit
import Sejima

class TimeIndicatorVC: UIViewController {
    @IBOutlet private var progress: MUTime!

    override func viewDidLoad() {
        super.viewDidLoad()

        progress.backgroundColor = .clear
        progress.indicatorMinValue = 0
        progress.indicatorMaxValue = 120
        progress.indicatorStartAngle = 270
        progress.indicatorEndAngle = 90
        progress.animationDuration = 0.75
        progress.indicatorLineCap = .round
        progress.color = .white
        progress.timeBackgroundColor = .green
        progress.indicatorColor = .orange
        progress.indicatorWidth = 2
        progress.roundCorners(value: 20)
        progress.format = "%.f'"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        progress.set(value: 89, animated: true)
    }
}
