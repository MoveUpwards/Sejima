//
//  MUBarChart.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 11/09/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit

open class MUBarChart: MUNibView {
    @IBOutlet private var leftLabelsStackView: UIStackView!
    @IBOutlet private var leftSpacingView: UIView!
    @IBOutlet private var leftSeparatorLineView: UIView!

    @IBOutlet private var bottomLabelsStackView: UIStackView!
    @IBOutlet private var bottomSpacingView: UIView!

    @IBOutlet private var bottomSeparatorLineView: UIView!

    @IBOutlet private var datasStackView: UIStackView!

    @IBOutlet private var leftSpacingWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var leftSeparatorWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var bottomSpacingHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var bottomSeparatorHeightConstraint: NSLayoutConstraint!

    // MARK: - Insets

    /// Define the inset between the left's labels and the chart's bar.
    @IBInspectable open dynamic var leftLabelsInset: CGFloat = 0.0 {
        didSet {
            leftSpacingWidthConstraint.constant = leftLabelsInset
        }
    }

    /// Define the inset between the bottom's labels and the separator's line.
    @IBInspectable open dynamic var bottomLabelsInset: CGFloat = 0.0 {
        didSet {
            bottomSpacingHeightConstraint.constant = bottomLabelsInset
        }
    }

    // MARK: - Main lines

    /// Define the left separator line's color.
    @IBInspectable open dynamic var leftLineColor: UIColor = .white {
        didSet {
            leftSeparatorLineView.backgroundColor = leftLineColor
        }
    }

    /// Define the left separator line's width.
    @IBInspectable open dynamic var leftSeparatorWidth: CGFloat = 1.0 {
        didSet {
            leftSeparatorWidthConstraint.constant = leftSeparatorWidth
        }
    }

    /// Define the bottom separator line's color.
    @IBInspectable open dynamic var bottomLineColor: UIColor = .white {
        didSet {
            bottomSeparatorLineView.backgroundColor = bottomLineColor
        }
    }

    /// Define the bottom separator line's width.
    @IBInspectable open dynamic var bottomSeparatorHeight: CGFloat = 1.0 {
        didSet {
            bottomSeparatorHeightConstraint.constant = bottomSeparatorHeight
        }
    }

    // MARK: - Background lines

    @IBInspectable open dynamic var bkgLineColor: UIColor = UIColor.white.withAlphaComponent(0.5) {
        didSet {
            addBackgroundLines()
        }
    }

    @IBInspectable open dynamic var bkgLineWidth: CGFloat = 0.5 {
        didSet {
            addBackgroundLines()
        }
    }

    @IBInspectable open dynamic var bkgLineDashWidth: Float = 1.0 {
        didSet {
            addBackgroundLines()
        }
    }

    @IBInspectable open dynamic var bkgLineGapWidth: Float = 0.0 {
        didSet {
            addBackgroundLines()
        }
    }

    // *** All this variables won't change the bar chart until compute() function ***

    // MARK: - Labels

    /// Specifies the title label's font.
    open var labelFont = UIFont.systemFont(ofSize: 6.0, weight: .regular)

    /// Specifies the title label's color.
    open var labelColor = UIColor.white

    /// Specifies the value label's font.
    open var valueFont = UIFont.systemFont(ofSize: 6.0, weight: .regular)

    /// Specifies the value label's color.
    open var valueColor = UIColor.white

    /// Specifies the indicator's value format.
    open var valueFormat = "%.f"

    // MARK: - Configuration

    /// Specifies the chart's type.
    open var type = MUBarChartType.stacked

    /// Specifies the chart's orientation.
    open var orientation = NSLayoutConstraint.Axis.vertical

    /// Specifies to show the total value label of each bar.
    open var showTotalValue = false

    /// Specifies to show the total value label of each bar.
    open var totalValueOffset = CGFloat(5.0)

    /// Specifies the chart's values to highlight the bars.
    open var values = [String]()

    /// Specifies the chart's datas to generate the bars.
    open var datas = [MUBarChartData]()

    /// Specifies the maximum value show on the chart.
    open var maxDataValue = CGFloat(0.0)

    /// Define the bar's width (or thickness).
    open var barWidth = CGFloat(1.0)

    /// Define the bar's radius.
    open var barRadius = CGFloat(0.0)

    // MARK: - Generation

    /// Generate the view to be autolayout and resize
    open func compute() {
        fillValuesLabels()
        fillDatasLabels()
        fillDatas()
        addBackgroundLines()
    }

