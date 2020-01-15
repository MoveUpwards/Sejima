//
//  MUNumberSlider.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 18/01/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Class that provide a custom number slider.
@IBDesignable
open class MUNumberSlider: MUNibView {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var collectionView: UICollectionView!

    // MARK: - Private variables

    private let velocityMultiplier = CGFloat(3.5) // Tune it if EndDragging is laggy or speedy

    // MARK: - Public variables

    /// Returns the current item index.
    open var currentIndex: Int {
        let currentOffset = collectionView.contentInset.left + collectionView.contentOffset.x
        let itemWidth = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize.width ?? 0.0
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? 0.0
        let pageWidth = itemWidth + spacing
        return Int(0.5 + currentOffset / pageWidth)
    }

    /// The current item value.
    open var currentValue: Int {
        get {
            return minValue + currentIndex
        }
        set {
            guard newValue >= minValue, newValue <= maxValue else {
                return
            }
            collectionView.scrollToItem(at: IndexPath(row: newValue - minValue, section: 0),
                                        at: .left,
                                        animated: true)
        }
    }

    // MARK: - Public UIAppearence variables

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var selectedColor: UIColor = .white {
        didSet {
            collectionView.reloadData()
        }
    }

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var unselectedColor: UIColor = .black {
        didSet {
            collectionView.reloadData()
        }
    }

    /// Define the inset of the background and chart
    @objc open dynamic var font: UIFont = .systemFont(ofSize: 16, weight: .regular) {
        didSet {
            collectionView.reloadData()
        }
    }

    /// Define the inset of the background and chart
    @objc open dynamic var cellWidth: CGFloat = 40.0 {
        didSet {
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }

    /// Define the inset of the background and chart
    @objc open dynamic var heightMultiplier: CGFloat = 1.0 {
        didSet {
            collectionView.reloadData()
        }
    }

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var image: UIImage? = nil {
        didSet {
            imageView.image = image
        }
    }

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var minValue: Int = 0 {
        didSet {
            collectionView.reloadData()
        }
    }

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var maxValue: Int = 100 {
        didSet {
            collectionView.reloadData()
        }
    }

    /// Define the scale for current collection item
    @IBInspectable open dynamic var selectedScaleValue: CGFloat = 2.0 {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: Private functions

    private func updateCollectionView() {
        let inset = (bounds.width - cellWidth) * 0.5
        collectionView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)

        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

        flowLayout.itemSize = CGSize(width: cellWidth, height: bounds.height)
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
    }

    // MARK: - Life cycle functions

    /// Default setup to load the view from a xib file.
    open override func xibSetup() {
        super.xibSetup()

        collectionView.register(MUNumberSliderCell.self, forCellWithReuseIdentifier: MUNumberSliderCell.identifer)
        updateCollectionView()
    }

    /// Lays out subviews.
    override open func layoutSubviews() {
        super.layoutSubviews()

        updateCollectionView()
    }
}

// MARK: - UICollectionView DataSource

extension MUNumberSlider: UICollectionViewDataSource {
    /// Asks your data source object for the cell that corresponds to the specified item in the collection view.
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maxValue - minValue + 1
    }

    /// Asks your data source object for the cell that corresponds to the specified item in the collection view.
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MUNumberSliderCell.identifer,
                                                      for: indexPath) as? MUNumberSliderCell
        cell?.label.text = "\(minValue + indexPath.row)"
        cell?.label.font = font
        cell?.unselectedColor = unselectedColor
        cell?.set(heightMultiplier: heightMultiplier)
        if indexPath.row == currentIndex {
            cell?.label.transform = CGAffineTransform(scaleX: selectedScaleValue, y: selectedScaleValue)
            cell?.label.textColor = selectedColor
        }
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - UICollectionView Delegate

extension MUNumberSlider: UICollectionViewDelegate {
    /// Tells the delegate when the user finishes scrolling the content.
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                          withVelocity velocity: CGPoint,
                                          targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset

        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

        let maxIndex = CGFloat(maxValue - minValue)
        var expectedIndex = 0.5 + (collectionView.contentInset.left + scrollView.contentOffset.x +
            flowLayout.itemSize.width * velocity.x * velocityMultiplier) /
            (flowLayout.itemSize.width + flowLayout.minimumLineSpacing)

        if expectedIndex < 0 {
            expectedIndex = 0
        } else if expectedIndex > maxIndex {
            expectedIndex = maxIndex
        }

        targetContentOffset.pointee.x = -collectionView.contentInset.left +
            CGFloat(Int(expectedIndex)) * flowLayout.itemSize.width
    }

    /// Tells the delegate when the user scrolls the content view within the receiver.
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

        collectionView.subviews.forEach { ($0 as? MUNumberSliderCell)?.unselect() }

        let currentOffset = collectionView.contentInset.left + scrollView.contentOffset.x
        let pageWidth = flowLayout.itemSize.width + flowLayout.minimumLineSpacing
        let currentIndex = Int(0.5 + currentOffset / pageWidth)
        let itemOffset = currentOffset - CGFloat(currentIndex) * pageWidth
        let mainPercent = abs(itemOffset) / pageWidth
        let mainScale = selectedScaleValue - mainPercent * (selectedScaleValue - 1.0)

        let mainCell = collectionView.cellForItem(at: IndexPath(row: currentIndex, section: 0)) as? MUNumberSliderCell
        mainCell?.label.textColor = selectedColor.interpolate(to: unselectedColor, fraction: mainPercent)
        mainCell?.label.transform = CGAffineTransform(scaleX: mainScale, y: mainScale)

        let nextIndex = currentIndex + (itemOffset > 0 ? 1 : -1)
        let nextPercent = 1.0 + mainPercent * (selectedScaleValue - 1)

        let nextCell = collectionView.cellForItem(at: IndexPath(row: nextIndex, section: 0)) as? MUNumberSliderCell
        nextCell?.label.textColor = selectedColor.interpolate(to: unselectedColor, fraction: 1.0 - mainPercent)
        nextCell?.label.transform = CGAffineTransform(scaleX: nextPercent, y: nextPercent)
    }
}
