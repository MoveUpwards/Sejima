//
//  MUView+Autolayout.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 13/09/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit.UIView

extension UIView {
    /// Add a view to the origin point with width and height multiplier from the parent view
    public func addAutolayoutSubview(_ view: UIView,
                                     origin: MUAutolayoutPosition,
                                     position: MUAutolayoutPosition? = nil,
                                     height: CGFloat? = 1.0,
                                     width: CGFloat? = 1.0) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        constraint(origin, to: view, position: position)
        if let width = width {
            view.widthAnchor.addConstraint(to: widthAnchor, multiplier: width)
        }
        if let height = height {
            view.heightAnchor.addConstraint(to: heightAnchor, multiplier: height)
        }
    }

    /// Adds a view to the end of the receiver’s list of subviews
    /// and then apply autolayout contraints to fit the current view.
    public func addAutolayoutSubview(_ view: UIView,
                                     top: CGFloat? = 0.0,
                                     height: CGFloat? = 1.0,
                                     leading: CGFloat? = 0.0,
                                     width: CGFloat? = 1.0) {
        addSubview(view)
        applyAutolayout(on: view, top: top, height: height, leading: leading, width: width)
    }

    /// Inserts a view below another view in the view hierarchy
    /// and then apply autolayout contraints to fit the current view.
    public func insertAutolayoutSubview(_ view: UIView,
                                        belowSubview siblingSubview: UIView,
                                        top: CGFloat? = 0.0,
                                        height: CGFloat? = 1.0,
                                        leading: CGFloat? = 0.0,
                                        width: CGFloat? = 1.0) {
        insertSubview(view, belowSubview: siblingSubview)
        applyAutolayout(on: view, top: top, height: height, leading: leading, width: width)
    }

    /// Inserts a view above another view in the view hierarchy
    /// and then apply autolayout contraints to fit the current view.
    public func insertAutolayoutSubview(_ view: UIView,
                                        aboveSubview siblingSubview: UIView,
                                        top: CGFloat? = 0.0,
                                        height: CGFloat? = 1.0,
                                        leading: CGFloat? = 0.0,
                                        width: CGFloat? = 1.0) {
        insertSubview(view, aboveSubview: siblingSubview)
        applyAutolayout(on: view, top: top, height: height, leading: leading, width: width)
    }

    // MARK: - Private functions

    // Simple function to add constraint on same anchor like top-top or bottomRight-bottomRight
    private func applyAutolayout(on view: UIView,
                                 top: CGFloat? = nil,
                                 bottom: CGFloat? = nil,
                                 centerY: CGFloat? = nil,
                                 height: CGFloat? = nil,
                                 leading: CGFloat? = nil,
                                 trailing: CGFloat? = nil,
                                 centerX: CGFloat? = nil,
                                 width: CGFloat? = nil) {
        view.translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            view.topAnchor.addConstraint(to: topAnchor, constant: top)
        } else if let bottom = bottom {
            view.bottomAnchor.addConstraint(to: bottomAnchor, constant: bottom)
        } else if let centerY = centerY {
            view.centerYAnchor.addConstraint(to: centerYAnchor, constant: centerY)
        }

        if let height = height {
            view.heightAnchor.addConstraint(to: heightAnchor, multiplier: height)
        }

        if let leading = leading {
            view.leadingAnchor.addConstraint(to: leadingAnchor, constant: leading)
        } else if let trailing = trailing {
            view.trailingAnchor.addConstraint(to: trailingAnchor, constant: trailing)
        } else if let centerX = centerX {
            view.centerXAnchor.addConstraint(to: centerXAnchor, constant: centerX)
        }

        if let width = width {
            view.widthAnchor.addConstraint(to: widthAnchor, multiplier: width)
        }
    }
}
