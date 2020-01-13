//
//  MUCircularProgress.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 29/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Class that provide a circular progress indicator with customizable options.
@IBDesignable
open class MUCircularProgress: MUNibView {
    @IBOutlet private var image: UIImageView!
    @IBOutlet private var label: UILabel!
    @IBOutlet private var sublabel: UILabel!

    // Labels icon constraint
    @IBOutlet private var imageLeading: NSLayoutConstraint!
    @IBOutlet private var imageTop: NSLayoutConstraint!
    @IBOutlet private var imageTrailing: NSLayoutConstraint!
    @IBOutlet private var imageBottom: NSLayoutConstraint!

    // Labels inset constraint
    @IBOutlet private var labelsVerticalInset: NSLayoutConstraint!
    @IBOutlet private var labelsLeading: NSLayoutConstraint!
    @IBOutlet private var labelsTrailing: NSLayoutConstraint!

    // MARK: - Style

    /// Define the progress style
    open var progressType: MUCircularProgressType = .determinate

    /// Define the progress style (using Int value)
    @IBInspectable open dynamic var progressTypeInt: Int = 0 {
        didSet {
            progressType = MUCircularProgressType(rawValue: progressTypeInt) ?? .determinate
        }
    }

    // MARK: - Icon

    /// An image displayed.
    @IBInspectable open var icon: UIImage? = nil {
        didSet {
            image.image = icon
        }
    }

    /// An image padding.
    @objc open dynamic var iconMargin: UIEdgeInsets = .zero {
        didSet {
            imageLeading.constant = iconMargin.left
            imageTop.constant = iconMargin.top
            imageTrailing.constant = iconMargin.right
            imageBottom.constant = iconMargin.bottom
        }
    }

    // MARK: - Labels

    /// The title text displayed.
    @IBInspectable open var title: String = "" {
        didSet {
            label.text = title
        }
    }

    /// The title's font.
    @objc open dynamic var titleFont: UIFont = .systemFont(ofSize: 34, weight: .regular) {
        didSet {
            label.font = titleFont
        }
    }

    /// The title's title color.
    @IBInspectable open dynamic var titleColor: UIColor = .white {
        didSet {
            label.textColor = titleColor
        }
    }

    /// The detail text displayed.
    @IBInspectable open var detail: String = "" {
        didSet {
            sublabel.text = detail
        }
    }

    /// The detail’s font.
    @objc open dynamic var detailFont: UIFont = .systemFont(ofSize: 14, weight: .semibold) {
        didSet {
            sublabel.font = detailFont
        }
    }

    /// The detail’s title color.
    @IBInspectable open dynamic var detailColor: UIColor = .white {
        didSet {
            sublabel.textColor = detailColor
        }
    }

    /// Define the vertical inset between the title and the detail labels.
    @IBInspectable open dynamic var textVerticalInset: CGFloat = 0.0 {
        didSet {
            labelsVerticalInset.constant = textVerticalInset
        }
    }

