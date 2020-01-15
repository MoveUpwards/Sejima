//
//  TimeIndicator.swift
//  Sample
//
//  Created by Damien Noël Dubuisson on 05/03/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import UIKit
import Sejima

enum CategoryEnum: String, CaseIterable {
    case u13, u15, u17, u19, u20, senior
}

class SliderVC: UIViewController {
    @IBOutlet private var slider: MUSlider!

    override func viewDidLoad() {
        super.viewDidLoad()

        slider.cellWidth = 80
        slider.values = CategoryEnum.allCases.map({ $0.rawValue })
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
