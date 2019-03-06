//
//  MUProportionalBar.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 03/01/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit

open class MUProportionalBar: MUNibView {
    @IBOutlet private var verticalStackView: UIStackView!
    @IBOutlet private var proportionalStackView: UIStackView!
    @IBOutlet private var proportionalBackgroundView: UIView!
    @IBOutlet private var titlesStackView: UIStackView!

    @IBOutlet private var titleLeading: NSLayoutConstraint!
    @IBOutlet private var titleTrailing: NSLayoutConstraint!

    public struct Data {
        public let title: String
        public let value: CGFloat
        public let color: UIColor

        public init(title: String, value: CGFloat, color: UIColor) {
            self.title = title
            self.value = value
            self.color = color
        }
    }

    open override func xibSetup() {
        super.xibSetup()

        proportionalBackgroundView.clipsToBounds = true
    }

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @IBInspectable open dynamic var titleOffset: CGFloat = 4.0 {
        didSet {
            verticalStackView.spacing = titleOffset
        }
    }

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var titleHorizontalPadding: CGFloat = 4.0 {
        didSet {
            titleLeading.constant = titleHorizontalPadding
            titleTrailing.constant = titleHorizontalPadding
        }
    }

    /// Describes the bar's corner radius as a percentage (0.0 is square, 0.5 is round, 0.75 will be ugly)
    @IBInspectable open dynamic var roundBarPercentage: CGFloat = 0.5 {
        didSet {
            proportionalBackgroundView.layer.cornerRadius = proportionalBackgroundView.frame.height * roundBarPercentage
        }
    }

    @objc open dynamic var titleFont: UIFont = .systemFont(ofSize: 12, weight: .regular) {
        didSet {
            titlesStackView.arrangedSubviews.forEach { ($0 as? UILabel)?.font = titleFont }
        }
    }

    public func set(datas: [Data]) {
        proportionalStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        titlesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        datas.forEach { data in
            // Bar
//            let view = MUProportionalView()
//            view.backgroundColor = data.color
//            view.set(width: data.value * 100)
//            proportionalStackView.addArrangedSubview(view)

            // Titles
            let label = UILabel(frame: .zero)
            label.text = data.title
            label.textColor = data.color
            label.font = titleFont
            titlesStackView.addArrangedSubview(label)
        }
    }
}
