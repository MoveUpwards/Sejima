//
//  MUKeyboard.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 14/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit.UIResponder

/// Keyboard protocol.
@available(iOS 11.0, *)
@objc public protocol MUKeyboard: class {
    /// Register or not the keyboard's notifications.
    func useKeyboard(_ isUsed: Bool)

    /// Called immediately prior to the display of the keyboard.
    func keyboardWillShow(_ notif: NSNotification)
    /// Called immediately prior to the dismissal of the keyboard.
    func keyboardWillHide(_ notif: NSNotification)

    /// Called immediately after the display of the keyboard.
    func keyboardDidShow(_ notif: NSNotification)
    /// Called immediately after the dismissal of the keyboard.
    func keyboardDidHide(_ notif: NSNotification)
}

@available(iOS 11.0, *)
extension UIViewController: MUKeyboard {
    /// Register or not the keyboard's notifications.
    open func useKeyboard(_ isUsed: Bool) {
        if isUsed {
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardWillShow(_:)),
                                                   name: UIResponder.keyboardWillShowNotification,
                                                   object: nil)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardDidShow(_:)),
                                                   name: UIResponder.keyboardDidShowNotification,
                                                   object: nil)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardWillHide(_:)),
                                                   name: UIResponder.keyboardWillHideNotification,
                                                   object: nil)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardDidHide(_:)),
                                                   name: UIResponder.keyboardDidHideNotification,
                                                   object: nil)
        } else {
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
        }
    }

    /// Called immediately prior to the display of the keyboard.
    open func keyboardWillShow(_ notif: NSNotification) {
        guard let duration = notif.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curve = notif.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
            let rect = notif.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let bottomSafeArea = UIApplication.shared.keyWindow?.safeAreaInsets.bottom else {
                return
        }

        animateBottomSafeArea(rect.height - bottomSafeArea,
                              duration: duration,
                              options: UIView.AnimationOptions(rawValue: curve))
    }

    /// Called immediately prior to the dismissal of the keyboard.
    open func keyboardWillHide(_ notif: NSNotification) {
        guard let duration = notif.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curve = notif.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {
                return
        }

        animateBottomSafeArea(0.0, duration: duration, options: UIView.AnimationOptions(rawValue: curve))
    }

    /// Called immediately after the display of the keyboard.
    open func keyboardDidShow(_ notif: NSNotification) { }
    /// Called immediately after the dismissal of the keyboard.
    open func keyboardDidHide(_ notif: NSNotification) { }
}
