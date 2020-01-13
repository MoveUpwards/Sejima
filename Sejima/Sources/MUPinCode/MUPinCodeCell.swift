//
//  MUPinCodeCell.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 05/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// A view that define a unique cell in the MUPinCode
final internal class MUPinCodeCell: MUNibView {
    @IBOutlet private var label: UILabel!

    private var timer: Timer?
    private var emptyCharacter: String = "•"
    private var secureCharacter: String?

    /// Set label secured character
    @discardableResult
    @available(iOS 10.0, *)
    internal func set(secureCharacter: String?) -> Self {
        self.secureCharacter = secureCharacter
        return self
    }

    /// Set label empty character
    @discardableResult
    internal func set(emptyCharacter: String) -> Self {
        self.emptyCharacter = emptyCharacter
        return self
    }

    /// Set the font of the label
    @discardableResult
    internal func set(font: UIFont) -> Self {
        label.font = font
        return self
    }

    /// Set the text of the label
    @discardableResult
    internal func set(text: String) -> Self {
        label.text = text

        if #available(iOS 10.0, *) {
            if secureCharacter != nil {
                timer?.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
                    self?.label.text = self?.secureCharacter
                }
            }
        }
        return self
    }

    /// Set the text of the label
    @discardableResult
    internal func empty() -> Self {
        label.text = emptyCharacter

        if #available(iOS 10.0, *) {
            if secureCharacter != nil {
                timer?.invalidate()
            }
        }
        return self
    }
}
