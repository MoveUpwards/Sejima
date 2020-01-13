//
//  MUProportionalBar.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 03/01/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Class that provide a proportional progress with customizable options.
@IBDesignable
open class MUProportionalBar: MUNibView {
    @IBOutlet private var verticalStackView: UIStackView!
    @IBOutlet private var proportionalStackView: UIStackView!
    @IBOutlet private var proportionalBackgroundView: UIView!
    @IBOutlet private var titlesStackView: UIStackView!

    @IBOutlet private var titleLeading: NSLayoutConstraint!
    @IBOutlet private var titleTrailing: NSLayoutConstraint!

    /// The progress bar's style.
    open var style: MUCornerStyle = .square {
        didSet {
            updateStyle()
        }
    }

    // MARK: - Public IBInspectable and UIAppearence variables

    /// Optional: The IBInspectable version of the progress bar's style.
    @IBInspectable open dynamic var styleInt: Int = 0 {
        didSet {
            switch styleInt {
            case 0:
                style = .square
            case 1:
                style = .round
            default:
                style = .custom(radius)
            }
        }
    }

    /// The progress bar's corner radius.
    @IBInspectable open dynamic var radius: CGFloat = 0.0 {
        didSet {
            guard radius > 0 else {
                return
            }
            style = .custom(radius)
        }
    }

    /// The title’s top offset.
    @IBInspectable open dynamic var titleOffset: CGFloat = 4.0 {
        didSet {
            verticalStackView.spacing = titleOffset
        }
    }

    /// The title’s horizontal padding.
    @IBInspectable open dynamic var titleHorizontalPadding: CGFloat = 4.0 {
        didSet {
            titleLeading.constant = titleHorizontalPadding
            titleTrailing.constant = titleHorizontalPadding
        }
    }

    /// The title’s font.
    @objc open dynamic var titleFont: UIFont = .systemFont(ofSize: 12, weight: .regular) {
        didSet {
            titlesStackView.arrangedSubviews.forEach { ($0 as? UILabel)?.font = titleFont }
        }
    }

    /// The proportioal items
    public var items = [MUProportionalItem]() {
        didSet {
            guard items.count > 1 else { return }

            proportionalStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            titlesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

            for item in items {
                addBar(for: item)
                addTitle(for: item)
            }
        }
    }

    // MARK: - Private functions

    private func updateStyle() {
        switch style {
        case .round:
            proportionalBackgroundView.layer.cornerRadius = proportionalBackgroundView.bounds.height * 0.25
        case .custom(let radius):
            proportionalBackgroundView.layer.cornerRadius = CGFloat(radius) * 0.5
        case .square:
            proportionalBackgroundView.layer.cornerRadius = 0
        }
    }

    private func addBar(for item: MUProportionalItem) {
        let view = MUProportionalView()
        view.backgroundColor = item.color
        view.set(width: item.value * 100)
        proportionalStackView.addArrangedSubview(view)
    }

    private func addTitle(for item: MUProportionalItem) {
        let label = UILabel(frame: .zero)
        label.text = item.title
        label.textColor = item.color
        label.font = titleFont
        titlesStackView.addArrangedSubview(label)
    }

    // MARK: - Life cycle functions

    /// Default setup to load the view from a xib file.
    open override func xibSetup() {
        super.xibSetup()

        proportionalBackgroundView.clipsToBounds = true
    }
}
