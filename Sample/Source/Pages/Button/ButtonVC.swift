//
//  TimeIndicator.swift
//  Sample
//
//  Created by Damien Noël Dubuisson on 05/03/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import UIKit
import Sejima

class ButtonVC: UIViewController {
    @IBOutlet private var button: MUButton!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let cornerRadius = CGFloat(4)
        let borderWidth = CGFloat(5)
        
        button.buttonBackgroundColor = UIColor(hex: 0x00171F)
        button.title = "Copyright © 2019"
        button.borderColor = UIColor(hex: 0xCD9C0B)
        button.progressColor = UIColor(hex: 0xCD9C0B)
        button.titleFont = .systemFont(ofSize: 24, weight: .semibold)
        button.cornerRadius = cornerRadius
        button.borderWidth = borderWidth
        button.titleColor = UIColor(hex: 0xCD9C0B)
        button.titleHighlightedColor = .white
        button.titleAlignment = .center
        button.verticalPadding = 12.0
    }
}
