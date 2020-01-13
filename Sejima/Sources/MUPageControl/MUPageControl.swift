//
//  MUPageControl.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Delegate protocol for MUPageControl.
@objc public protocol MUPageControlDelegate: class {
    /// Will trigger each time the page control is tapped.
    func didTap(pageControl: MUPageControl, at index: Int)
}

/// Class that act like UIPageControl with more customizable options.
@IBDesignable
open class MUPageControl: UIControl {
    private var inactive = [CAShapeLayer]()
    private var active = CAShapeLayer()
    private var tapEvent: UITapGestureRecognizer?
    private var moveToPage: Int?
    private var displayLink: CADisplayLink?

    /// The object that acts as the delegate of the page control.
    @IBOutlet public weak var delegate: MUPageControlDelegate? // swiftlint:disable:this private_outlet strong_iboutlet line_length

    // MARK: - Public IBInspectable variables ONLY

    /// The number of pages the receiver shows (as dots).
    @IBInspectable open var numberOfPages: Int = 0 {
        didSet {
            updateNumberOfPages(numberOfPages)
            updateVisibility()
        }
    }

    /// The current page, shown by the receiver as a white dot.
    @IBInspectable open var currentPage: Int = 0 {
        didSet {
            update(for: currentPage)
        }
    }

    // MARK: - Public UIAppearence variables ONLY

    /// Optional: You can override pageIndicatorTintColor to have different colors on each dots.
    @objc open dynamic var tintColors: [UIColor] = [] {
        didSet {
            setNeedsLayout()
        }
    }

    // MARK: - Public IBInspectable and UIAppearence variables

    /// Enable or not the touch to select a page.
    @IBInspectable open dynamic var enableTouchEvents: Bool = false {
        didSet {
            enableTouchEvents ? enableTouch() : disableTouch()
        }
    }

    /// Define the size of each dots.
    @IBInspectable open dynamic var elementSize: CGSize = CGSize(width: 8.0, height: 8.0) {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the width of the active dot.
    @IBInspectable open dynamic var activeElementWidth: CGFloat = 16.0 {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the padding between each dots.
    @IBInspectable open dynamic var padding: CGFloat = 8.0 {
        didSet {
            setNeedsLayout()
            update(for: currentPage)
        }
    }

    /// Define the radius of the active dot.
    @IBInspectable open dynamic var radius: CGFloat = 4.0 {
        didSet {
            setNeedsLayout()
            update(for: currentPage)
        }
    }

    /// A Boolean value that controls whether the page control is hidden when there is only one page.
    @IBInspectable open dynamic var hidesForSinglePage: Bool = false {
        didSet {
            updateVisibility()
        }
    }

    /// The inactive dot’s border width.
    @IBInspectable open dynamic var borderWidth: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }

    /// The inactive dot’s border color.
    @IBInspectable open dynamic var borderColor: UIColor = .clear {
        didSet {
            setNeedsLayout()
        }
    }

    /// The tint color to be used for the current page indicator.
    @IBInspectable open dynamic var currentPageIndicatorTintColor: UIColor? = .black {
        didSet {
            setNeedsLayout()
        }
    }

    /// The tint color to be used for the page indicator.
    @IBInspectable open dynamic var pageIndicatorTintColor: UIColor? = .lightGray {
        didSet {
            setNeedsLayout()
        }
    }

    /// Describes the margin around the page control.
    @IBInspectable open dynamic var horizontalMargin: CGFloat = 0.0 {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    // MARK: - Public functions

    /// Define the current page index, animated or not.
    open func set(page: Int, animated: Bool = false) {
        guard page >= 0 && page <= numberOfPages - 1  else {
            return
        }

        animated ? (moveToPage = page) : (currentPage = page)
    }

    // MARK: - Private functions

    private func tintColor(at position: Int) -> UIColor {
        guard position < tintColors.count else {
            return tintColor
        }

        return tintColors[position]
    }

    private func updateVisibility() {
        isHidden = hidesForSinglePage && numberOfPages <= 1
    }

    private func updateNumberOfPages(_ count: Int) {
        inactive.forEach { $0.removeFromSuperlayer() }
        inactive = [CAShapeLayer]()
        inactive = (0 ..< count).map { _ in
            let newLayer = CAShapeLayer()
            layer.addSublayer(newLayer)
            return newLayer
        }

        update(for: currentPage) // test if current page is still in bounds

        active.removeFromSuperlayer()
        layer.addSublayer(active)
        setNeedsLayout()
        invalidateIntrinsicContentSize()
    }

    private func update(for page: Int) {
        guard let targetX = inactive.first?.frame.origin.x, numberOfPages > 0 else {
            return
        }

        guard page >= 0 && page <= numberOfPages - 1 else {
            currentPage = max(0, min(currentPage, numberOfPages - 1))
            return
        }

        resetInactive()
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.active.frame.origin.x = self?.inactive[self?.currentPage ?? 0].frame.origin.x ?? targetX
        }
    }

    private func resetInactive() {
        let yAxis = (bounds.size.height - elementSize.height) * 0.5
        var frame = CGRect(x: horizontalMargin, y: yAxis, width: elementSize.width, height: elementSize.height)

        inactive.enumerated().forEach { index, layer in
            layer.frame = frame
            UIView.animate(withDuration: 0.25, animations: { [weak self] in
                guard let strongSelf = self else {
                    return
                }

                frame.origin.x += (index == strongSelf.currentPage ?
                    strongSelf.activeElementWidth :
                    strongSelf.elementSize.width) + strongSelf.padding
                frame.size.width = (index + 1) == strongSelf.currentPage ?
                    strongSelf.activeElementWidth :
                    strongSelf.elementSize.width
            })
        }
    }

    // MARK: - Private gesture functions

    private func enableTouch() {
        if tapEvent == nil {
            let event = UITapGestureRecognizer(target: self, action: #selector(didTap(gesture:)))
            addGestureRecognizer(event)
            tapEvent = event
        }
    }

    private func disableTouch() {
        if let tapEvent = tapEvent {
            removeGestureRecognizer(tapEvent)
        }
        tapEvent = nil
    }

    @objc
    private func didTap(gesture: UITapGestureRecognizer) {
        guard !inactive.isEmpty else {
            return
        }

        var index = 0
        var closest = CGFloat.infinity
        let position = gesture.location(ofTouch: 0, in: self).x

        inactive.map({ $0.position.x }).enumerated().forEach { offset, element in
            let distance = abs(position - element)
            if distance < closest {
                closest = distance
                index = offset
            }
        }

        set(page: index, animated: true)
        delegate?.didTap(pageControl: self, at: index)
    }

    // MARK: - Life cycle functions

    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupDisplayLink()
    }

    /// Returns an object initialized from data in a given unarchiver.
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDisplayLink()
    }

