//
//  MUPinCodeCell.swift
//  MUComponent
//
//  Created by Damien Noël Dubuisson on 05/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit

internal class MUPinCodeCell: MUNibView {
    @IBOutlet private weak var label: UILabel!

    internal func set(font: UIFont) {
        label.font = font
    }

    internal func set(text: String) {
        label.text = text
    }
}
