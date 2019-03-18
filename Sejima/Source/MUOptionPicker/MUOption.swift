//
//  MUOption.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 18/01/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit.UIImageView
import UIKit.UILabel

/// Class that act like an UISwitch and can be group.
internal class MUOption: MUNibView, MURadioButtonGroupProtocol {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var label: UILabel!

    // MARK: - MURadioButtonProtocol

    /// The object that acts as the delegate of the option button.
    internal weak var delegate: MURadioButtonDelegate?

    /// The option button's selected state.
    internal var selected: Bool = false {
        didSet {
            imageView.tintColor = selected ? selectedColor : unselectedColor
            label.textColor = selected ? selectedColor : unselectedColor
            if selected {
                delegate?.didSelect(button: self)
            }
        }
    }

    private var selectedColor = UIColor.white
    private var unselectedColor = UIColor.darkGray

    // MARK: - Life cycle

    /// Initializes and returns a newly allocated MUOption.
    internal convenience init(data: MUOptionData) {
        self.init()

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:))))

        imageView.image = data.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = unselectedColor
        label.text = data.text
        label.textColor = unselectedColor
    }

    @objc
    private func handleTap(sender: UITapGestureRecognizer) {
        selected = true
    }

    // MARK: - Set functions

    /// Set a title's font
    @discardableResult
    internal func set(font: UIFont) -> MUOption {
        label.font = font
        return self
    }

    // Set a selected color
    @discardableResult
    internal func set(selectedColor: UIColor) -> MUOption {
        self.selectedColor = selectedColor
        return self
    }

    // Set an unselected color
    @discardableResult
    internal func set(unselectedColor: UIColor) -> MUOption {
        self.unselectedColor = unselectedColor
        return self
    }
}
