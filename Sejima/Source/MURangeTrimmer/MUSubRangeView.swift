//
//  MUSubRangeView.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 02/02/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit

internal final class MUSubRangeView: MUNibView {
    @IBOutlet private var leftPickerView: UIView!
    @IBOutlet private var leftPickerIndicator: UIView!
    @IBOutlet private var leftPickerLeading: NSLayoutConstraint!
    @IBOutlet private var leftPickerWidth: NSLayoutConstraint!

    @IBOutlet private var rightPickerView: UIView!
    @IBOutlet private var rightPickerIndicator: UIView!
    @IBOutlet private var rightPickerTrailing: NSLayoutConstraint!
    @IBOutlet private var rightPickerWidth: NSLayoutConstraint!

    @IBOutlet private var titleView: UIView!
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var textFieldBottom: NSLayoutConstraint!

    // MARK: - Private variables

    private let verticalPadding = CGFloat(2.0) // TextField top and bottom

    // MARK: - Internal variables

    internal var pickerWidth: CGFloat = 8.0 {
        didSet {
            leftPickerWidth.constant = pickerWidth
            rightPickerWidth.constant = pickerWidth
        }
    }

    internal var indicatorColor: UIColor = .black {
        didSet {
            leftPickerIndicator.backgroundColor = indicatorColor
            rightPickerIndicator.backgroundColor = indicatorColor
        }
    }

    internal var borderWidth: CGFloat = 0.0 {
        didSet {
            updateBorderWidth()
        }
    }

    internal var borderColor: UIColor = .white {
        didSet {
            layer.borderColor = borderColor.cgColor
            leftPickerView.backgroundColor = borderColor
            rightPickerView.backgroundColor = borderColor
            titleView.backgroundColor = borderColor
        }
    }

    internal var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            titleView.layer.cornerRadius = cornerRadius
        }
    }

    internal var title: String {
        get {
            return textField.text ?? ""
        }
        set {
            textField.text = newValue
        }
    }

    internal var titlePadding: CGFloat = 20.0 {
        didSet {
            updatePadding()
        }
    }

    internal var titleColor: UIColor = .black {
        didSet {
            textField.textColor = titleColor
        }
    }

    internal var titleFont: UIFont = .systemFont(ofSize: 16.0) {
        didSet {
            textField.font = titleFont
        }
    }

    internal var keyboardAppearance: UIKeyboardAppearance = .default {
        didSet {
            textField.keyboardAppearance = keyboardAppearance
        }
    }

    internal var caretColor: UIColor = .clear {
        didSet {
            textField.tintColor = caretColor
        }
    }

    // MARK: - Private functions

    private func updatePadding() {
        let paddingView = UIView(frame: CGRect(origin: .zero,
                                               size: CGSize(width: titlePadding, height: textField.bounds.height)))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.rightView = paddingView
        textField.rightViewMode = .always
    }

    private func updateBorderWidth() {
        layer.borderWidth = borderWidth
        leftPickerLeading.constant = borderWidth
        rightPickerTrailing.constant = borderWidth
        textFieldBottom.constant = borderWidth + verticalPadding
    }

    // MARK: - Life cycle functions

    /// Default setup to load the view from a xib file.
    override public func xibSetup() {
        super.xibSetup()

        layer.masksToBounds = true
    }

    /// Updates constraints for the view.
    override func updateConstraints() {
        super.updateConstraints()

        leftPickerIndicator.layer.cornerRadius = leftPickerIndicator.bounds.width * 0.5
        rightPickerIndicator.layer.cornerRadius = leftPickerIndicator.bounds.width * 0.5

        textFieldBottom.constant = borderWidth + verticalPadding
    }

    /// The natural size for the receiving view, considering only properties of the view itself.
    override public var intrinsicContentSize: CGSize {
        return .zero
    }

    /** Returns the farthest descendant of the receiver in the view hierarchy
     (including itself) that contains a specified point. **/
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard super.hitTest(point, with: event) is UITextField else { return nil }
        return textField // You can adapt it if more than one object respond to touch
    }
}

// MARK: - Delegate functions

extension MUSubRangeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
