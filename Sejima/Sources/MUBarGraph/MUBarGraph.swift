//
//  MUBarGraph.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 26/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Class that define a bar graph.
@IBDesignable
open class MUBarGraph: MUNibView {
    @IBOutlet private var background: UIImageView!
    @IBOutlet private var bars: UIStackView!
    @IBOutlet private var barTitles: UIStackView!
    @IBOutlet private var barValues: UIStackView!

    @IBOutlet private var backgroundLeading: NSLayoutConstraint!
    @IBOutlet private var backgroundBottom: NSLayoutConstraint!
    @IBOutlet private var barsTopSpacingHeight: NSLayoutConstraint!
    @IBOutlet private var titlesTopSpacingHeight: NSLayoutConstraint!
    @IBOutlet private var titlesHeight: NSLayoutConstraint!
    @IBOutlet private var valuesRightSpacingWidth: NSLayoutConstraint!
    @IBOutlet private var valuesTop: NSLayoutConstraint!
    @IBOutlet private var valuesWidth: NSLayoutConstraint!
    @IBOutlet private var valuesBottom: NSLayoutConstraint!

    /// Define the top inset to avoid the indicator to be outside of the view.
    @IBInspectable open dynamic var barTopInset: CGFloat = 0.0 {
        didSet {
            barsTopSpacingHeight.constant = barTopInset
        }
    }

    /// Define the width of the spoke line.
    @IBInspectable open dynamic var barWidth: CGFloat = 1.0 {
        didSet {
            bars.arrangedSubviews.compactMap({ $0 as? MUBar }).forEach({ $0.proportionalWidth = barWidth })
        }
    }

    /// The maximum value of the bar.
    @IBInspectable open dynamic var indicatorMultiplier: CGFloat = 0.0 {
        didSet {
            bars.arrangedSubviews.compactMap({ $0 as? MUBar }).forEach({ $0.indicatorMultiplier = indicatorMultiplier })
        }
    }

    /// Specifies the indicator's value format.
    @IBInspectable open dynamic var indicatorFormat: String = "%.f" {
        didSet {
            bars.arrangedSubviews.compactMap({ $0 as? MUBar }).forEach({ $0.indicatorFormat = indicatorFormat })
        }
    }

    /// Specifies the indicator's value font.
    @objc open dynamic var indicatorTextFont: UIFont = .systemFont(ofSize: 24.0, weight: .bold) {
        didSet {
            bars.arrangedSubviews.compactMap({ $0 as? MUBar }).forEach({ $0.indicatorTextFont = indicatorTextFont })
        }
    }

    /// Specifies the indicator's value color.
    @IBInspectable open dynamic var indicatorTextColor: UIColor = .white {
        didSet {
            bars.arrangedSubviews.compactMap({ $0 as? MUBar }).forEach({ $0.indicatorTextColor = indicatorTextColor })
        }
    }

    /// Specifies the indicator's proportional width.
    @IBInspectable open dynamic var indicatorWidth: CGFloat = 0.0000001 { // 0.0 Won't be a valid value for multiplier
        didSet {
            bars.arrangedSubviews.compactMap({ $0 as? MUBar }).forEach({ $0.indicatorWidth = indicatorWidth })
        }
    }

    /// Specifies the indicator's color.
    @IBInspectable open dynamic var indicatorColor: UIColor = .white {
        didSet {
            bars.arrangedSubviews.compactMap({ $0 as? MUBar }).forEach({ $0.indicatorColor = indicatorColor })
        }
    }

    /// Specifies the title's font.
    @objc open dynamic var titleFont: UIFont = .systemFont(ofSize: 6.0, weight: .regular) {
        didSet {
            updateBarsAndTitles()
            updateValues()
        }
    }

    /// Specifies the title's color.
    @IBInspectable open dynamic var titleColor: UIColor = .white {
        didSet {
            barTitles.arrangedSubviews.compactMap({ $0 as? UILabel }).forEach({ $0.textColor = titleColor })
            barValues.arrangedSubviews.compactMap({ $0 as? UILabel }).forEach({ $0.textColor = titleColor })
        }
    }

    /// Specifies the inset between title and bar graph.
    @IBInspectable open dynamic var titleTopInset: CGFloat = 0.0 {
        didSet {
            titlesTopSpacingHeight.constant = titleTopInset
        }
    }

    /// Specifies the inset between right values and bar graph.
    @IBInspectable open dynamic var valueRightInset: CGFloat = 0.0 {
        didSet {
            valuesRightSpacingWidth.constant = valueRightInset
        }
    }

    ///
    @IBInspectable open dynamic var lineColor: UIColor = .black {
        didSet {
            setNeedsLayout()
        }
    }

