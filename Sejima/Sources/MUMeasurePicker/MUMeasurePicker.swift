//
//  MUMeasurePicker.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 17/01/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Delegate protocol for MUMeasurePicker objects.
@objc public protocol MUMeasurePickerDelegate: class {
    /// Will trigger each time the value change.
    func didUpdate(measurePicker: MUMeasurePicker, value: Int)
    /// Will trigger each time the unit change.
    func didUpdate(measurePicker: MUMeasurePicker, unit: String)
}

/// Class that define two picker for value and unit.
@IBDesignable
open class MUMeasurePicker: MUNibView {
    @IBOutlet private var valuePicker: UIPickerView!
    @IBOutlet private var unitPicker: UIPickerView!

    @IBOutlet private var horizontalConstraints: [NSLayoutConstraint]!
    @IBOutlet private var centerConstraint: NSLayoutConstraint!

    @IBOutlet private var separatorViews: [UIView]!
    @IBOutlet private var separatorHeightConstraints: [NSLayoutConstraint]!

    /// The object that acts as the delegate of the measure picker.
    @IBOutlet public weak var delegate: MUMeasurePickerDelegate? // swiftlint:disable:this private_outlet strong_iboutlet line_length

    // MARK: - Public UIAppearence variables

    /// Define the text's color.
    @IBInspectable open dynamic var textColor: UIColor = .black {
        didSet {
            separatorViews.forEach { $0.backgroundColor = textColor }
            valuePicker.reloadAllComponents()
            unitPicker.reloadAllComponents()
        }
    }

    /// Define the text's font.
    @objc open dynamic var textFont: UIFont = .systemFont(ofSize: 16.0, weight: .regular) {
        didSet {
            valuePicker.reloadAllComponents()
            unitPicker.reloadAllComponents()
        }
    }

    /// Define the separator's height.
    @IBInspectable open dynamic var separatorHeight: CGFloat = 2.0 {
        didSet {
            separatorHeightConstraints.forEach { $0.constant = separatorHeight }
        }
    }

    /// Define the picker's horizontal padding.
    @IBInspectable open dynamic var contentHorizontalPadding: CGFloat = 8.0 {
        didSet {
            horizontalConstraints.forEach { $0.constant = contentHorizontalPadding }
        }
    }

    /// Define the padding between the two pickers.
    @IBInspectable open dynamic var centerSpacing: CGFloat = 8.0 {
        didSet {
            centerConstraint.constant = centerSpacing
        }
    }

    // MARK: - Value Picker data

    /// Define the minimum value.
    @IBInspectable open dynamic var minValue: Int = 0 {
        didSet {
            valuePicker.reloadAllComponents()
        }
    }

    /// Define the maximum value.
    @IBInspectable open dynamic var maxValue: Int = 100 {
        didSet {
            valuePicker.reloadAllComponents()
        }
    }

    /// Define the current value.
    @IBInspectable open dynamic var currentValue: Int {
        get {
            return minValue + valuePicker.selectedRow(inComponent: 0)
        }
        set {
            guard newValue >= minValue, newValue <= maxValue else { return }
            valuePicker.selectRow(newValue - minValue, inComponent: 0, animated: false)
        }
    }

    // MARK: - Unit Picker data

    /// Define the list of available units.
    open var units: [String] = [] {
        didSet {
            unitPicker.reloadAllComponents()
        }
    }

    /// Define the current unit index.
    @IBInspectable open dynamic var currentUnitIndex: Int {
        get {
            return unitPicker.selectedRow(inComponent: 0)
        }
        set {
            unitPicker.selectRow(newValue, inComponent: 0, animated: false)
        }
    }

    // MARK: - MUMeasureData

    /// Set values and units from MUMeasureData.
    open func set(_ data: MUMeasureData) {
        minValue = data.min
        maxValue = data.max
        units = data.units
    }

    // MARK: - Private functions

    private func customLabel() -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.font = textFont
        label.textAlignment = .center
        return label
    }
}

extension MUMeasurePicker: UIPickerViewDataSource {
    /// Called by the picker view when it needs the number of components.
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    /// Called by the picker view when it needs the number of rows for a specified component.
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == valuePicker {
            return maxValue - minValue + 1 // To include last value
        } else if pickerView == unitPicker {
            return units.count
        }

        return 0
    }
}

extension MUMeasurePicker: UIPickerViewDelegate {
    /// Called by the picker view when it needs the view to use for a given row in a given component.
    public func pickerView(_ pickerView: UIPickerView,
                           viewForRow row: Int,
                           forComponent component: Int,
                           reusing view: UIView?) -> UIView {
        let label = customLabel()

        if pickerView == valuePicker {
            label.text = "\(minValue + row)"
        } else if pickerView == unitPicker {
            label.text = units[row]
        }

        return label
    }

    /// Called by the picker view when the user selects a row in a component.
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == valuePicker {
            delegate?.didUpdate(measurePicker: self, value: minValue + row)
        } else {
            delegate?.didUpdate(measurePicker: self, unit: units[row])
        }
    }
}
