//
//  MUView+LayoutConstraint.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 13/09/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit.UIView

extension UIView {
    /// Add position's constraints
    /// It can be call 2 times if needed like:
    /// - view1.constraint(.topLeft, to: view2)
    /// - view1.constraint(.bottomRight, to: view2)
    /// => view2 will fit view1
    public func constraint(_ origin: MUAutolayoutPosition,
                           to view: UIView,
                           position: MUAutolayoutPosition? = nil,
                           offset: CGFloat = 0.0) {
        let (selfXAnchor, selfYAnchor) = anchors(for: origin)
        let (viewXAnchor, viewYAnchor) = view.anchors(for: position ?? origin)

        selfXAnchor.addConstraint(to: viewXAnchor, constant: offset)
        selfYAnchor.addConstraint(to: viewYAnchor, constant: offset)
    }

    private func anchors(for origin: MUAutolayoutPosition) -> (NSLayoutXAxisAnchor, NSLayoutYAxisAnchor) {
        let xAnchor: NSLayoutXAxisAnchor
        let yAnchor: NSLayoutYAxisAnchor

        switch origin {
        case .topLeft:
            xAnchor = leftAnchor
            yAnchor = topAnchor
        case .top:
            xAnchor = centerXAnchor
            yAnchor = topAnchor
        case .topRight:
            xAnchor = rightAnchor
            yAnchor = topAnchor
        case .left:
            xAnchor = leftAnchor
            yAnchor = centerYAnchor
        case .center:
            xAnchor = centerXAnchor
            yAnchor = centerYAnchor
        case .right:
            xAnchor = rightAnchor
            yAnchor = centerYAnchor
        case .bottomLeft:
            xAnchor = leftAnchor
            yAnchor = bottomAnchor
        case .bottom:
            xAnchor = centerXAnchor
            yAnchor = bottomAnchor
        case .bottomRight:
            xAnchor = rightAnchor
            yAnchor = bottomAnchor
        }

        return (xAnchor, yAnchor)
    }
}
