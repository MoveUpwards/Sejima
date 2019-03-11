//
//  MUToast.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 29/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// Class that define a card (title, description and image) with screen animation.
@IBDesignable
open class MUToast: MUNibView {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var header: MUHeader!

    // Image inset constraint
    @IBOutlet private var imageLeading: NSLayoutConstraint!
    @IBOutlet private var imageWidth: NSLayoutConstraint!

    // Labels inset constraints
    @IBOutlet private var labelsTop: NSLayoutConstraint!
    @IBOutlet private var labelsBottom: NSLayoutConstraint!
    @IBOutlet private var labelsLeading: NSLayoutConstraint!
    @IBOutlet private var labelsTrailing: NSLayoutConstraint!

    /// Toast possible position
    public enum Position {
        /// Top of the screen
        case top
        /// Bottom of the screen
        case bottom
    }

    /// Toast priority order
    public enum Priority {
        /// Alert immediatly
        case alert
        /// Warning something important
        case warning
        /// Info to show
        case info
    }

    // MARK: - Background

    /// The toast’s corner radius.
    @IBInspectable open dynamic var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    // MARK: - Header

    /// The current title.
    @IBInspectable open var title: String {
        get {
            return header.title
        }
        set {
            header.title = newValue
        }
    }

    /// The title’s font.
    @objc open dynamic var titleFont: UIFont {
        get {
            return header.titleFont
        }
        set {
            header.titleFont = newValue
        }
    }

    /// The title’s text color.
    @IBInspectable open dynamic var titleColor: UIColor {
        get {
            return header.titleColor
        }
        set {
            header.titleColor = newValue
        }
    }

    /// The current detail description.
    @IBInspectable open var detail: String {
        get {
            return header.detail
        }
        set {
            header.detail = newValue
        }
    }

    /// The detail’s font.
    @objc open dynamic var detailFont: UIFont {
        get {
            return header.detailFont
        }
        set {
            header.detailFont = newValue
        }
    }

    /// The detail’s text color.
    @IBInspectable open dynamic var detailColor: UIColor {
        get {
            return header.detailColor
        }
        set {
            header.detailColor = newValue
        }
    }

    /// The text’s horizontal alignment.
    @objc open dynamic var textAlignment: NSTextAlignment {
        get {
            return header.textAlignment
        }
        set {
            header.textAlignment = newValue
        }
    }

    /// Optional: The IBInspectable version of the text’s horizontal alignment.
    @IBInspectable open var textAlignmentInt: Int {
        get {
            return header.textAlignmentInt
        }
        set {
            header.textAlignmentInt = newValue
        }
    }

    /// The text’s vertical spacing.
    @IBInspectable open dynamic var spacing: CGFloat {
        get {
            return header.spacing
        }
        set {
            header.spacing = newValue
        }
    }

    /// The header’s horizontal padding.
    @IBInspectable open dynamic var headerHorizontalPadding: CGFloat = 16.0 {
        didSet {
            labelsLeading.constant = headerHorizontalPadding
            labelsTrailing.constant = headerHorizontalPadding
        }
    }

    /// The header’s vertical padding.
    @IBInspectable open dynamic var headerVerticalPadding: CGFloat = 16.0 {
        didSet {
            labelsTop.constant = headerVerticalPadding
            labelsBottom.constant = headerVerticalPadding
        }
    }

    // MARK: - ImageView

    /// Returns the image of the toast.
    @IBInspectable open dynamic var icon: UIImage? = nil {
        didSet {
            imageView.image = icon

            updateImageView()
        }
    }

    /// The icon’s left padding.
    @IBInspectable open dynamic var iconLeftPadding: CGFloat = 16.0 {
        didSet {
            updateImageView()
        }
    }

    /// The icon’s width.
    @IBInspectable open dynamic var iconWidth: CGFloat = 64.0 {
        didSet {
            imageWidth.constant = iconWidth
        }
    }

    // MARK: - Animation

    /// The total duration of the animations, measured in seconds.
    /// If you specify a negative value or 0, the changes are made without animating them.
    @IBInspectable open dynamic var animationDuration: Double = 0.3

    /// The total duration of the display, measured in seconds.
    /// If you specify a negative value or 0, the toast will hide as soon as the animation end.
    @IBInspectable open dynamic var displayDuration: Double = 3.0

    /// The position where the toast will be visible.
    open var displayPosition: Position = .top

    /// The toast's priority. Higher will be on top of lower toasts.
    open var displayPriority: Priority = .info

