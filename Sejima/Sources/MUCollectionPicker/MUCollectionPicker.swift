//
//  MUCollectionPicker.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 18/12/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Delegate protocol for MUNavigationBar.
@objc public protocol MUCollectionPickerDelegate: class {
    /// Asks the delegate for the size of the specified item’s cell. Default size is 50 x 50
    func size(_ picker: MUCollectionPicker, at indexPath: IndexPath) -> CGSize

    /// Will trigger when an item is selected.
    func didSelect(item: String, at index: Int)
}

/// Class that provides a collection picker.
@IBDesignable
open class MUCollectionPicker: MUNibView {
    @IBOutlet private var collectionView: UICollectionView!

    /// The object that acts as the delegate of the collection picker.
    @IBOutlet public weak var delegate: MUCollectionPickerDelegate? // swiftlint:disable:this private_outlet strong_iboutlet line_length

    /// The collection picker scroll direction
    open dynamic var scrollDirection: UICollectionView.ScrollDirection = .horizontal {
        didSet {
            (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = scrollDirection
        }
    }

    // MARK: - Indicator view

    /// Define the indicator's width
    @IBInspectable open dynamic var indicatorWidth: CGFloat = 1.0

    /// Define the indicator's heigth
    @IBInspectable open dynamic var indicatorHeight: CGFloat = 1.0

    /// Define the indicator's corner radius
    @IBInspectable open dynamic var indicatorRadius: CGFloat = 0.0

    /// Define the indicator's color
    @IBInspectable open dynamic var indicatorColor: UIColor = .white {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: - Item view

    /// The item label font.
    @objc open dynamic var itemFont: UIFont = .systemFont(ofSize: 17.0, weight: .regular)

    /// The item’s horizontal alignment.
    @objc open dynamic var itemAlignment: NSTextAlignment = .center {
        didSet {
            collectionView.reloadData()
        }
    }

    /// Optional: The IBInspectable version of the item’s horizontal alignment.
    @IBInspectable open dynamic var itemAlignmentInt: Int {
        get {
            return itemAlignment.rawValue
        }
        set {
            itemAlignment = NSTextAlignment(rawValue: newValue) ?? .center
        }
    }

    /// The item’s title color.
    @IBInspectable open dynamic var itemSelectedColor: UIColor = .white {
        didSet {
            collectionView.reloadData()
        }
    }

    /// The item’s title color.
    @IBInspectable open dynamic var itemUnselectedColor: UIColor = .black {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: - Private variables

    private var items = [String]() {
        didSet {
            collectionView.reloadData()
        }
    }
    private var selectedItem: IndexPath?

    // MARK: - Life cycle functions

    /// Default setup to load the view from a xib file.
    override open func xibSetup() {
        super.xibSetup()
        collectionView.delegate = self
        collectionView.dataSource = self
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = scrollDirection

        collectionView.register(MUCollectionPickerCell.self,
                                forCellWithReuseIdentifier: MUCollectionPickerCell.reusableIdentifier)
    }

    // MARK: - Public functions

    public func set(_ items: [String]) {
        self.items = items
    }
}

extension MUCollectionPicker: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = MUCollectionPickerCell.reusableIdentifier
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                            for: indexPath) as? MUCollectionPickerCell else {
                                                                return UICollectionViewCell()
        }

        cell.title = items[indexPath.row]
        cell.itemSelectedColor = itemSelectedColor
        cell.itemUnselectedColor = itemUnselectedColor
        cell.itemFont = itemFont
        cell.itemAlignment = itemAlignment
        cell.indicatorHeight = indicatorHeight
        cell.indicatorWidth = indicatorWidth
        cell.indicatorColor = indicatorColor
        cell.indicatorRadius = indicatorRadius

        return cell
    }
}

extension MUCollectionPicker: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedItem = selectedItem {
            (collectionView.cellForItem(at: selectedItem) as? MUCollectionPickerCell)?.unselect()
            self.selectedItem = nil
        }

        if let cell = collectionView.cellForItem(at: indexPath) as? MUCollectionPickerCell {
            selectedItem = indexPath
            cell.select()
        }

        delegate?.didSelect(item: items[indexPath.row], at: indexPath.row)
    }

    public func collectionView(_ collectionView: UICollectionView,
                               willDisplay cell: UICollectionViewCell,
                               forItemAt indexPath: IndexPath) {
        selectedItem?.row == indexPath.row ?
            (cell as? MUCollectionPickerCell)?.select() : (cell as? MUCollectionPickerCell)?.unselect()
    }
}

extension MUCollectionPicker: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        return delegate?.size(self, at: indexPath) ?? CGSize(width: 50, height: 50)
    }
}
