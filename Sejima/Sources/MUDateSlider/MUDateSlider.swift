//
//  MUDateSlider.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//
//  Based on: https://github.com/itsmeichigo/DateTimePicker
//

import UIKit
import Neumann

/// Delegate protocol for MUDateSlider objects.
@objc public protocol MUDateSliderDelegate: class {
    /// Will trigger each time a date is selected.
    func didSelect(picker: MUDateSlider, date: Date)
    /// Will trigger each time a cell date will be display.
    func willDisplay(picker: MUDateSlider, cell: MUDateSliderCell, date: Date)
}

/// Class that act like an horizontal slider with date components.
@IBDesignable
public class MUDateSlider: MUNibView {
    @IBOutlet private var dayCollectionView: UICollectionView!

    // MARK: - Private variables

    private var dates: [Date] = []

    // MARK: - Public variables

    /// The object that acts as the delegate of the date slider.
    @IBOutlet public weak var delegate: MUDateSliderDelegate? // swiftlint:disable:this private_outlet strong_iboutlet line_length

    /// selected date when picker is displayed, default to current date
    public private(set) var selectedIndex: Int?

    // MARK: - Date day

    /// Define the date day text font.
    @objc open dynamic var dayFont: UIFont = .systemFont(ofSize: 10) {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the date day selected color.
    @IBInspectable open dynamic var selectedDayColor: UIColor = .white {
        didSet {
            dayCollectionView.reloadData()
        }
    }

    /// Define the date day unselected color.
    @IBInspectable open dynamic var unselectedDayColor: UIColor = .black {
        didSet {
            dayCollectionView.reloadData()
        }
    }

    // MARK: - Date number

    /// Define the date number text font.
    @objc open dynamic var numberFont: UIFont = .boldSystemFont(ofSize: 18) {
        didSet {
            dayCollectionView.reloadData()
        }
    }

    /// Define the date number selected color.
    @IBInspectable open dynamic var selectedNumberColor: UIColor = .white {
        didSet {
            dayCollectionView.reloadData()
        }
    }

    /// Define the date number unselected color.
    @IBInspectable open dynamic var unselectedNumberColor: UIColor = .black {
        didSet {
            dayCollectionView.reloadData()
        }
    }

    // MARK: - Date month

    /// Define the date month text font.
    @objc open dynamic var monthFont: UIFont = .systemFont(ofSize: 10) {
        didSet {
            dayCollectionView.reloadData()
        }
    }

    /// Define the date month selected color.
    @IBInspectable open dynamic var selectedMonthColor: UIColor = .white {
        didSet {
            dayCollectionView.reloadData()
        }
    }

    /// Define the date month unselected color.
    @IBInspectable open dynamic var unselectedMonthColor: UIColor = .black {
        didSet {
            dayCollectionView.reloadData()
        }
    }

    // MARK: - Date card

    /// Define the date card corner radius.
    @IBInspectable open dynamic var radius: CGFloat = 4 {
        didSet {
            dayCollectionView.reloadData()
        }
    }

    /// Define the date card selected border color.
    @IBInspectable open dynamic var selectedBorderColor: UIColor = .black {
        didSet {
            dayCollectionView.reloadData()
        }
    }

    /// Define the date card unselected border color.
    @IBInspectable open dynamic var unselectedBorderColor: UIColor = .clear {
        didSet {
            dayCollectionView.reloadData()
        }
    }

    /// Define the date card selected border width.
    @IBInspectable open dynamic var selectedBorderWidth: CGFloat = 1.0 {
        didSet {
            dayCollectionView.reloadData()
        }
    }

    /// Define the date card unselected border width.
    @IBInspectable open dynamic var unselectedBorderWidth: CGFloat = 0.0 {
        didSet {
            dayCollectionView.reloadData()
        }
    }

    // MARK: - Date card background

    /// Define the date card selected background color.
    @IBInspectable open dynamic var selectedBackgroundColor: UIColor = .purple {
        didSet {
            dayCollectionView.reloadData()
        }
    }

    /// Define the date card unselected background color.
    @IBInspectable open dynamic var unselectedBackgroundColor: UIColor = .white {
        didSet {
            dayCollectionView.reloadData()
        }
    }

    // MARK: - Marker

    /// Define the selected marker color.
    @IBInspectable open dynamic var selectedMarkerColor: UIColor = .purple {
        didSet {
            dayCollectionView.reloadData()
        }
    }

    /// Define the unselected marker color.
    @IBInspectable open dynamic var unselectedMarkerColor: UIColor = .purple {
        didSet {
            dayCollectionView.reloadData()
        }
    }

    /// Define the marker line height.
    @IBInspectable open dynamic var markerLineHeight: CGFloat = 4.0 {
        didSet {
            dayCollectionView.reloadData()
        }
    }

    /// Define the minimum slider date. Default is current date.
    @objc open dynamic var minimumDate = Date() {
        didSet {
            fillDates(fromDate: minimumDate, toDate: maximumDate)
        }
    }

    /// Define the maximum slider date. Default is current date.
    @objc open dynamic var maximumDate = Date() {
        didSet {
            fillDates(fromDate: minimumDate, toDate: maximumDate)
        }
    }

    // MARK: - Public functions

    /// Select today date.
    public func today() {
        var todayIndex: Int?

        for (index, date) in dates.enumerated() where Calendar.current.isDateInToday(date) {
            todayIndex = index
            break
        }

        if let idx = todayIndex {
            select(index: idx)
        }
    }

    /// Select item date at given index.
    public func select(index: Int, animated: Bool = true) {
        guard index >= 0 && index < dates.count else {
            return
        }

        selectedIndex = index
        dayCollectionView.selectItem(at: IndexPath(row: index, section: 0),
                                     animated: animated,
                                     scrollPosition: .centeredHorizontally)
        delegate?.didSelect(picker: self, date: dates[index])
    }

    // MARK: - Private functions

    private func customize(cell: MUDateSliderCell?) {
        cell?.set(radius: radius)
        cell?.set(dayFont: dayFont,
                  numberFont: numberFont,
                  monthFont: monthFont)
        cell?.set(selectedDayColor: selectedDayColor,
                  unselectedDayColor: unselectedDayColor)
        cell?.set(selectedNumberColor: selectedNumberColor,
                  unselectedNumberColor: unselectedNumberColor)
        cell?.set(selectedMonthColor: selectedMonthColor,
                  unselectedMonthColor: unselectedMonthColor)
        cell?.set(selectedBorderColor: selectedBorderColor,
                  selectedBorderWidth: selectedBorderWidth,
                  unselectedBorderColor: unselectedBorderColor,
                  unselectedBorderWidth: unselectedBorderWidth)
        cell?.set(selectedBackgroundColor: selectedBackgroundColor,
                  unselectedBackgroundColor: unselectedBackgroundColor)
        cell?.set(selectedMarkerColor: selectedMarkerColor,
                  unselectedMarkerColor: unselectedMarkerColor,
                  markerLineHeight: markerLineHeight)

    }

    private func fillDates(fromDate: Date, toDate: Date) {
        let calendar = Calendar.current

        var days = DateComponents()
        var dayCount = 0

        dates.removeAll()

        repeat {
            days.day = dayCount
            dayCount += 1
            guard let date = calendar.date(byAdding: days, to: fromDate) else {
                break
            }
            if date.compare(toDate) == .orderedDescending {
                break
            }
            dates.append(date)
        } while (true)

        dayCollectionView.reloadData()
    }

    // MARK: - Life cycle functions

    /// Default setup to load the view from a xib file.
    public override func xibSetup() {
        super.xibSetup()

        let inset = (dayCollectionView.frame.width - 75) / 2
        dayCollectionView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)

        fillDates(fromDate: minimumDate, toDate: maximumDate)

        dayCollectionView.register(MUDateSliderCell.self,
                                   forCellWithReuseIdentifier: MUDateSliderCell.identifer)
    }

    /// The natural size for the receiving view, considering only properties of the view itself.
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: 375, height: 100)
    }
}

extension MUDateSlider: UICollectionViewDataSource {
    /// Returns the number of section.
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    /// Returns the number of item in section.
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }

    /// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MUDateSliderCell.identifer,
                                                      for: indexPath) as? MUDateSliderCell
        cell?.set(date: dates[indexPath.row])
        customize(cell: cell)
        return cell ?? UICollectionViewCell()
    }
}

extension MUDateSlider: UICollectionViewDelegate {
    /// Collection view will display cell delegate.
    public func collectionView(_ collectionView: UICollectionView,
                               willDisplay cell: UICollectionViewCell,
                               forItemAt indexPath: IndexPath) {
        guard let cell = cell as? MUDateSliderCell else {
            return
        }

        delegate?.willDisplay(picker: self, cell: cell, date: dates[indexPath.row])
    }

    /// Collection view did select item at index path.
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        delegate?.didSelect(picker: self, date: dates[indexPath.row])

        if let cell = collectionView.cellForItem(at: indexPath) {
            let offset = CGPoint(x: cell.center.x - collectionView.frame.width / 2, y: 0)
            collectionView.setContentOffset(offset, animated: true)
        }
    }
}
