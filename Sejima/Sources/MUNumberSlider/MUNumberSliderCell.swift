//
//  MUNumberSliderCell.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 21/01/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// Class that provide a number slider collection view cell.
internal class MUNumberSliderCell: UICollectionViewCell {
    // MARK: - Internal variables

    /// Specifies the cell identifier for reuse.
    internal static let identifer = "NUMBER_CELL"

    /// The number slider text label.
    internal let label = UILabel()

    /// Specifies the unselected label text color.
    internal var unselectedColor: UIColor? {
        didSet {
            label.textColor = unselectedColor
        }
    }

    // MARK: - Private variables

    private var yConstraint: NSLayoutConstraint?

    // MARK: - Life cycle

    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override init(frame: CGRect) {
        super.init(frame: frame)

        label.textAlignment = .center
        addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        yConstraint = label.centerYAnchor.constraint(equalTo: centerYAnchor)
        yConstraint?.isActive = true
    }

    /// Returns an object initialized from data in a given unarchiver.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Performs any clean up necessary to prepare the view for use again.
    override func prepareForReuse() {
        super.prepareForReuse()

        unselect()
    }

    // MARK: - Public functions

    /// Specifies the cell height multiplier.
    public func set(heightMultiplier: CGFloat) {
        guard let constraint = yConstraint else { return }

        yConstraint = NSLayoutConstraint.change(multiplier: heightMultiplier, for: constraint)
    }

    /// Change layout to unselected state.
    public func unselect() {
        label.transform = .identity
        label.textColor = unselectedColor
    }
}
