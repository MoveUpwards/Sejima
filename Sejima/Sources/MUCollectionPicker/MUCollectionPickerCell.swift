//
//  MUCollectionPickerCell.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 18/12/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit

public class MUCollectionPickerCell: UICollectionViewCell {
    static let reusableIdentifier = "MUCollectionPickerCell"

    /// The number slider text label.
    internal let label = UIButton(type: .custom)
    internal let indicator = UIView()

    // MARK: - Private variables

    private var yConstraint: NSLayoutConstraint?

    private var indicatorWidthConstraint: NSLayoutConstraint?
    private var indicatorHeightConstraint: NSLayoutConstraint?

    // MARK: - Indicator view

    /// Define the indicator's width
    internal var indicatorWidth: CGFloat = 1.0 {
        didSet {
            indicatorWidthConstraint?.constant = indicatorWidth
            indicator.updateConstraints()
        }
    }

    /// Define the indicator's width
    internal var indicatorHeight: CGFloat = 1.0 {
        didSet {
            indicatorHeightConstraint?.constant = indicatorHeight
            indicator.updateConstraints()
        }
    }

    /// Define the indicator's width
    internal var indicatorRadius: CGFloat = 0.0 {
        didSet {
            indicator.layer.cornerRadius = indicatorRadius
        }
    }

    /// Define the indicator's color
    internal var indicatorColor: UIColor = .white {
        didSet {
            indicator.backgroundColor = indicatorColor
        }
    }

    // MARK: - Item view

    /// The button’s font.
    internal var itemFont: UIFont = .systemFont(ofSize: 17.0, weight: .regular) {
        didSet {
            label.titleLabel?.font = itemFont
        }
    }

    /// The button’s horizontal alignment.
    internal var itemAlignment: NSTextAlignment = .center {
        didSet {
            label.titleLabel?.textAlignment = itemAlignment
        }
    }

    /// Optional: The IBInspectable version of the button’s horizontal alignment.
    internal var itemAlignmentInt: Int {
        get {
            return itemAlignment.rawValue
        }
        set {
            itemAlignment = NSTextAlignment(rawValue: newValue) ?? .center
        }
    }

    /// The button’s title color.
    internal var itemSelectedColor: UIColor = .white {
        didSet {
            label.setTitleColor(itemSelectedColor, for: .selected)
        }
    }

    internal var title: String = "" {
        didSet {
            label.setTitle(title, for: .normal)
        }
    }

    /// The button’s title color.
    @IBInspectable open dynamic var itemUnselectedColor: UIColor = .black {
           didSet {
               label.setTitleColor(itemUnselectedColor, for: .normal)
           }
       }

    // MARK: - Life cycle

    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override init(frame: CGRect) {
        super.init(frame: frame)

        indicator.isHidden = true
        indicator.layer.masksToBounds = true
        indicator.layer.cornerRadius = indicatorRadius

        addSubview(label)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        yConstraint = label.centerYAnchor.constraint(equalTo: centerYAnchor)
        yConstraint?.isActive = true

        label.addAutolayoutSubview(indicator,
                             origin: .center,
                             position: .center)
        indicatorWidthConstraint = indicator.widthAnchor.constraint(equalTo: widthAnchor, multiplier: indicatorWidth)
        indicatorWidthConstraint?.isActive = true
        indicatorHeightConstraint = indicator.widthAnchor.constraint(equalTo: widthAnchor, multiplier: indicatorHeight)
        indicatorHeightConstraint?.isActive = true

        label.sendSubviewToBack(indicator)
    }

    /// Returns an object initialized from data in a given unarchiver.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Performs any clean up necessary to prepare the view for use again.
    override public func prepareForReuse() {
        super.prepareForReuse()

        unselect()
    }

    // MARK: - Public functions

    /// Change layout to unselected state.
    public func select() {
        label.isSelected = true
        indicator.isHidden = false
    }

    /// Change layout to unselected state.
    public func unselect() {
        label.isSelected = false
        indicator.isHidden = true
    }
}
