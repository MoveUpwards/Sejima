//
//  MUPinCodeCell.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 05/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// A view that define a unique cell in the MUPinCode
final internal class MUPinCodeCell: MUNibView {
    @IBOutlet private var label: UILabel!

    /// Set the font of the label
    internal func set(font: UIFont) {
        label.font = font
    }

    /// Set the text of the label
    internal func set(text: String) {
        label.text = text
    }
}
