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

    /// Load a nib file as the same class' name or if it not exists, a default view.
    private func loadNib() -> UIView {
        guard let nibName = type(of: self).description().components(separatedBy: ".").last else {
            return UIView()
        }

        let nib = UINib(nibName: nibName, bundle: Bundle(for: type(of: self)))
        guard let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return UIView()
        }

        return nibView
    }
}
