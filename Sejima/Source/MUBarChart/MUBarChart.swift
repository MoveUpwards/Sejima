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

    @IBOutlet private var bottomLabelsStackView: UIStackView!
    @IBOutlet private var bottomSpacingView: UIView!

    @IBOutlet private var bottomSeparatorLineView: UIView!

    @IBOutlet private var datasStackView: UIStackView!

    @IBOutlet private var leftSpacingWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var bottomSpacingHeightConstraint: NSLayoutConstraint!

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

    // MARK: - Background lines

    /// Specifies the indicator's lines color.
    @IBInspectable open dynamic var linesColor: UIColor = .white {
        didSet {
            bottomSeparatorLineView.backgroundColor = linesColor
            // TODO: Apply to lines / dashed lines
        }
    }

    // *** All this variables won't change the bar chart until compute() function ***

    // MARK: - Labels

    /// Specifies the title label's font.
    open var labelFont: UIFont = .systemFont(ofSize: 6.0, weight: .regular)

    /// Specifies the title label's color.
    open var labelColor: UIColor = .white

    /// Specifies the value label's font.
    open var valueFont: UIFont = .systemFont(ofSize: 6.0, weight: .regular)

    /// Specifies the value label's color.
    open var valueColor: UIColor = .white

    /// Specifies the indicator's value format.
    open var valueFormat: String = "%.f"

    // MARK: - Configuration

    /// Specifies the chart's type.
    open var type = MUBarChartType.stacked

    /// Specifies the chart's orientation.
    open var orientation = NSLayoutConstraint.Axis.vertical

    /// Specifies to show the total value label of each bar.
    open var showTotalValue: Bool = false

    /// Specifies the chart's values to highlight the bars.
    open var values = [String]()

    /// Specifies the chart's datas to generate the bars.
    open var datas = [MUBarChartData]()

    /// Specifies the maximum value show on the chart.
    open var maxDataValue = CGFloat(0.0)

    /// Define the bar's width (or thickness).
    open var barWidth: CGFloat = 1.0

    // MARK: - Generation

    /// Generate the view to be autolayout and resize
    open func compute() {
        clean()
        fillValuesLabels()
        fillDatasLabels()
        fillDatas()
    }

    private func clean() {
        leftLabelsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        bottomLabelsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        datasStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }

    private func fillValuesLabels() {
        let valuesLabels = orientation == .vertical ? leftLabelsStackView : bottomLabelsStackView
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
        valuesLabels?.distribution = .fillEqually

        (orientation == .vertical ? datas : datas.reversed()).map({ $0.title }).forEach { valueString in
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
        datasStackView.axis = orientation == .vertical ? .horizontal : .vertical
        datasStackView.distribution = .fillEqually

        datas.forEach { data in
            var lastBarView: UIView?
            let bkgView = UIView()
            bkgView.backgroundColor = .clear

            data.values.forEach { value in
                lastBarView = addBar(to: bkgView, stackTo: lastBarView, with: value)

                if data.showValue {
                    addValueLabel(to: lastBarView, origin: .center, value: value.value)
                }
            }

            if showTotalValue {
                if orientation == .vertical {
                    addValueLabel(to: lastBarView,
                                  origin: .bottom,
                                  position: .top,
                                  value: data.totalValue,
                                  yOffset: 5.0)
                } else {
                    addValueLabel(to: lastBarView,
                                  origin: .left,
                                  position: .right,
                                  value: data.totalValue,
                                  xOffset: 5.0)
                }
            }

            datasStackView.addArrangedSubview(bkgView)
        }
    }

    private func addValueLabel(to parentView: UIView?,
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

        if let position = position {
            parentView?.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false

            parentView?.constraint(position, to: label, position: origin, xOffset: xOffset, yOffset: yOffset)
        } else {
            parentView?.addAutolayoutSubview(label, origin: origin, height: nil, width: nil)
        }
    }

    private func addBar(to mainView: UIView, stackTo stackView: UIView?, with data: MUBarChartValue) -> UIView {
        let barView = UIView()
        barView.backgroundColor = data.color

        let value = maxDataValue != 0.0 ? data.value / maxDataValue : 0.0 // To avoid division by zero
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

        let origin = orientation == .vertical ? MUAutolayoutPosition.bottom : .left
        if let stackView = stackView {
            let position = orientation == .vertical ? MUAutolayoutPosition.top : .right
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