    /// Initializes and returns a newly allocated view object with a zero frame rectangle.
    public convenience init() {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupDisplayLink() {
        displayLink = CADisplayLink(target: MUWeakProxy(self), selector: #selector(MUWeakProxy.onScreenUpdate))
        displayLink?.add(to: .current, forMode: .common)
    }

    @objc
    private func animate() {
        guard let moveToProgress = moveToPage else {
            return
        }

        let first = fabsf(Float(moveToProgress))
        let second = fabsf(Float(currentPage))

        if first > second {
            currentPage += 1
        }
        if first < second {
            currentPage -= 1
        }

        if first == second {
            currentPage = moveToProgress
            moveToPage = nil
        }

        if currentPage < 0 {
            currentPage = 0
            moveToPage = nil
        }

        if currentPage > numberOfPages - 1 {
            currentPage = numberOfPages - 1
            moveToPage = nil
        }
    }

    /// Lays out subviews.
    override open func layoutSubviews() {
        super.layoutSubviews()

        let yAxis = (bounds.size.height - elementSize.height) * 0.5
        let activeFrame = CGRect(x: 0.0, y: yAxis, width: activeElementWidth, height: elementSize.height)

        tintColor = pageIndicatorTintColor

        active.cornerRadius = radius
        active.backgroundColor = (currentPageIndicatorTintColor ?? tintColor)?.cgColor
        active.frame = activeFrame

        inactive.enumerated().forEach { index, layer in
            layer.backgroundColor = tintColor(at: index).cgColor
            layer.cornerRadius = radius

            if borderWidth > 0 {
                layer.borderWidth = borderWidth
                layer.borderColor = borderColor.cgColor
            }
        }
        update(for: currentPage)
    }

    /// The natural size for the receiving view, considering only properties of the view itself.
    override open var intrinsicContentSize: CGSize {
        return sizeThatFits(.zero)
    }

    /// Asks the view to calculate and return the size that best fits the specified size.
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        let floatCount = CGFloat(inactive.count - 1)
        let elements = elementSize.width * floatCount + activeElementWidth
        let paddings = padding * floatCount
        return CGSize(width: elements + paddings + horizontalMargin * 2.0, height: elementSize.height)
    }

    /// Deinit the page control.
    deinit {
        displayLink?.remove(from: .current, forMode: .common)
        displayLink?.invalidate()
    }
}

extension MUPageControl: Weakable {
    public func updateIfNeeded() {
        animate()
    }
}
