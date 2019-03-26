//
//  MUViewController.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 26/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit.UIViewController

extension UIViewController {
    /**
     Animate the bottom inset of the safe area.

    - Parameters:
        - height: The height to add on the safe area bottom.
        - duration: The animation's duration.
        - options: The animation's UIView.AnimationOptions.
        - completion: The optional completion block
     */
    @available(iOS 11.0, *)
    open func animateBottomSafeArea(_ height: CGFloat,
                                    duration: TimeInterval = 0.25,
                                    options: UIView.AnimationOptions = .curveEaseInOut,
                                    completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: 0.0, options: options, animations: { [weak self] in
            self?.additionalSafeAreaInsets.bottom = height
            self?.view.layoutIfNeeded()
        }, completion: { completed in
            completion?(completed)
        })
    }

    /// Return the safeAreaFrame for iOS 9.0+
    internal var areaFrame: CGRect {
        var areaFrame: CGRect
        if #available(iOS 11.0, *) {
            areaFrame = view.safeAreaLayoutGuide.layoutFrame
        } else {
            areaFrame = view.frame
            if !prefersStatusBarHidden {
                areaFrame.origin.y += 20.0
                areaFrame.size.height -= 20.0
            }
            if let navBarHeight = navigationController?.navigationBar.bounds.height {
                areaFrame.origin.y += navBarHeight
                areaFrame.size.height -= navBarHeight
            }
        }
        return areaFrame
    }
}
