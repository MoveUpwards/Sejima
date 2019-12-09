//
//  MUDateSliderCell.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//
//  Based on: https://github.com/itsmeichigo/DateTimePicker
//

import UIKit

/// Class that define the date slider cell.
final public class MUDateSliderCell: UICollectionViewCell {

    /// The date slider cell identifier.
    internal static let identifer = "DATE_CELL"

    // MARK: - Private variables

    private var monthLabel: UILabel
    private var dayLabel: UILabel
    private var numberLabel: UILabel
    private var marker: UIView

    private var radius: CGFloat = 4

    private var dayFont: UIFont = .systemFont(ofSize: 10)
    private var numberFont: UIFont = .boldSystemFont(ofSize: 18)
    private var monthFont: UIFont = .systemFont(ofSize: 10)

    private var unselectedDayColor: UIColor = .black
    private var unselectedNumberColor: UIColor = .black
    private var unselectedMonthColor: UIColor = .black
    private var selectedDayColor: UIColor = .white
    private var selectedNumberColor: UIColor = .white
    private var selectedMonthColor: UIColor = .white
    private var unselectedBorderColor: UIColor = .clear
    private var selectedBorderColor: UIColor = .black
    private var unselectedBorderWidth: CGFloat = 1.0
    private var selectedBorderWidth: CGFloat = 0.0
    private var unselectedBackgroundColor: UIColor = .white
    private var selectedBackgroundColor: UIColor = .purple

    private var selectedMarkerColor: UIColor = .green
    private var unselectedMarkerColor: UIColor = .purple
    private var markerLineHeight: CGFloat = 2

    // MARK: - Life cycle functions

    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override init(frame: CGRect) {
        dayLabel = UILabel(frame: CGRect(x: 5, y: 7, width: frame.width - 10, height: 20))
        numberLabel = UILabel(frame: CGRect(x: 5, y: 20, width: frame.width - 10, height: 40))
        monthLabel = UILabel(frame: CGRect(x: 5, y: 53, width: frame.width - 10, height: 20))
        marker = UIView(frame: CGRect(x: 0,
                                      y: frame.height - markerLineHeight,
                                      width: frame.width,
                                      height: markerLineHeight))

        super.init(frame: frame)

        dayLabel.textAlignment = .center
        numberLabel.textAlignment = .center
        monthLabel.textAlignment = .center
        marker.isHidden = false

        addSubview(monthLabel)
        addSubview(dayLabel)
        addSubview(numberLabel)
        addSubview(marker)

        layer.masksToBounds = true
    }

    /// Returns an object initialized from data in a given unarchiver.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public functions

    /// The selection state of the cell.
    override public var isSelected: Bool {
        didSet {
            updateUI()
        }
    }

    /// Hide / Show the cell marker.
    public func marker(show: Bool) {
        marker.isHidden = !show
    }

    /// Set the cell label text font.
    internal func set(dayFont: UIFont, numberFont: UIFont, monthFont: UIFont) {
        self.dayFont = dayFont
        self.numberFont = numberFont
        self.monthFont = monthFont

        updateUI()
    }

    /// Set the cell card corner radius.
    internal func set(radius: CGFloat) {
        self.radius = radius

        updateUI()
    }

    /// Set the border color and width for selected and unselected state.
    internal func set(selectedBorderColor: UIColor,
                      selectedBorderWidth: CGFloat,
                      unselectedBorderColor: UIColor,
                      unselectedBorderWidth: CGFloat) {
        self.selectedBorderColor = selectedBorderColor
        self.selectedBorderWidth = selectedBorderWidth
        self.unselectedBorderColor = unselectedBorderColor
        self.unselectedBorderWidth = unselectedBorderWidth

        updateUI()
    }

    /// Set the date day color for selected and unselected state.
    internal func set(selectedDayColor: UIColor, unselectedDayColor: UIColor) {
        self.selectedDayColor = selectedDayColor
        self.unselectedDayColor = unselectedDayColor

        updateUI()
    }

    /// Set the date number color for selected and unselected state.
    internal func set(selectedNumberColor: UIColor, unselectedNumberColor: UIColor) {
        self.selectedNumberColor = selectedNumberColor
        self.unselectedNumberColor = unselectedNumberColor

        updateUI()
    }

    /// Set the date month color for selected and unselected state.
    internal func set(selectedMonthColor: UIColor, unselectedMonthColor: UIColor) {
        self.selectedMonthColor = selectedMonthColor
        self.unselectedMonthColor = unselectedMonthColor

        updateUI()
    }

    /// Set the date card background color for selected and unselected state.
    internal func set(selectedBackgroundColor: UIColor, unselectedBackgroundColor: UIColor) {
        self.selectedBackgroundColor = selectedBackgroundColor
        self.unselectedBackgroundColor = unselectedBackgroundColor

        updateUI()
    }

    /// Set the date marker color and line height for selected and unselected state.
    internal func set(selectedMarkerColor: UIColor,
                      unselectedMarkerColor: UIColor,
                      markerLineHeight: CGFloat) {
        self.selectedMarkerColor = selectedMarkerColor
        self.unselectedMarkerColor = unselectedMarkerColor
        self.markerLineHeight = markerLineHeight
        updateUI()
    }

    /// Set the current selected date
    internal func set(date: Date) {
        let df = DateFormatter()
        df.dateFormat = "MMMM"
        monthLabel.text = df.string(from: date)

        df.dateFormat = "EEEE"
        dayLabel.text = df.string(from: date).uppercased()

        df.dateFormat = "d"
        numberLabel.text = df.string(from: date)

        updateUI()
    }

    // MARK: - Private functions

    private func updateUI() {
        layer.cornerRadius = radius

        dayLabel.font = dayFont
        numberLabel.font = numberFont
        monthLabel.font = monthFont

        dayLabel.textColor = isSelected ? selectedDayColor : unselectedDayColor
        numberLabel.textColor = isSelected ? selectedNumberColor : unselectedNumberColor
        monthLabel.textColor = isSelected ? selectedMonthColor : unselectedMonthColor

        marker.backgroundColor = isSelected ? selectedMarkerColor : unselectedMarkerColor
        marker.frame = CGRect(x: 0,
                              y: frame.height - markerLineHeight,
                              width: frame.width,
                              height: markerLineHeight)

        backgroundColor = isSelected ? selectedBackgroundColor : unselectedBackgroundColor

        layer.borderColor = isSelected ? selectedBorderColor.cgColor : unselectedBorderColor.cgColor
        layer.borderWidth = isSelected ? selectedBorderWidth : unselectedBorderWidth
    }
}
