//
//  MUView.swift
//  MUCore
//
//  Created by Damien Noël Dubuisson on 21/02/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import UIKit

extension UIView {
    /// Adds a view to the end of the receiver’s list of subviews,
    /// and then apply autolayout contraints to fit the current view.
    internal func addAutolayoutSubview(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
}
