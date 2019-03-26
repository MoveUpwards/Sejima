//
//  MUMeasurePicker.swift
//  MUComponent
//
//  Created by Damien Noël Dubuisson on 17/01/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit

public protocol MUMeasurePickerDelegate: class {
    func didUpdateValue(picker: MUMeasurePicker, value: Int)
    func didUpdateUnit(picker: MUMeasurePicker, unit: String)
}

open class MUMeasurePicker: MUNibView {
    @IBOutlet private weak var valuePicker: UIPickerView!
    @IBOutlet private weak var unitPicker: UIPickerView!

    @IBOutlet private var horizontalConstraints: [NSLayoutConstraint]!
    @IBOutlet private var centerConstraint: NSLayoutConstraint!

    @IBOutlet private var separatorViews: [UIView]!
    @IBOutlet private var separatorHeightConstraints: [NSLayoutConstraint]!

    open weak var delegate: MUMeasurePickerDelegate?

    public struct Data {
        public let min: Int
        public let max: Int
        public let units: [String]

        public init(min: Int, max: Int, units: [String]) {
            self.min = min
            self.max = max
            self.units = units
        }
    }

    // MARK: - Public UIAppearence variables

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var textColor: UIColor = .black {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the inset of the background and chart
    @objc open dynamic var textFont: UIFont = .systemFont(ofSize: 16, weight: .regular) {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var separatorHeight: CGFloat = 2 {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var contentHorizontalPadding: CGFloat = 8.0 {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var centerSpacing: CGFloat = 8.0 {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    // MARK: - Value Picker data

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var minValue: Int = 1 {
        didSet {
            valuePicker.reloadAllComponents()
        }
    }

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var maxValue: Int = 100 {
        didSet {
            valuePicker.reloadAllComponents()
        }
    }

    /// Define the inset of the background and chart
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

    /// Define the inset of the background and chart
    open var units: [String] = [] {
        didSet {
            unitPicker.reloadAllComponents()
        }
    }

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var currentUnitIndex: Int {
        get {
            return unitPicker.selectedRow(inComponent: 0)
        }
        set {
            unitPicker.selectRow(newValue, inComponent: 0, animated: false)
        }
    }

    // MARK: - Data

    open func set(data: Data) {
        minValue = data.min
        maxValue = data.max
        units = data.units
    }

    // MARK: - Life cycle functions

    override open func layoutSubviews() {
        super.layoutSubviews()

        separatorViews.forEach { $0.backgroundColor = textColor }
        separatorHeightConstraints.forEach { $0.constant = separatorHeight }
    }

    open override func updateConstraints() {
        super.updateConstraints()

        horizontalConstraints.forEach { $0.constant = contentHorizontalPadding }
        centerConstraint.constant = centerSpacing
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
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

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

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == valuePicker {
            delegate?.didUpdateValue(picker: self, value: minValue + row)
        } else {
            delegate?.didUpdateUnit(picker: self, unit: units[row])
        }
    }
}
