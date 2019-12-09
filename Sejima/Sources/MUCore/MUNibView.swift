//
//  MUNibView.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 21/02/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import UIKit

/// An object that manages the content for a rectangular area on the screen from a xib file.
open class MUNibView: UIView {
    private var view: UIView?

    /// Return the nib name file to be used. Override it if you use a xib different that the class name.
    open var nibName: String? {
        return type(of: self).description().components(separatedBy: ".").last
    }

    /// Return the bundle that contains the associated xib. Override it if you use a xib different that the class name.
    open var bundle: Bundle? {
        return Bundle(for: type(of: self))
    }

    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override public init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    /// Returns an object initialized from data in a given unarchiver.
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    /// Initializes and returns a newly allocated view object with a zero frame rectangle.
    public convenience init() {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }

    /// Default setup to load the view from a xib file.
    open func xibSetup() {
        let view = loadNib()
        view.backgroundColor = .clear
        addAutolayoutSubview(view)
        self.view = view
    }

    private func loadNib() -> UIView {
        guard let nibName = nibName else {
            return UIView()
        }

        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return UIView()
        }

        return nibView
    }
}