    private func addBackgroundLines() {
        subviews.filter({ return $0 is MUDashedView }).forEach({ $0.removeFromSuperview() })

        let valuesLabels = orientation == .vertical ? leftLabelsStackView : bottomLabelsStackView
        let firstValue = values.first ?? ""

        valuesLabels?.arrangedSubviews.forEach { subview in
            guard let label = subview as? UILabel else {
                return
            }

            guard values.count < 2 || firstValue != label.text else { // 1 or 2 values won't fill top and bottom
                return
            }

            let separator = MUDashedView()
            separator.dashWidth = bkgLineDashWidth
            separator.gapWidth = bkgLineGapWidth
            separator.dashColor = bkgLineColor

            addSubview(separator)
            sendSubviewToBack(separator)
            separator.translatesAutoresizingMaskIntoConstraints = false

            if orientation == .vertical {
                separator.heightAnchor.constraint(equalToConstant: bkgLineWidth).isActive = true
                separator.constraint(.left, to: leftSpacingView, position: .right)
                separator.constraint(.centerY, to: label)
                separator.constraint(.right, to: self)
            } else {
                separator.orientation = .vertical
                separator.widthAnchor.constraint(equalToConstant: bkgLineWidth).isActive = true
                separator.constraint(.bottom, to: bottomSeparatorLineView, position: .top)
                separator.constraint(.centerX, to: label)
                separator.constraint(.top, to: self)
            }
        }
    }

    private func fillValuesLabels() {
        let valuesLabels = orientation == .vertical ? leftLabelsStackView : bottomLabelsStackView
        valuesLabels?.arrangedSubviews.forEach { $0.removeFromSuperview() }
        valuesLabels?.distribution = .equalSpacing

        (orientation == .vertical ? values.reversed() : values).forEach { valueString in
            // Create a label to show the valueString
            let label = UILabel()
            label.text = valueString
            label.font = labelFont
            label.textColor = labelColor
            valuesLabels?.addArrangedSubview(label)
        }
    }

    private func fillDatasLabels() {
        let valuesLabels = orientation == .vertical ? bottomLabelsStackView : leftLabelsStackView
        valuesLabels?.arrangedSubviews.forEach { $0.removeFromSuperview() }
        valuesLabels?.distribution = .fillEqually

        datas.map({ $0.title }).forEach { valueString in
            // Create a label to show the valueString
            let label = UILabel()
            label.text = valueString
            label.font = labelFont
            label.textColor = labelColor
            label.textAlignment = .center
            valuesLabels?.addArrangedSubview(label)
        }
    }

    private func fillDatas() {
        datasStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        datasStackView.axis = orientation == .vertical ? .horizontal : .vertical
        datasStackView.distribution = .fillEqually

        let radiusCorners: UIRectCorner = orientation == .vertical ? [.topLeft, .topRight] : [.topRight, .bottomRight]

        datas.forEach { data in
            let bkgView = UIView()
            bkgView.backgroundColor = .clear

            let maxValue = data.values.map({ $0.value }).max() ?? 0.0
            let radiusValue = type == .stacked ? data.totalValue : maxValue
            let (radiusWidth, radiusHeight) = barSizeMultiplier(for: radiusValue,
                                                                maxValue: maxDataValue,
                                                                barWidth: barWidth)
            let radiusView = addStackedBar(to: bkgView, color: .clear, width: radiusWidth, height: radiusHeight)
            if barRadius > 0.0, type == .stacked {
                radiusView.roundCorners(radiusCorners, value: barRadius)
                radiusView.clipsToBounds = true
            }

            var lastBarView: UIView?
            let valuesCount = CGFloat(data.values.count)
            data.values.forEach { value in
                switch type {
                case .stacked:
                    let (width, height) = barSizeMultiplier(for: value.value, maxValue: data.totalValue)
                    lastBarView = addStackedBar(to: radiusView,
                                         color: value.color,
                                         stackTo: lastBarView,
                                         width: width,
                                         height: height)

                    if data.showValue {
                        addValueLabel(to: bkgView, stackTo: lastBarView, origin: .center, value: value.value)
                    }
                case .sideBySide:
                    let (width, height) = barSizeMultiplier(for: value.value,
                                                            maxValue: maxValue,
                                                            barWidth: 1.0 / valuesCount)
                    lastBarView = addSideBySideBar(to: radiusView,
                                                   color: value.color,
                                                   stackTo: lastBarView,
                                                   width: width,
                                                   height: height)

                    if barRadius > 0.0 {
                        lastBarView?.roundCorners(radiusCorners, value: barRadius)
                    }

                    if data.showValue || showTotalValue, let lastBarView = lastBarView {
                        addTotalValueLabel(to: bkgView, stackTo: lastBarView, value: value.value)
                    }
                }
            }

            datasStackView.addArrangedSubview(bkgView)

            guard showTotalValue, type == .stacked else {
                return
            }

            addTotalValueLabel(to: bkgView, stackTo: radiusView, value: data.totalValue)
        }
    }

