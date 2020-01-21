//
//  MUCircularIndicator.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 09/01/2020.
//  Copyright © 2020 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

// MARK: - Orientation Enum

public enum Orientation: Int {
    case left, top, right, bottom
}

@IBDesignable
open class MUCircularIndicator: MUNibView {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var titleLabelOriginY: NSLayoutConstraint!

    @IBOutlet private var percentLabel: UILabel!
    @IBOutlet private var percentLabelOriginY: NSLayoutConstraint!

    // MARK: - Style

    /// Stroke draw direction
    @IBInspectable open dynamic var clockwise: Bool = true {
        didSet {
            layoutSubviews()
        }
    }

    /// Stroke background color
    @IBInspectable open dynamic var backgroundShapeColor: UIColor = .gray {
        didSet {
            updateShapes()
        }
    }

    /// Progress stroke color
    @IBInspectable open dynamic var progressShapeColor: UIColor = .blue {
        didSet {
            updateShapes()
        }
    }

    /// Line width
    @IBInspectable open dynamic var lineWidth: CGFloat = 8.0 {
        didSet {
            updateShapes()
        }
    }

    /// Space value
    @IBInspectable open dynamic var spaceDegree: CGFloat = 90.0 {
        didSet {
            layoutSubviews()
            updateShapes()
        }
    }

    /// The progress shapes line width will be the `line width` minus the `inset`.
    @IBInspectable open dynamic var inset: CGFloat = 0.0 {
        didSet {
            updateShapes()
        }
    }

    // progress text font
    @objc open dynamic var percentFont: UIFont = .systemFont(ofSize: 13) {
        didSet {
            percentLabel.font = percentFont
        }
    }

    // The progress percentage label(center label) format
    @IBInspectable open dynamic var percentLabelFormat: String = "%.f%%" {
        didSet {
            percentLabel.text = String(format: percentLabelFormat, progressValue * 100)
        }
    }

    @IBInspectable open dynamic var percentColor: UIColor = .white {
        didSet {
            percentLabel.textColor = percentColor
        }
    }

    /// Define the vertical inset between the title and the detail labels.
    @IBInspectable open dynamic var percentVerticalInset: CGFloat = 0.0 {
        didSet {
            percentLabelOriginY.constant = percentVerticalInset
        }
    }

    /// progress text (progress bottom label)
    @IBInspectable open dynamic var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    @IBInspectable open dynamic var titleColor: UIColor = .black {
        didSet {
            titleLabel.textColor = titleColor
        }
    }

    /// Define the vertical inset between the title and the detail labels.
    @IBInspectable open dynamic var titleVerticalInset: CGFloat = 0.0 {
        didSet {
            titleLabelOriginY.constant = titleVerticalInset
        }
    }

    // title text font
    @objc open dynamic var titleFont: UIFont = .systemFont(ofSize: 13) {
        didSet {
            titleLabel.font = titleFont
        }
    }

    // progress Orientation
    open var orientation: Orientation = .bottom {
        didSet {
            updateShapes()
        }
    }

    /// Progress shapes line cap.
    open var lineCap: CAShapeLayerLineCap = .round {
        didSet {
            updateShapes()
        }
    }

    /// Specifies the track value from 0.0 up to 1.0
    @IBInspectable open dynamic var progressValue: CGFloat = 0.0 {
        didSet {
            progressValue = min(progressValue, 1.0)
        }
    }

    /// Duration for a complete animation from 0.0 to 1.0.
    @objc open dynamic var completeDuration: Double = 2.0

    // MARK: - Private variables

    private var progressObserver: ((CGFloat) -> Void)?
    private let backgroundShape = CAShapeLayer()
    private let progressShape = CAShapeLayer()

    private var displayLink: CADisplayLink?

    // MARK: - Life cycle functions

    open override func layoutSubviews() {
        super.layoutSubviews()

        backgroundShape.frame = bounds
        progressShape.frame = bounds

        let rect = rectForShape()
        backgroundShape.path = pathForShape(rect: rect).cgPath
        progressShape.path = pathForShape(rect: rect).cgPath

        setup()
        updateShapes()
    }

    /// Deinit the circular progress.
    deinit {
       removeDisplayLink()
    }

    // MARK: - Public functions

    /// Resets the progress back to 0.
    public func reset() {
        set(value: 0, animated: false)
    }

    /**
     Sets the progress value with optional animation. Default is animated true.

     Current progress value can be observed using the progress closure.
     **/
    public func set(value: CGFloat, animated: Bool? = true, progress: ((_ current: CGFloat) -> Void)? = nil) {
        progressObserver = progress
        progressShape.removeAllAnimations()
        progressValue = value
        percentLabel.text = String(format: percentLabelFormat, value * 100)
        if animated ?? false {
            progressAnimation(duration: completeDuration)
        } else {
            progressAnimation()
        }
    }

