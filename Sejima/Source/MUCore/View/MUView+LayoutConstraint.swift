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

    //swiftlint:disable:next cyclomatic_complexity
    private func anchors(for origin: MUAutolayoutPosition) -> (NSLayoutXAxisAnchor?, NSLayoutYAxisAnchor?) {
        switch origin {
        case .topLeft:
            return (leftAnchor, topAnchor)
        case .topCenter:
            return (centerXAnchor, topAnchor)
        case .topRight:
            return (rightAnchor, topAnchor)
        case .leftCenter:
            return (leftAnchor, centerYAnchor)
        case .center:
            return (centerXAnchor, centerYAnchor)
        case .rightCenter:
            return (rightAnchor, centerYAnchor)
        case .bottomLeft:
            return (leftAnchor, bottomAnchor)
        case .bottomCenter:
            return (centerXAnchor, bottomAnchor)
        case .bottomRight:
            return (rightAnchor, bottomAnchor)
        case .top:
            return (nil, topAnchor)
        case .left:
            return (leftAnchor, nil)
        case .right:
            return (rightAnchor, nil)
        case .bottom:
            return (nil, bottomAnchor)
        case .centerX:
            return (centerXAnchor, nil)
        case .centerY:
            return (nil, centerYAnchor)
        }
    }
}