    private func addTotalValueLabel(to parentView: UIView, stackTo stackView: UIView, value: CGFloat) {
        addValueLabel(to: parentView,
                      stackTo: stackView,
                      origin: orientation == .vertical ? .topCenter : .rightCenter,
                      position: orientation == .vertical ? .bottomCenter : .leftCenter,
                      value: value,
                      xOffset: orientation == .vertical ? 0.0 : -totalValueOffset,
                      yOffset: orientation == .vertical ? totalValueOffset : 0.0)
    }

    private func addValueLabel(to parentView: UIView,
                               stackTo stackView: UIView? = nil,
                               origin: MUAutolayoutPosition,
                               position: MUAutolayoutPosition? = nil,
                               value: CGFloat,
                               xOffset: CGFloat = 0.0,
                               yOffset: CGFloat = 0.0) {
        let label = UILabel()
        label.font = valueFont
        label.textColor = valueColor

        // check if counting with ints - cast to int
        if nil != valueFormat.range(of: "%(.*)d", options: .regularExpression, range: nil)
            || nil != valueFormat.range(of: "%(.*)i") {
            label.text = String(format: valueFormat, Int(value))
        } else {
            label.text = String(format: valueFormat, value)
        }

        parentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        (stackView ?? parentView).constraint(origin, to: label, position: position, xOffset: xOffset, yOffset: yOffset)
    }

    private func barSizeMultiplier(for dataValue: CGFloat,
                                   maxValue: CGFloat = 0.0,
                                   barWidth: CGFloat = 1.0) -> (CGFloat, CGFloat) {
        let value = maxValue != 0.0 ? dataValue / maxValue : 0.0 // To avoid division by zero
        let height: CGFloat
        let width: CGFloat

        switch orientation {
        case .vertical:
            height = value
            width = barWidth
        case .horizontal:
            height = barWidth
            width = value
        @unknown default:
            height = 0.0
            width = 0.0
        }

        return (width, height)
    }

    private func addStackedBar(to mainView: UIView,
                               color: UIColor,
                               stackTo stackView: UIView? = nil,
                               width: CGFloat = 0.0,
                               height: CGFloat = 0.0) -> UIView {
        let barView = UIView()
        barView.backgroundColor = color

        let origin = orientation == .vertical ? MUAutolayoutPosition.bottomCenter : .leftCenter
        if let stackView = stackView {
            let position = orientation == .vertical ? MUAutolayoutPosition.topCenter : .rightCenter
            mainView.addSubview(barView)
            barView.translatesAutoresizingMaskIntoConstraints = false

            stackView.constraint(position, to: barView, position: origin)
            barView.widthAnchor.addConstraint(to: mainView.widthAnchor, multiplier: width)
            barView.heightAnchor.addConstraint(to: mainView.heightAnchor, multiplier: height)
//            mainView.addAutolayoutSubview(barView, origin: origin, position: position, height: height, width: width)
        } else { // We add it to the mainView directly (first view)
            mainView.addAutolayoutSubview(barView, origin: origin, height: height, width: width)
        }

        return barView
    }

    private func addSideBySideBar(to mainView: UIView,
                                  color: UIColor,
                                  stackTo stackView: UIView? = nil,
                                  width: CGFloat = 0.0,
                                  height: CGFloat = 0.0) -> UIView {
        let barView = UIView()
        barView.backgroundColor = color

        let origin = orientation == .vertical ? MUAutolayoutPosition.bottomLeft : .topLeft
        if let stackView = stackView {
            let position = orientation == .vertical ? MUAutolayoutPosition.bottomRight : .bottomLeft
            mainView.addSubview(barView)
            barView.translatesAutoresizingMaskIntoConstraints = false

            stackView.constraint(position, to: barView, position: origin)
            barView.widthAnchor.addConstraint(to: mainView.widthAnchor, multiplier: width)
            barView.heightAnchor.addConstraint(to: mainView.heightAnchor, multiplier: height)
        } else { // We add it to the mainView directly (first view)
            mainView.addAutolayoutSubview(barView, origin: origin, height: height, width: width)
        }

        return barView
    }
}