    /// Define the horizontal padding for the title and detail labels.
    @IBInspectable open dynamic var textPaddingInset: CGFloat = 0.0 {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    // MARK: - Track line

    /// Define the track line color.
    @IBInspectable open dynamic var trackLineColor: UIColor = .white {
        didSet {
            backgroundPathLayer.strokeColor = trackLineColor.cgColor
        }
    }

    /// Define the track background color.
    @IBInspectable open dynamic var trackBackgroundColor: UIColor = .black {
        didSet {
            backgroundPathLayer.fillColor = trackBackgroundColor.cgColor
        }
    }

    /// Define the track line width.
    @IBInspectable open dynamic var trackLineWidth: CGFloat = 8.0 {
        didSet {
            backgroundPathLayer.lineWidth = trackLineWidth
            setNeedsUpdateConstraints()
        }
    }

    /// Specifies the track line cap style for the shape’s path.
    @objc open dynamic var trackLineCap: CAShapeLayerLineCap = .round {
        didSet {
            backgroundPathLayer.lineCap = trackLineCap
        }
    }

    /// Specifies the start angle for the track line path.
    @IBInspectable open dynamic var trackStartAngle: CGFloat = 0.0 {
        didSet {
            backgroundPathLayer.transform = CATransform3DMakeRotation(trackStartAngle.toRadians, 0.0, 0.0, 1.0)
        }
    }

    /// Specifies the track value from 0.0 up to 1.0
    @IBInspectable open dynamic var trackValue: CGFloat = 0.0 {
        didSet {
            trackValue = min(trackValue, 1.0)
        }
    }

    // MARK: - Progress line

    /// Define the progress offet.
    @IBInspectable open dynamic var offset: CGFloat = 0.0

    /// Define the progress line color.
    @IBInspectable open dynamic var progressLineColor: UIColor = .white {
        didSet {
            pathLayer.strokeColor = progressLineColor.cgColor
        }
    }

    /// Specifies the progress line cap style for the shape’s path.
    @objc open dynamic var progressLineCap: CAShapeLayerLineCap = .round {
        didSet {
            pathLayer.lineCap = progressLineCap
        }
    }

    /// Define the progress line width.
    @IBInspectable open dynamic var progressLineWidth: CGFloat = 8.0 {
        didSet {
            pathLayer.lineWidth = progressLineWidth
            setNeedsUpdateConstraints()
        }
    }

    /// Specifies the start angle for the progress line path.
    @IBInspectable open dynamic var progressStartAngle: CGFloat = 0.0 {
        didSet {
            pathLayer.transform = CATransform3DMakeRotation(progressStartAngle.toRadians, 0.0, 0.0, 1.0)
        }
    }

    /// Specifies the progress value from 0.0 up to 1.0
    @IBInspectable open dynamic var progressValue: CGFloat = 0.0 {
        didSet {
            progressValue = min(progressValue, 1.0)
            switch progressType {
            case .indeterminate:
                startAnimating()
            default:
                stopAnimating()
            }
        }
    }

    // MARK: - Animation

    /// Specifies the animation duration for the progress line to go from current progress value up to target value.
    @objc open dynamic var animationDuration: TimeInterval = 0.3

    /// Specifies the animation duration for the indeterminate rotation of the progress line.
    @objc open dynamic var rotateDuration: TimeInterval = 1.0

    // MARK: - Private variables

    private var progressObserver: ((CGFloat) -> Void)?
    private let backgroundPathLayer = CAShapeLayer()
    private let pathLayer = CAShapeLayer()
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
    public func set(value: CGFloat, animated: Bool? = true, progress: ((_ current: CGFloat) -> Void)? = nil) {
        progressObserver = progress
        pathLayer.removeAllAnimations()
        progressValue = value
        if animated ?? false {
            progressAnimation(duration: animationDuration)
        } else {
            progressAnimation()
        }
    }

    // MARK: - Private method

    public func startAnimating() {
        rotateAnimation()
    }

    public func stopAnimating() {
        resetAnimation()
    }

    private func setupDisplayLink() {
        displayLink = CADisplayLink(target: MUWeakProxy(self), selector: #selector(MUWeakProxy.onScreenUpdate))
        displayLink?.add(to: .current, forMode: .common)
    }

    private func removeDisplayLink() {
        displayLink?.remove(from: .current, forMode: .common)
        displayLink?.invalidate()
    }

    private func configure() {
        setupDisplayLink()
        backgroundLayer()
        progressLayer()

        label.textAlignment = .center
        sublabel.textAlignment = .center
    }

    private func backgroundLayer() {
        backgroundPathLayer.removeFromSuperlayer()
        backgroundPathLayer.strokeEnd = trackValue
        backgroundPathLayer.frame = bounds
        layer.insertSublayer(backgroundPathLayer, at: 0)
    }

    private func progressLayer() {
        pathLayer.removeFromSuperlayer()
        pathLayer.strokeEnd = progressValue
        pathLayer.frame = bounds
        pathLayer.fillColor = UIColor.clear.cgColor
        layer.insertSublayer(pathLayer, above: backgroundPathLayer)
    }

    private func frame(for shape: CAShapeLayer, offset: CGFloat) -> CGRect {
        let radius = min(shape.frame.width, shape.frame.height)
        var circleFrame = CGRect(x: 0, y: 0, width: radius - offset, height: radius - offset)
        circleFrame.origin.x = shape.bounds.midX - circleFrame.midX
        circleFrame.origin.y = shape.bounds.midY - circleFrame.midY

        return circleFrame
    }

    private func bezier(for shape: CAShapeLayer, offset: CGFloat = 0) -> UIBezierPath {
        let frame = self.frame(for: shape, offset: offset)
        return UIBezierPath(ovalIn: frame)
    }

    private func progressAnimation(duration: TimeInterval = 0) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.beginTime = 0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.fromValue = duration == 0 ? progressValue :  pathLayer.presentation()?.value(forKey: "strokeEnd")
        animation.toValue = min(1, max(0, progressValue))
        pathLayer.add(animation, forKey: "progress")
    }

    @objc
    private func observeAnimation() {
        guard let value = pathLayer.presentation()?.value(forKey: "strokeEnd") as? CGFloat else {
            return
        }

        progressObserver?(value)
    }

    // MARK: - Rotate animation

    private func rotateAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.duration = rotateDuration
        animation.repeatCount = MAXFLOAT
        animation.byValue = Double.pi * 2
        pathLayer.strokeEnd = progressValue
        pathLayer.add(animation, forKey: "rotation")
    }

    private func resetAnimation() {
        if let transform = pathLayer.presentation()?.transform {
            pathLayer.transform = transform
            pathLayer.removeAnimation(forKey: "rotation")
        }
    }

    // MARK: - Life cycle functions

    /// Lays out subviews.
    override open func layoutSubviews() {
        super.layoutSubviews()
        configure()

        backgroundPathLayer.path = bezier(for: backgroundPathLayer, offset: offset).cgPath
        pathLayer.path = bezier(for: pathLayer).cgPath
    }

    /// Updates constraints for the view.
    open override func updateConstraints() {
        super.updateConstraints()

        let overallPadding = textPaddingInset + max(progressLineWidth, trackLineWidth)
        labelsLeading.constant = overallPadding
        labelsTrailing.constant = overallPadding
    }

    /// The natural size for the receiving view, considering only properties of the view itself.
    override open var intrinsicContentSize: CGSize {
        return CGSize(width: 150, height: 150)
    }

    /// Deinit the circular progress.
    deinit {
       removeDisplayLink()
    }
}

extension MUCircularProgress: Weakable {
    public func updateIfNeeded() {
        observeAnimation()
    }
}