    // MARK: - Setup functions

    private func setup() {
        backgroundShape.fillColor = nil
        backgroundShape.strokeColor = backgroundShapeColor.cgColor
        layer.addSublayer(backgroundShape)

        progressShape.fillColor = nil
        progressShape.strokeStart = 0.0
        progressShape.strokeEnd = progressValue
        layer.addSublayer(progressShape)

        percentLabel.textAlignment = .center
        percentLabel.text = String(format: percentLabelFormat, progressValue * 100)

        titleLabel.textAlignment = .center
        titleLabel.text = title
    }

    // MARK: - Display Link

    private func setupDisplayLink() {
        displayLink = CADisplayLink(target: MUWeakProxy(self), selector: #selector(MUWeakProxy.onScreenUpdate))
        displayLink?.add(to: .current, forMode: .common)
    }

    private func removeDisplayLink() {
        displayLink?.remove(from: .current, forMode: .common)
        displayLink?.invalidate()
    }

    // MARK: - Progress Animation

    private func progressAnimation(duration: TimeInterval = 0) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.beginTime = 0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.fromValue = duration == 0 ? progressValue :  progressShape.presentation()?.value(forKey: "strokeEnd")
        animation.toValue = min(1, max(0, progressValue))
        animation.delegate = self
        progressShape.add(animation, forKey: "progress")
    }

    @objc
    private func observeAnimation() {
        guard let value = progressShape.presentation()?.value(forKey: "strokeEnd") as? CGFloat else {
            return
        }
        progressObserver?(value)
    }

    // MARK: - Layout

    private func updateShapes() {
        backgroundShape.lineWidth = lineWidth
        backgroundShape.strokeColor = backgroundShapeColor.cgColor
        backgroundShape.lineCap = lineCap

        progressShape.strokeColor = progressShapeColor.cgColor
        progressShape.lineWidth = lineWidth - inset
        progressShape.lineCap = lineCap

        switch orientation {
        case .left:
            titleLabel.isHidden = true
            progressShape.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1.0)
            backgroundShape.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1.0)
        case .right:
            titleLabel.isHidden = true
            progressShape.transform = CATransform3DMakeRotation(CGFloat.pi * 1.5, 0, 0, 1.0)
            backgroundShape.transform = CATransform3DMakeRotation(CGFloat.pi * 1.5, 0, 0, 1.0)
        case .bottom:
            titleLabel.isHidden = false
            progressShape.transform = CATransform3DMakeRotation(CGFloat.pi * 2, 0, 0, 1.0)
            backgroundShape.transform = CATransform3DMakeRotation(CGFloat.pi * 2, 0, 0, 1.0)
        case .top:
            titleLabel.isHidden = false
            progressShape.transform = CATransform3DMakeRotation(CGFloat.pi, 0, 0, 1.0)
            backgroundShape.transform = CATransform3DMakeRotation(CGFloat.pi, 0, 0, 1.0)
        }
    }

    /// The natural size for the receiving view, considering only properties of the view itself.
    override open var intrinsicContentSize: CGSize {
        return CGSize(width: 150, height: 150)
    }

    // MARK: - Helper

    private func rectForShape() -> CGRect {
        return bounds.insetBy(dx: lineWidth / 2.0, dy: lineWidth / 2.0)
    }

    private func pathForShape(rect: CGRect) -> UIBezierPath {
        var startAngle = CGFloat.zero
        var endAngle = CGFloat.zero

        if clockwise {
            startAngle = CGFloat(spaceDegree * .pi / 180.0) + (0.5 * .pi)
            endAngle = CGFloat((360.0 - spaceDegree) * (.pi / 180.0)) + (0.5 * .pi)
        } else {
            startAngle = CGFloat((360.0 - spaceDegree) * (.pi / 180.0)) + (0.5 * .pi)
            endAngle = CGFloat(spaceDegree * .pi / 180.0) + (0.5 * .pi)
        }

        return UIBezierPath(arcCenter: CGPoint(x: rect.midX, y: rect.midY),
                                radius: rect.size.width / 2.0,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: clockwise)
    }
}

extension MUCircularIndicator: CAAnimationDelegate {
    public func animationDidStart(_ anim: CAAnimation) {
        layoutSubviews()
    }

    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        layoutSubviews()
    }
}

extension MUCircularIndicator: Weakable {
    public func updateIfNeeded() {
        observeAnimation()
    }
}
