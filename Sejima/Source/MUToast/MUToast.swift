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
    @IBOutlet private var title: UILabel!
    @IBOutlet private var desc: UILabel!

    // Image inset constraint
    @IBOutlet private var imageTop: NSLayoutConstraint!
    @IBOutlet private var imageLeading: NSLayoutConstraint!
    @IBOutlet private var imageBottom: NSLayoutConstraint!

    // Labels inset constraint
    @IBOutlet private var labelsLeading: NSLayoutConstraint!
    @IBOutlet private var labelsTrailing: NSLayoutConstraint!
    @IBOutlet private var labelsVerticalInset: NSLayoutConstraint!

    /// Toast possible position
    public enum Position {
        case top
        case bottom
    }

    /// Toast priority order
    public enum Priority {
        case alert
        case warning
        case info
    }

    // MARK: - Background

    /// Describes the NavigationNavBar's background color appearance while it shows
    @IBInspectable open dynamic var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    // MARK: - Labels

    @objc open dynamic var headerFont: UIFont = .systemFont(ofSize: 34, weight: .regular) {
        didSet {
            setNeedsLayout()
        }
    }

    @objc open dynamic var detailFont: UIFont = .systemFont(ofSize: 14, weight: .semibold) {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's background color appearance while it shows
    @IBInspectable open dynamic var headerColor: UIColor = .white {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's background color appearance while it shows
    @IBInspectable open dynamic var detailColor: UIColor = .white {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's background color appearance while it shows
    @IBInspectable open var header: String = "" {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's background color appearance while it shows
    @IBInspectable open var detail: String = "" {
        didSet {
            setNeedsLayout()
        }
    }

    @objc open dynamic var textAlignment: NSTextAlignment = .left {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's separator background color appearance while it shows
    @IBInspectable open dynamic var textAlignmentInt: Int = 0 {
        didSet {
            textAlignment = NSTextAlignment(rawValue: textAlignmentInt) ?? .left
        }
    }

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var textHorizontalInset: CGFloat = 16.0 {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var textVerticalInset: CGFloat = 16.0 {
        didSet {
            setNeedsLayout()
        }
    }

    // MARK: - ImageVIew

    /// Describes the NavigationNavBar's background color appearance while it shows
    @IBInspectable open dynamic var icon: UIImage? {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var iconLeftInset: CGFloat = 16.0 {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var iconVerticalInset: CGFloat = 16.0 {
        didSet {
            setNeedsLayout()
        }
    }

    // MARK: - Animation

    /// Describes the NavigationNavBar's background color appearance while it shows
    @objc open dynamic var animationDuration: TimeInterval = 0.3 {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's background color appearance while it shows
    @objc open dynamic var displayDuration: TimeInterval = 3.0 {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's background color appearance while it shows
    open var displayPosition: Position = .top {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the NavigationNavBar's background color appearance while it shows
    open var displayPriority: Priority = .info {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var horizontalPadding: CGFloat = 16.0 {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var verticalPadding: CGFloat = 16.0 {
        didSet {
            setNeedsLayout()
        }
    }

    // MARK: - Life cycle

    open override func xibSetup() {
        super.xibSetup()

        layer.masksToBounds = true
    }

    override open func layoutSubviews() {
        super.layoutSubviews()

        title.textColor = headerColor
        title.font = headerFont
        title.text = header
        title.textAlignment = textAlignment

        desc.textColor = detailColor
        desc.font = detailFont
        desc.text = detail
        desc.textAlignment = textAlignment

        labelsLeading.constant = textHorizontalInset
        labelsTrailing.constant = textHorizontalInset
        labelsVerticalInset.constant = textVerticalInset

        if icon == nil {
            hideImageView()
        } else {
            imageView.image = icon
            setupImageView()
        }
    }

    // MARK: - Animation functions

    open func show(in vc: UIViewController, completion: ((Bool) -> Void)? = nil) {
        var areaFrame: CGRect
        if #available(iOS 11.0, *) {
            areaFrame = vc.view.safeAreaLayoutGuide.layoutFrame
        } else {
            areaFrame = vc.view.frame
            if !vc.prefersStatusBarHidden {
                areaFrame.origin.y += 20.0
            }
            if let navBarHeight = vc.navigationController?.navigationBar.bounds.height {
                areaFrame.origin.y += navBarHeight
            }
        }
        let width = areaFrame.width - 2.0 * horizontalPadding
        let height = width * 120.0 / 375.0 // Aspect ratio of 375:120

        frame = CGRect(x: areaFrame.origin.x + horizontalPadding,
                       y: displayPosition == .top ?
                            areaFrame.origin.y + verticalPadding :
                            areaFrame.origin.y + areaFrame.height - height - verticalPadding,
                       width: width,
                       height: height)
        add(in: vc.view)

        transform = hideTransform
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

    private func hideImageView() {
        imageLeading.constant = 0
        imageTop.constant = bounds.height * 0.5
        imageBottom.constant = bounds.height * 0.5
    }

    private func setupImageView() {
        imageLeading.constant = iconLeftInset
        imageTop.constant = iconVerticalInset
        imageBottom.constant = iconVerticalInset
    }

    private func add(in vcView: UIView) {
        switch displayPriority {
        case .alert:
            break // Default case on top of all views
        case .warning:
            if let toastView = getLowestToast(in: vcView, priorities: [.alert]) {
                vcView.insertSubview(self, belowSubview: toastView)
                return
            }
        case .info:
            if let toastView = getLowestToast(in: vcView, priorities: [.alert, .warning]) {
                vcView.insertSubview(self, belowSubview: toastView)
                return
            }
        }
        translatesAutoresizingMaskIntoConstraints = true
        vcView.addSubview(self)
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