    ///
    @IBInspectable open dynamic var lineWidth: CGFloat = 1.0 {
        didSet {
            backgroundLeading.constant = lineWidth * 0.5
            backgroundBottom.constant = lineWidth * 0.5

            setNeedsLayout()
        }
    }

    ///
    @objc open dynamic var values: [String] = [] {
        didSet {
            updateValues()
        }
    }

    ///
    open var datas: [MUBarGraphData] = [] {
        didSet {
            updateBarsAndTitles()
        }
    }

    // MARK: - Life cycle functions

    /// Lays out subviews.
    override open func layoutSubviews() {
        super.layoutSubviews()

        updateBackground()
    }

    // MARK: - Private functions

    private func updateBackground() {
        UIGraphicsBeginImageContextWithOptions(background.bounds.size, false, 0.0)
        defer {
            UIGraphicsEndImageContext()
        }

        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        lineColor.setStroke()
        context.setLineWidth(lineWidth)

        // Add main lines
        context.move(to: .zero)
        context.addLine(to: CGPoint(x: 0.0, y: background.bounds.size.height))
        context.addLine(to: CGPoint(x: background.bounds.size.width, y: background.bounds.size.height))

        // Add top line
        context.move(to: CGPoint(x: 0.0, y: 2.0))
        context.addLine(to: CGPoint(x: background.bounds.size.width, y: 2.0))

        let count = CGFloat(values.count - 1)
        if count > 1 {
            let height = background.bounds.size.height / count
            let offset = background.bounds.size.height * 0.01

            // Start to 1 to skip first line
            for index in 1 ..< Int(count) {
                let yCoord = CGFloat(index) * height + offset * (((count - CGFloat(index) - 1) / (count - 2)))
                context.move(to: CGPoint(x: 0.0, y: yCoord))
                context.addLine(to: CGPoint(x: background.bounds.size.width, y: yCoord))
            }
        }

        context.strokePath()

        // Draw the image and set it to the UIImageView
        if let cgImage = context.makeImage() {
            UIGraphicsPopContext()
            background.image = UIImage(cgImage: cgImage)
        }
    }

    private func updateBarsAndTitles() {
        var maxTitleHeight = CGFloat(0.0)

        bars.arrangedSubviews.forEach { $0.removeFromSuperview() }
        barTitles.arrangedSubviews.forEach { $0.removeFromSuperview() }

        datas.forEach { data in
            let bar = createBar(with: data)
            bars.addArrangedSubview(bar)
            bar.heightAnchor.constraint(equalTo: bars.heightAnchor).isActive = true

            let title = createTitle()
            barTitles.addArrangedSubview(title)

            title.text = data.title
            title.sizeToFit()
            if title.bounds.height > maxTitleHeight {
                maxTitleHeight = title.bounds.height
            }
        }

        titlesHeight.constant = maxTitleHeight
    }

    private func createBar(with data: MUBarGraphData) -> MUBar {
        let bar = MUBar()

        bar.proportionalWidth = barWidth
        bar.value = data.value
        bar.color = data.color
        bar.radius = 4.0 // Should expose it
        bar.showIndicator = data.showIndicator
        bar.indicatorRadius = 4.0 // Should expose it
        bar.indicatorMultiplier = indicatorMultiplier
        bar.indicatorFormat = indicatorFormat
        bar.indicatorWidth = indicatorWidth
        bar.indicatorColor = indicatorColor
        bar.indicatorTextColor = indicatorTextColor
        bar.indicatorTextFont = indicatorTextFont
        bar.indicatorBottomInset = bars.bounds.height * 0.02

        return bar
    }

    private func createTitle() -> UILabel {
        let title = UILabel()

        title.font = titleFont
        title.textColor = titleColor
        title.textAlignment = .center
        title.numberOfLines = 0

        return title
    }

    private func updateValues() {
        barValues.arrangedSubviews.forEach { $0.removeFromSuperview() }

        var maxValueWidth = CGFloat(0.0)
        values.reversed().forEach { value in
            let title = UILabel()
            title.text = value
            title.font = titleFont
            title.textColor = titleColor
            title.textAlignment = .right
            barValues.addArrangedSubview(title)

            title.sizeToFit()
            if title.bounds.width > maxValueWidth {
                maxValueWidth = title.bounds.width
            }
        }

        var textHeight = CGFloat(0.0)
        var halfHeight = CGFloat(0.0)
        if !barValues.arrangedSubviews.isEmpty {
            textHeight = barValues.arrangedSubviews[0].bounds.height
            halfHeight = barValues.frame.size.height / CGFloat(barValues.arrangedSubviews.count) * 0.5
        }

        valuesTop.constant = -halfHeight + textHeight * 0.5
        valuesBottom.constant = halfHeight

        valuesWidth.constant = maxValueWidth
    }
}
