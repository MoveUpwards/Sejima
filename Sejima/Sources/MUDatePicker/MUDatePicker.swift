//
//  MUDatePicker.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 17/01/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Class that act like UIDatePicker with more customizable options.
@IBDesignable
open class MUDatePicker: MUNibView {
    @IBOutlet private var datePicker: UIDatePicker!

    // To not access Appearence of UIDatePicker, we hide selection lines
    @IBOutlet private var hideSeparatorViews: [UIView]!

    // And that our custom separator lines
    @IBOutlet private var customSeparatorViews: [UIView]!
    @IBOutlet private var customSeparatorHeightConstraints: [NSLayoutConstraint]!

    // MARK: - UIDatePicker accessable variables

    /// The minimum date that a date picker can show.
    open var minimumDate: Date? {
        get {
            return datePicker.minimumDate
        }
        set {
            datePicker.minimumDate = newValue
        }
    }

    /// The maximum date that a date picker can show.
    open var maximumDate: Date? {
        get {
            return datePicker.maximumDate
        }
        set {
            datePicker.maximumDate = newValue
        }
    }

    /// The date displayed by the date picker.
    open var selectedDate: Date {
        get {
            return datePicker.date
        }
        set {
            datePicker.date = newValue
        }
    }

    // MARK: - Public UIAppearence variables

    /// The picker’s background color.
    open override var backgroundColor: UIColor? {
        didSet {
            hideSeparatorViews.forEach { $0.backgroundColor = backgroundColor }
        }
    }

    /// Define the text's color.
    @IBInspectable open dynamic var textColor: UIColor = .black {
        didSet {
            datePicker.setValue(textColor, forKey: "textColor")
            customSeparatorViews.forEach { $0.backgroundColor = textColor }
        }
    }

    /// Define the separator's height.
    @IBInspectable open dynamic var separatorHeight: CGFloat = 1.0 {
        didSet {
            customSeparatorHeightConstraints.forEach { $0.constant = separatorHeight }
        }
    }

    // MARK: - Life cycle functions

    /// Default setup to load the view from a xib file.
    open override func xibSetup() {
        super.xibSetup()

        datePicker.setValue(false, forKey: "highlightsToday")
    }
}