    /// The toast’s horizontal padding.
    @IBInspectable open dynamic var horizontalPadding: CGFloat = 16.0

    /// The toast’s vertical padding.
    @IBInspectable open dynamic var verticalPadding: CGFloat = 16.0

    // MARK: - Life cycle

    /// Default setup to load the view from a xib file.
    open override func xibSetup() {
        super.xibSetup()

        layer.masksToBounds = true
    }

    // MARK: - Animation functions

    /// Performs a show animation using the animation's values.
    open func show(in vc: UIViewController, completion: ((Bool) -> Void)? = nil) {
        add(in: vc)

        showingAnimation(completion: { [weak self] _ in
            guard let displayDuration = self?.displayDuration else {
                return
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + displayDuration, execute: {
                self?.hidingAnimation(completion)
            })
        })
    }

    // MARK: - Private functions

    private func areaFrame(of vc: UIViewController) -> CGRect {
        var areaFrame: CGRect
        if #available(iOS 11.0, *) {
            areaFrame = vc.view.safeAreaLayoutGuide.layoutFrame
        } else {
            areaFrame = vc.view.frame
            if !vc.prefersStatusBarHidden {
                areaFrame.origin.y += 20.0
                areaFrame.size.height -= 20.0
            }
            if let navBarHeight = vc.navigationController?.navigationBar.bounds.height {
                areaFrame.origin.y += navBarHeight
                areaFrame.size.height -= navBarHeight
            }
        }
        return areaFrame
    }

    private func updateImageView() {
        if icon == nil {
            imageLeading.constant = 0
        } else {
            imageLeading.constant = iconLeftPadding
        }
    }

    private func add(in vc: UIViewController) {
        let safeArea = areaFrame(of: vc)
        let width = safeArea.width - 2.0 * horizontalPadding
        let headerWidth = width - iconLeftPadding - iconWidth - 2.0 * headerHorizontalPadding

        var headerHeight = header.expectedHeight(for: headerWidth)
        if headerHeight < iconWidth {
            headerHeight = iconWidth
        }
        let height = headerHeight + 2.0 * headerVerticalPadding

        let origin: CGFloat
        if displayPosition == .top {
            origin = safeArea.origin.y + verticalPadding
            transform = CGAffineTransform(translationX: 0.0, y: -(origin + height))
        } else {
            origin = safeArea.origin.y + safeArea.height - height - verticalPadding
            transform = CGAffineTransform(translationX: 0.0, y: vc.view.frame.height - origin)
        }

        switch displayPriority {
        case .alert:
            break // Default case on top of all views
        case .warning:
            if let toastView = getLowestToast(in: vc.view, priorities: [.alert]) {
                vc.view.insertAutolayoutSubview(self,
                                                belowSubview: toastView,
                                                top: origin,
                                                height: nil,
                                                leading: safeArea.origin.x + horizontalPadding,
                                                width: width / vc.view.bounds.width)
                return
            }
        case .info:
            if let toastView = getLowestToast(in: vc.view, priorities: [.alert, .warning]) {
                vc.view.insertAutolayoutSubview(self,
                                                belowSubview: toastView,
                                                top: origin,
                                                height: nil,
                                                leading: safeArea.origin.x + horizontalPadding,
                                                width: width / vc.view.bounds.width)
                return
            }
        }

        vc.view.addAutolayoutSubview(self,
                                     top: origin,
                                     height: nil,
                                     leading: safeArea.origin.x + horizontalPadding,
                                     width: width / vc.view.bounds.width)
    }

    private func getLowestToast(in vcView: UIView, priorities: [Priority]) -> UIView? {
        var returnView: UIView?
        myLoop: for subview in vcView.subviews {
            if let v = subview as? MUToast, priorities.contains(v.displayPriority) {
                returnView = v
                break myLoop
            }
        }
        return returnView
    }

    private var hideTransform: CGAffineTransform {
        switch displayPosition {
        case .top:
            return CGAffineTransform(translationX: 0.0, y: -(frame.origin.y + frame.height))
        case .bottom:
            guard let superviewFrame = superview?.frame else {
                return .identity
            }
            return CGAffineTransform(translationX: 0.0, y: superviewFrame.height - frame.origin.y)
        }
    }

    private func showingAnimation(completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: { [weak self] in
                        self?.transform = .identity
            }, completion: { completed in
                completion?(completed)
        })
    }

    private func hidingAnimation(_ completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.transform = strongSelf.hideTransform
        }, completion: { [weak self] completed in
            self?.removeFromSuperview()
            completion?(completed)
        })
    }
}
