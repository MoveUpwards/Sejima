//
//  MUTabBar.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 06/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// Class that act like UITabBar with more customizable options.
@IBDesignable
open class MUTabBar: UITabBar {
    private let separatorView = UIView()
    private let backgroundView = UIView()

    private var separatorHeightConstraint: NSLayoutConstraint?

    // MARK: - Background

    /// Describes the MUTabBar's background color
    open override var backgroundColor: UIColor? {
        didSet {
            backgroundView.backgroundColor = backgroundColor
        }
    }

    // MARK: - Color

    /// Describes the MUTabBar's selected color while it shows
    @IBInspectable open dynamic var selectedColor: UIColor = .white {
        didSet {
            tintColor = selectedColor
        }
    }

    /// Describes the MUTabBar's unselected color while it shows
    @available(iOS 10.0, *)
    @IBInspectable open dynamic var unselectedColor: UIColor? {
        get {
            return unselectedItemTintColor
        }
        set {
            unselectedItemTintColor = newValue
        }
    }

    // MARK: - Separator

    /// Describes the MUTabBar's separator color while it shows
    @IBInspectable open dynamic var separatorColor: UIColor = .white {
        didSet {
            separatorView.backgroundColor = separatorColor
        }
    }

    /// Describes the MUTabBar's separator height while it shows
    @IBInspectable open dynamic var separatorHeight: CGFloat = 1.0 {
        didSet {
            separatorHeightConstraint?.constant = separatorHeight
        }
    }

    // MARK: - Public functions

    /// Select item at index (if this index is valid)
    public func select(at index: Int) {
        guard let count = items?.count, index < count else {
            return
        }
        selectedItem = items?[index]
    }

    // MARK: - Private functions

    private func commonInit() {
        barStyle = .default
        barTintColor = .clear
        isTranslucent = false

        separator()
        background()
    }

    private func separator() {
        addSubview(separatorView)
        separatorView.backgroundColor = separatorColor
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: separatorView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: separatorView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: separatorView.trailingAnchor).isActive = true
        separatorHeightConstraint = separatorView.heightAnchor.constraint(equalToConstant: separatorHeight)
        separatorHeightConstraint?.isActive = true
        sendSubviewToBack(separatorView)
    }

    private func background() {
        addSubview(backgroundView)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        addAutolayoutSubview(backgroundView)
        sendSubviewToBack(backgroundView)
    }

    // MARK: - Life cycle functions

    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    /// Returns an object initialized from data in a given unarchiver.
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    convenience init() {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
