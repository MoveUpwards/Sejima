//
//  MUView.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 21/02/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import UIKit

extension UIView {
    /// Adds a view to the end of the receiver’s list of subviews
    /// and then apply autolayout contraints to fit the current view.
    internal func addAutolayoutSubview(_ view: UIView,
                                       top: CGFloat? = 0.0,
                                       height: CGFloat? = 1.0,
                                       leading: CGFloat? = 0.0,
                                       width: CGFloat? = 1.0) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            view.topAnchor.constraint(equalTo: topAnchor, constant: top).isActive = true
        }
        if let height = height {
            view.heightAnchor.constraint(equalTo: heightAnchor, multiplier: height).isActive = true
        }
        if let leading = leading {
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leading).isActive = true
        }
        if let width = width {
            view.widthAnchor.constraint(equalTo: widthAnchor, multiplier: width).isActive = true
        }
    }
}
