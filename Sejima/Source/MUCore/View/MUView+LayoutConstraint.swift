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
                           xOffset: CGFloat = 0.0,
                           yOffset: CGFloat = 0.0) {
        let (selfXAnchor, selfYAnchor) = anchors(for: origin)
        let (viewXAnchor, viewYAnchor) = view.anchors(for: position ?? origin)

        if let viewXAnchor = viewXAnchor {
            selfXAnchor?.addConstraint(to: viewXAnchor, constant: xOffset)
        }
        if let viewYAnchor = viewYAnchor {
            selfYAnchor?.addConstraint(to: viewYAnchor, constant: yOffset)
        }
    }

    private func anchors(for origin: MUAutolayoutPosition) -> (NSLayoutXAxisAnchor?, NSLayoutYAxisAnchor?) {
        var xAnchor: NSLayoutXAxisAnchor?
        var yAnchor: NSLayoutYAxisAnchor?

        switch origin {
        case .topLeft:
            xAnchor = leftAnchor
            yAnchor = topAnchor
        case .topCenter:
            xAnchor = centerXAnchor
            yAnchor = topAnchor
        case .topRight:
            xAnchor = rightAnchor
            yAnchor = topAnchor
        case .leftCenter:
            xAnchor = leftAnchor
            yAnchor = centerYAnchor
        case .center:
            xAnchor = centerXAnchor
            yAnchor = centerYAnchor
        case .rightCenter:
            xAnchor = rightAnchor
            yAnchor = centerYAnchor
        case .bottomLeft:
            xAnchor = leftAnchor
            yAnchor = bottomAnchor
        case .bottomCenter:
            xAnchor = centerXAnchor
            yAnchor = bottomAnchor
        case .bottomRight:
            xAnchor = rightAnchor
            yAnchor = bottomAnchor
        case .top:
            yAnchor = topAnchor
        case .left:
            xAnchor = leftAnchor
        case .right:
            xAnchor = rightAnchor
        case .bottom:
            yAnchor = bottomAnchor
        case .centerX:
            xAnchor = centerXAnchor
        case .centerY:
            yAnchor = centerYAnchor
        }

        return (xAnchor, yAnchor)
    }
}
