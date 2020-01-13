//
//  MUOptionPicker.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 18/01/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Class that define a picker with custom option objects.
@IBDesignable
open class MUOptionPicker: MUNibView {
    @IBOutlet private var stackView: UIStackView!

    @IBOutlet private var horizontalConstraints: [NSLayoutConstraint]!

    private let buttonGroup = MURadioButtonGroup()

    /// Get the current index or nil if none.
    public private(set) var selectedIndex: Int? // Read only to get selected value

    // MARK: - Public UIAppearence variables

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var selectedColor: UIColor = .white {
        didSet {
            stackView.arrangedSubviews.compactMap({ $0 as? MUOption }).forEach { option in
                option.set(selectedColor: selectedColor)
            }
        }
    }

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var unselectedColor: UIColor = .darkGray {
        didSet {
            stackView.arrangedSubviews.compactMap({ $0 as? MUOption }).forEach { option in
                option.set(unselectedColor: unselectedColor)
            }
        }
    }

    /// Define the inset of the background and chart
    @objc open dynamic var textFont: UIFont = .systemFont(ofSize: 16.0, weight: .regular) {
        didSet {
            stackView.arrangedSubviews.compactMap({ $0 as? MUOption }).forEach { option in
                option.set(font: textFont)
            }
        }
    }

    /// The distance in points between the adjacent edges of the option button’s views.
    @IBInspectable open dynamic var spacing: CGFloat = 0.0 {
        didSet {
            stackView.spacing = spacing
        }
    }

    /// Define the left and right padding.
    @IBInspectable open dynamic var contentHorizontalPadding: CGFloat = 20.0 {
        didSet {
            horizontalConstraints.forEach { $0.constant = contentHorizontalPadding }
        }
    }

    // MARK: - Data

    /// Add a MURadioButtonProtocol to the end of current list.
    open func add(datas: [MUOptionData]) {
        datas.enumerated().forEach { index, data in
            let option = MUOption(data: data)
            option.tag = index
            option.set(selectedColor: selectedColor)
            option.set(unselectedColor: unselectedColor)
            option.set(font: textFont)
            buttonGroup.add(button: option)
            stackView.addArrangedSubview(option)
        }
    }

    /// Select the MURadioButtonProtocol at specific index. It will unselect the current one if needed.
    open func select(index: Int) {
        buttonGroup.select(index: index)
    }

    // MARK: - Life cycle functions

    /// Default setup to load the view from a xib file.
    open override func xibSetup() {
        super.xibSetup()

        buttonGroup.delegate = self
    }
}

extension MUOptionPicker: MURadioButtonDelegate {
    /// Will trigger each time a radio button is selected.
    public func didSelect(button: MURadioButtonProtocol) {
        guard let option = button as? MUOption else {
            return
        }
        selectedIndex = option.tag
    }

    /// Will trigger each time a radio button is unselected.
    public func didUnselect(button: MURadioButtonProtocol) { }
}
