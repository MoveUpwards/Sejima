//
//  MURadioButtonGroup.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 04/01/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import Foundation

/// Delegate protocol for MURadioButtonProtocol objects.
@objc public protocol MURadioButtonDelegate: class {
    /// Will trigger each time a radio button is selected.
    func didSelect(button: MURadioButtonProtocol)
    /// Will trigger each time a radio button is unselected.
    func didUnselect(button: MURadioButtonProtocol)
}

/// Protocol to define a radio button that can be added to the MURadioButtonGroup
@objc public protocol MURadioButtonProtocol: class {
    /// The object that acts as the delegate of the radio button.
    var delegate: MURadioButtonDelegate? { get set }
    /// The radio button's selected state.
    var selected: Bool { get set }
}

/// Class that act like a group of MURadioButtonProtocol.
@IBDesignable
open class MURadioButtonGroup {
    // All the buttons of this group.
    private var buttons: [MURadioButtonProtocol] = []

    /// The object that acts as the delegate of the radio button group.
    @IBOutlet public weak var delegate: MURadioButtonDelegate? // swiftlint:disable:this private_outlet strong_iboutlet

    /// Initializes and returns a newly allocated MURadioButtonGroup with optional array of MURadioButtonProtocol.
    public init(with group: [MURadioButtonProtocol] = []) {
        buttons = group
        buttons.forEach { $0.delegate = self }
    }

    /// Add a MURadioButtonProtocol to the end of current list.
    open func add(button: MURadioButtonProtocol) {
        button.delegate = self
        button.selected = false
        buttons.append(button)
    }

    /// Select the MURadioButtonProtocol at specific index. It will unselect the current one if needed.
    open func select(index: Int) {
        guard index >= 0, index < buttons.count else {
            return
        }
        buttons[index].selected = true
    }
}

extension MURadioButtonGroup: MURadioButtonDelegate {
    /// Will trigger each time a radio button is selected.
    public func didSelect(button: MURadioButtonProtocol) {
        buttons.forEach { $0 !== button ? $0.selected = false : () }
        delegate?.didSelect(button: button)
    }

    /// Will trigger each time a radio button is unselected.
    public func didUnselect(button: MURadioButtonProtocol) {
        delegate?.didUnselect(button: button) // Called only if all buttons are unselected
    }
}
