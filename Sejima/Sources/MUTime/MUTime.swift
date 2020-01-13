//
//  MUTime.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Class that provide a circular indicator to represent time with customizable options.
@IBDesignable
open class MUTime: MUNibView {

    @IBOutlet private var timeLabel: MULabelCounter!
    @IBOutlet private var timeBackground: UIView!

    // MARK: - Animation

    /// Specifies the animation duration for the progress line to go from current progress value up to target value.
    @objc open dynamic var animationDuration: TimeInterval = 0.3

    // MARK: - Label

    /// The progress value text font.
    @objc open dynamic var font: UIFont = .systemFont(ofSize: 13, weight: .bold) {
        didSet {
            timeLabel.textFont = font
        }
    }

    /// The progress value text color.
    @IBInspectable open dynamic var color: UIColor = .clear {
        didSet {
            timeLabel.textColor = color
        }
    }

    /// The progress value text background color.
    @IBInspectable open dynamic var timeBackgroundColor: UIColor = .clear {
        didSet {
            timeBackground.backgroundColor = timeBackgroundColor
        }
    }

    /// Specifies the progress text value format.
    @IBInspectable open dynamic var format: String = "%.f" {
        didSet {
            timeLabel.format = format
            updateTime()
        }
    }

    /// Show / Hide the progress text value. Shown by default.
    @IBInspectable open dynamic var showValue: Bool = true {
        didSet {
            timeLabel.isHidden = !showValue
        }
    }

    // MARK: - Indicator

    /// Define the progress line color.
    @IBInspectable open dynamic var indicatorColor: UIColor = .clear {
        didSet {
            progressPathLayer.strokeColor = indicatorColor.cgColor
        }
    }

    /// Specifies the start angle in degrees for the progress line path.
    @IBInspectable open dynamic var indicatorStartAngle: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }

    /// Specifies the end angle in degrees for the progress line path.
    @IBInspectable open dynamic var indicatorEndAngle: CGFloat = 360.0 {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define the progress line width.
    @IBInspectable open dynamic var indicatorWidth: CGFloat = 8 {
        didSet {
            progressPathLayer.lineWidth = indicatorWidth
            setNeedsLayout()
        }
    }

    /// Specifies the minimum progress value.
    @IBInspectable open dynamic var indicatorMinValue: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    /// Specifies the maximum progress value.
    @IBInspectable open dynamic var indicatorMaxValue: CGFloat = 90 {
        didSet {
            setNeedsLayout()
        }
    }

    /// Specifies the progress value from 0.0 up to 1.0
    @IBInspectable open dynamic var progressValue: CGFloat = 0.0 {
        didSet {
            progressValue = min(progressValue, indicatorMaxValue)
            updateTime()
        }
    }

    /// Specifies the progress line cap style for the shape’s path.
    @objc open dynamic var indicatorLineCap: CAShapeLayerLineCap = .round {
        didSet {
            progressPathLayer.lineCap = indicatorLineCap
        }
    }

    // MARK: - Private functions

    private let progressPathLayer = CAShapeLayer()
    private var currentProgress: CGFloat = 0
    private var progressObserver: ((CGFloat) -> Void)?
    private var displayLink: CADisplayLink?

    // MARK: - Public functions

    /// Resets the progress back to 0.
    public func reset() {
        set(value: 0, animated: false)
    }

    /**
     Sets the progress value with optional animation. Default is animated true.

     Current progress value can be observed using the progress closure.
     **/
    public func set(value: CGFloat, animated: Bool = true, progress: ((_ current: CGFloat) -> Void)? = nil) {
        progressObserver = progress
        progressPathLayer.removeAllAnimations()
        progressValue = value

        progressPathLayer.path = progressPath().cgPath
        updateTime(animated: animated)

        if animated {
            animateCircle()
        } else {
            currentProgress = progressValue
        }
    }

    // MARK: - Private functions

    private func setupDisplayLink() {
        displayLink = CADisplayLink(target: MUWeakProxy(self), selector: #selector(MUWeakProxy.onScreenUpdate))
        displayLink?.add(to: .current, forMode: .common)
    }

    private func removeDisplayLink() {
        displayLink?.remove(from: .current, forMode: .common)
        displayLink?.invalidate()
    }

    private func updateTime(animated: Bool = true) {
        timeLabel.count(to: Double(progressValue),
                        duration: animated ? animationDuration : 0)
    }

    private func progressLayer() {
        progressPathLayer.lineCap = indicatorLineCap
        progressPathLayer.lineWidth = indicatorWidth
        progressPathLayer.fillColor = UIColor.clear.cgColor
        progressPathLayer.strokeColor = indicatorColor.cgColor
        layer.addSublayer(progressPathLayer)
    }

    private func progressFrame() -> CGRect {
        let radius = min(bounds.width, bounds.height)
        return CGRect(x: 0, y: 0, width: radius, height: radius)
    }

    private func progressPath() -> UIBezierPath {
        let ovalPath = UIBezierPath()
        let ovalRect = progressFrame()
        let startAngle = indicatorStartAngle
        let endAngle = indicatorEndAngle
        let minValue = indicatorMinValue
        let maxValue = indicatorMaxValue * 0.5
        let angleDiff: CGFloat = startAngle > endAngle ?
            360.0 - startAngle + endAngle :
            endAngle - startAngle

        let progressEndAngle = (progressValue - minValue) / (maxValue - minValue) * angleDiff + startAngle

        ovalPath.addArc(withCenter: CGPoint(x: ovalRect.midX, y: ovalRect.midY),
                        radius: ovalRect.width * 0.5,
                        startAngle: startAngle.toRadians,
                        endAngle: progressEndAngle.toRadians,
                        clockwise: true)
        return ovalPath
    }

    private func animateCircle() {
        progressPathLayer.removeAllAnimations()
        displayLink?.isPaused = false
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        CATransaction.setCompletionBlock({ [weak self] in
            self?.displayLink?.isPaused = true
            guard let indicatorProgress = self?.progressValue else {
                return
            }

            self?.progressObserver?(indicatorProgress)
        })

        animation.duration = animationDuration
        animation.fromValue = currentProgress
        animation.toValue = 1
        progressPathLayer.add(animation, forKey: "animateTimeProgress")
    }

    @objc
    private func observeAnimation() {
        guard let value = progressPathLayer.presentation()?.value(forKey: "strokeEnd") as? CGFloat else {
            return
        }

        let progress = progressValue * value

        progressObserver?(progress)
    }

    // MARK: - Private functions

    /// Default setup to load the view from a xib file.
    open override func xibSetup() {
        super.xibSetup()

        setupDisplayLink()
        progressLayer()

        timeLabel.textAlignment = .center
    }

    /// Lays out subviews.
    override open func layoutSubviews() {
        super.layoutSubviews()

        timeBackground.layer.cornerRadius = timeBackground.bounds.width * 0.5
        progressPathLayer.path = progressPath().cgPath
    }

    /// The natural size for the receiving view, considering only properties of the view itself.
    override open var intrinsicContentSize: CGSize {
        return CGSize(width: 40, height: 40)
    }

    /// Deinit the time progress.
    deinit {
        removeDisplayLink()
    }
}

extension MUTime: Weakable {
    public func updateIfNeeded() {
        observeAnimation()
    }
}
