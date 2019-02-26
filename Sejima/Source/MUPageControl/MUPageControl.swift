//
//  MUPageControl.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// Delegate protocol for MUPageControl.
public protocol MUPageControlDelegate: class {
    /// Will trigger each time the page control is tapped.
    func didTap(_ pageControl: MUPageControl, index: Int)
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
    open weak var delegate: MUPageControlDelegate?

    // MARK: - Public IBInspectable variables ONLY

    /// The number of pages the receiver shows (as dots).
    @IBInspectable open var numberOfPages: Int = 0 {
        didSet {
            populateTintColors()
            updateNumberOfPages(numberOfPages)
            isHidden = hidesForSinglePage && numberOfPages <= 1
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
            guard tintColors.count == numberOfPages else {
                print("The number of tint colors needs to be the same as the number of page.")
                return
            }
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

    /// Define the width of each dots.
    @IBInspectable open dynamic var elementWidth: CGFloat = 8.0 {
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

    /// Define the height of each dots.
    @IBInspectable open dynamic var elementHeight: CGFloat = 8.0 {
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
            setNeedsLayout()
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

    // MARK: - Public functions

    /// Define the current page index, animated or not.
    open func set(page: Int, animated: Bool) {
        guard page <= numberOfPages - 1 && page >= 0 else {
            return
        }
        if animated == true {
            moveToPage = page
        } else {
            currentPage = page
        }
    }

    // MARK: - Private functions

    private func tintColor(position: Int) -> UIColor {
        if tintColors.count < numberOfPages {
            return tintColor ?? .black
        } else {
            return tintColors[position]
        }
    }

//    open func insertTintColor(_ color: UIColor, position: Int) {
//        if tintColors.count < numberOfPages {
//            setupTintColors()
//        }
//        tintColors[position] = color
//    }

//    private func setupTintColors() {
//        tintColors = [UIColor](repeating: tintColor ?? .black, count: numberOfPages)
//    }

    private func populateTintColors() {
        guard !tintColors.isEmpty else {
            return
        }

        if tintColors.count > numberOfPages {
            tintColors = Array(tintColors.prefix(numberOfPages))
        } else if tintColors.count < numberOfPages {
            tintColors.append(contentsOf: [UIColor](repeating: tintColor ?? .black,
                                                    count: numberOfPages - tintColors.count))
        }
    }

    private func updateNumberOfPages(_ count: Int) {
        inactive.forEach { $0.removeFromSuperlayer() }
        inactive = [CAShapeLayer]()
        inactive = (0..<count).map {_ in
            let newLayer = CAShapeLayer()
            layer.addSublayer(newLayer)
            return newLayer
        }

        layer.addSublayer(active)
        setNeedsLayout()
        invalidateIntrinsicContentSize()
    }

    private func update(for progress: Int) {
        guard let targetX = inactive.first?.frame.origin.x,
            numberOfPages > 1,
            progress >= 0 && progress <= numberOfPages - 1 else {
                return
        }

        resetInactive()
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.active.frame.origin.x = self?.inactive[self?.currentPage ?? 0].frame.origin.x ?? targetX
        }

    }

    private func xAxis() -> CGFloat {
        let floatCount = CGFloat(inactive.count - 1)
        let elementSize = (elementWidth * floatCount + activeElementWidth)
        let paddingSize = padding * (floatCount - 1)
        return (bounds.size.width - elementSize - paddingSize) * 0.5
    }

    private func resetInactive() {
        let yAxis = (bounds.size.height - elementHeight) * 0.5
        var frame = CGRect(x: xAxis(), y: yAxis, width: elementWidth, height: elementHeight)

        inactive.enumerated().forEach { index, layer in
            layer.frame = frame
            UIView.animate(withDuration: 0.25, animations: { [weak self] in
                guard let strongSelf = self else {
                    return
                }

                frame.origin.x += (index == strongSelf.currentPage ?
                    strongSelf.activeElementWidth :
                    strongSelf.elementWidth) + strongSelf.padding
                frame.size.width = (index + 1) == strongSelf.currentPage ?
                    strongSelf.activeElementWidth :
                    strongSelf.elementWidth
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
        delegate?.didTap(self, index: index)
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
        displayLink = CADisplayLink(target: MUWeakProxy(self), selector: #selector(animate))
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

        let yAxis = (bounds.size.height - elementHeight) * 0.5
        let activeFrame = CGRect(x: xAxis(), y: yAxis, width: activeElementWidth, height: elementHeight)
        var frame = CGRect(x: xAxis(), y: yAxis, width: elementWidth, height: elementHeight)

        tintColor = pageIndicatorTintColor

        active.cornerRadius = radius
        active.backgroundColor = (currentPageIndicatorTintColor ?? tintColor)?.cgColor
        active.frame = activeFrame

        inactive.enumerated().forEach { index, layer in
            layer.backgroundColor = tintColor(position: index)
                .cgColor
            if borderWidth > 0 {
                layer.borderWidth = borderWidth
                layer.borderColor = borderColor.cgColor
            }
            layer.cornerRadius = radius
            layer.frame = frame
            frame.origin.x += (index == currentPage ? activeElementWidth : elementWidth) + padding
        }
        update(for: currentPage)
    }

    /// The natural size for the receiving view, considering only properties of the view itself.
    override open var intrinsicContentSize: CGSize {
        return sizeThatFits(CGSize.zero)
    }

    /// Asks the view to calculate and return the size that best fits the specified size.
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        let elementSize = CGFloat(inactive.count) * elementWidth + activeElementWidth
        let paddingSize = CGFloat(inactive.count - 1) * padding
        return CGSize(width: elementSize + paddingSize,
                      height: elementHeight)
    }

    /// Deinit the page control.
    deinit {
        displayLink?.remove(from: .current, forMode: .common)
        displayLink?.invalidate()
    }
}
