//
//  MUToast.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 29/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Class that define a card (title, description, indicator and image) with screen animation.
@IBDesignable
open class MUToast: MUNibView {
    @IBOutlet private var markerView: UIView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var header: MUHeader!
    @IBOutlet private var buttons: UIStackView!

    // Buttons inset constraint
    @IBOutlet private var buttonsHeight: NSLayoutConstraint!
    @IBOutlet private var buttonsTop: NSLayoutConstraint!
    @IBOutlet private var buttonsBottom: NSLayoutConstraint!

    // Image inset constraint
    @IBOutlet private var markerWidth: NSLayoutConstraint!

    // Image inset constraint
    @IBOutlet private var imageLeading: NSLayoutConstraint!
    @IBOutlet private var imageWidth: NSLayoutConstraint!

    // Labels inset constraints
    @IBOutlet private var labelsTop: NSLayoutConstraint!
    @IBOutlet private var labelsLeading: NSLayoutConstraint!
    @IBOutlet private var labelsTrailing: NSLayoutConstraint!

    private var onTapBlock: (() -> Void)?
    private var onButtonTapBlock = [((Any) -> Void)?]()

    // MARK: - Background

    /// The toast’s corner radius.
    @IBInspectable open dynamic var cornerRadius: CGFloat = 0.0 {
        didSet {
            markerView.roundCorners([.topLeft, .bottomLeft], value: cornerRadius)
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
    open var titleFont: UIFont {
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
    open var detailFont: UIFont {
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

    /// The Title and Detail text vertical spacing.
    @IBInspectable open var spacing: CGFloat {
        get {
            return header.spacing
        }
        set {
            header.spacing = newValue
        }
    }

    /// The header’s horizontal padding.
    @IBInspectable open var headerHorizontalPadding: CGFloat = 16.0 {
        didSet {
            labelsLeading.constant = headerHorizontalPadding
            labelsTrailing.constant = headerHorizontalPadding
        }
    }

    /// The header’s vertical padding.
    @IBInspectable open var headerVerticalPadding: CGFloat = 16.0 {
        didSet {
            labelsTop.constant = headerVerticalPadding
            buttonsBottom.constant = headerVerticalPadding
        }
    }

    // MARK: - ImageView

    /// Returns the image of the toast.
    @IBInspectable open var icon: UIImage? = nil {
        didSet {
            imageView.image = icon

            updateImageView()
        }
    }

    /// The icon’s left padding.
    @IBInspectable open var iconLeftPadding: CGFloat = 16.0 {
        didSet {
            updateImageView()
        }
    }

    /// The icon’s width.
    @IBInspectable open var iconWidth: CGFloat = 36.0 {
        didSet {
            updateImageView()
        }
    }

    // MARK: - Indicator

    /// The indicator’s width.
    @IBInspectable open dynamic var indicatorWidth: CGFloat = 0.0 {
        didSet {
           markerWidth.constant = indicatorWidth
        }
    }

    /// The indicator’s color.
    @IBInspectable open dynamic var indicatorColor: UIColor = .clear {
        didSet {
            markerView.backgroundColor = indicatorColor
        }
    }

    // MARK: - Drop shadow

    /// The drop shadow color. Default is clear
    @IBInspectable open dynamic var shadowColor: UIColor = .clear {
        didSet {
            setNeedsLayout()
        }
    }

    /// The drop shadow offset. Default is .zero
    @IBInspectable open dynamic var shadowOffset: CGSize = .zero {
        didSet {
            setNeedsLayout()
        }
    }

    /// The drop shadow opacity. Default is none
    @IBInspectable open dynamic var shadowOpacity: Float = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }

    /// The drop shadow radius. Default is none
    @IBInspectable open dynamic var shadowRadius: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }

    // MARK: - Animation

    /// The total duration of the animations, measured in seconds.
    /// If you specify a negative value or 0, the changes are made without animating them.
    @IBInspectable open dynamic var animationDuration: Double = 0.3

    /// The total duration of the display, measured in seconds.
    /// If you specify a negative value or 0, the toast will not hide automatically once animation end.
    @IBInspectable open dynamic var displayDuration: Double = 3.0

    /// The position where the toast will be visible.
    open var displayPosition: MUToastPosition = .top

    /// The toast's priority. Higher will be on top of lower toasts.
    open var displayPriority: MUToastPriority = .info

    // MARK: - Toast layout

    /// The toast’s horizontal padding.
    @IBInspectable open dynamic var horizontalPadding: CGFloat = 16.0

    /// The toast’s vertical padding.
    @IBInspectable open dynamic var verticalPadding: CGFloat = 16.0

    /// The toast’s expected width. If nil it will take the safeArea.width.
    open dynamic var expectedWidth: CGFloat?

    // MARK: - Buttons layout

    /// The buttons horizontal spacing spacing.
    @IBInspectable open var buttonSpacing: CGFloat = 16.0 {
        didSet {
            buttons.spacing = buttonSpacing
            buttonsTop.constant = buttonHeight > 0 ? buttonSpacing : 0
        }
    }

    /// The buttons height.
    @IBInspectable open dynamic var buttonHeight: CGFloat = 0.0 {
        didSet {
            buttonsHeight.constant = buttonHeight
        }
    }

    // MARK: - Life cycle

    /// Default setup to load the view from a xib file.
    open override func xibSetup() {
        super.xibSetup()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        applyShadow()
    }

    // MARK: - Animation functions

    /// Performs a show animation using the animation's values.
    open func show(in vc: UIViewController, onTap: (() -> Void)? = nil, completion: ((Bool) -> Void)? = nil) {
        onTapBlock = onTap
        add(in: vc)

        showingAnimation(completion: { [weak self] _ in
            guard let displayDuration = self?.displayDuration, displayDuration > 0 else { return }

            DispatchQueue.main.asyncAfter(deadline: .now() + displayDuration, execute: {
                self?.hidingAnimation(completion)
            })
        })
    }

    /// Optional: If you want to hide the toast sooner than the normal animation.
    open func hide(completion: ((Bool) -> Void)? = nil) {
        hidingAnimation(completion)
    }

    // MARK: - Public functions

    public func add(view: UIView, tapBlock: ((Any) -> Void)? = nil) {
        buttons.addArrangedSubview(view)
        onButtonTapBlock.append(tapBlock)

        guard let button = view as? MUButton, tapBlock != nil else { return }
        button.delegate = self
    }

    // MARK: - Private IBAction functions

    @IBAction private func didTap(_ sender: UITapGestureRecognizer) {
        onTapBlock?()
    }

    // MARK: - Private variables

    private func applyShadow() {
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
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

    // MARK: - Private functions

    private func updateImageView() {
        imageLeading.constant = icon == nil ? 0.0 : iconLeftPadding
        imageWidth.constant = icon == nil ? 0.0 : iconWidth
    }

    private func expectedSize() -> CGSize {
        guard let width = expectedWidth else { return .zero }
        var size = CGSize(width: width - 2.0 * horizontalPadding, height: 0.0)

        var headerWidth = size.width - 2.0 * headerHorizontalPadding
        if icon != nil {
            headerWidth -= iconLeftPadding + iconWidth * 2
        }

        var headerHeight = header.expectedHeight(for: headerWidth)
        if headerHeight < iconWidth, icon != nil {
            headerHeight = iconWidth
        }

        if buttonHeight > 0 {
            headerHeight += buttonHeight + headerVerticalPadding
        }

        size.height = headerHeight + 2.0 * headerVerticalPadding

        return size
    }

    private func add(in vc: UIViewController) {
        let safeArea = vc.areaFrame
        if expectedWidth == nil {
            expectedWidth = safeArea.width
        }
        let size = expectedSize()
        let origin: CGFloat

        if displayPosition == .top {
            origin = safeArea.origin.y + verticalPadding
            transform = CGAffineTransform(translationX: 0.0, y: -(origin + size.height))
        } else {
            origin = safeArea.origin.y + safeArea.height - size.height - verticalPadding
            transform = CGAffineTransform(translationX: 0.0, y: vc.view.frame.height - origin)
        }

        let toastView: UIView?
        switch displayPriority {
        case .alert:
            toastView = nil // Default case on top of all views
        case .warning:
            toastView = getLowestToast(in: vc.view, priorities: [.alert])
        case .info:
            toastView = getLowestToast(in: vc.view, priorities: [.alert, .warning])
        }

        let leading = safeArea.origin.x + safeArea.size.width * 0.5 - size.width * 0.5
        let width = size.width / vc.view.bounds.width
        if let toastView = toastView {
            vc.view.insertAutolayoutSubview(self, belowSubview: toastView,
                                            top: origin, height: nil, leading: leading, width: width)
        } else {
            vc.view.addAutolayoutSubview(self, top: origin, height: nil, leading: leading, width: width)
        }
    }

    private func getLowestToast(in vcView: UIView, priorities: [MUToastPriority]) -> UIView? {
        var returnView: UIView?
        for subview in vcView.subviews {
            if let v = subview as? MUToast, priorities.contains(v.displayPriority) {
                returnView = v
                break
            }
        }
        return returnView
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
            guard let strongSelf = self else { return }
            strongSelf.transform = strongSelf.hideTransform
        }, completion: { [weak self] completed in
            self?.onTapBlock = nil
            self?.removeFromSuperview()
            completion?(completed)
        })
    }
}

extension MUToast: MUButtonDelegate {
    public func didTap(button: MUButton) {
        guard let idx = buttons.arrangedSubviews.firstIndex(of: button) else { return }
        onButtonTapBlock[idx]?(button)
    }
} // swiftlint:disable:this file_length
