//
//  MUCircularIndicator.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 09/01/2020.
//  Copyright © 2020 Loïc GRIFFIE. All rights reserved.
//

import UIKit

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
    @IBInspectable open var clockwise: Bool = true {
        didSet {
            layoutSubviews()
        }
    }

    /// Stroke background color
    @IBInspectable open var backgroundShapeColor: UIColor = .gray {
        didSet {
            updateShapes()
        }
    }

    /// Progress stroke color
    @IBInspectable open var progressShapeColor: UIColor = .blue {
        didSet {
            updateShapes()
        }
    }

    /// Line width
    @IBInspectable open var lineWidth: CGFloat = 8.0 {
        didSet {
            updateShapes()
        }
    }

    /// Space value
    @IBInspectable open var spaceDegree: CGFloat = 90.0 {
        didSet {
            layoutSubviews()
            updateShapes()
        }
    }

    /// The progress shapes line width will be the `line width` minus the `inset`.
    @IBInspectable open var inset: CGFloat = 0.0 {
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
    @IBInspectable open var percentLabelFormat: String = "%.f%%" {
        didSet {
            percentLabel.text = String(format: percentLabelFormat, progress * 100)
        }
    }

    @IBInspectable open var percentColor: UIColor = .white {
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
    @IBInspectable open var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    @IBInspectable open var titleColor: UIColor = .black {
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

    /// Returns the current progress.
    @IBInspectable open private(set) var progress: CGFloat {
        set {
            progressShape.strokeEnd = newValue
        }
        get {
            return progressShape.strokeEnd
        }
    }

    /// Duration for a complete animation from 0.0 to 1.0.
    @objc open dynamic var completeDuration: Double = 2.0

    // MARK: - Private variables

    private let backgroundShape = CAShapeLayer()
    private let progressShape = CAShapeLayer()
    private let progressAnimation = CABasicAnimation(keyPath: "strokeEnd")

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

    private func setup() {
        backgroundShape.fillColor = nil
        backgroundShape.strokeColor = backgroundShapeColor.cgColor
        layer.addSublayer(backgroundShape)

        progressShape.fillColor = nil
        progressShape.strokeStart = 0.0
        progressShape.strokeEnd = 0.1
        layer.addSublayer(progressShape)

        percentLabel.textAlignment = .center
        percentLabel.text = String(format: percentLabelFormat, progress * 100)

        titleLabel.textAlignment = .center
        titleLabel.text = title
    }

    // MARK: - Progress Animation

    public func setProgress(progress: CGFloat, animated: Bool = true) {
        guard progress <= 1.0 else { return }

        var start = progressShape.strokeEnd
        if let presentationLayer = progressShape.presentation(),
            let animations = progressShape.animationKeys(), !animations.isEmpty {
            start = presentationLayer.strokeEnd
        }

        let duration = abs(Double(progress - start)) * completeDuration
        percentLabel.text = String(format: percentLabelFormat, progress * 100)
        progressShape.strokeEnd = progress

        if animated {
            progressAnimation.fromValue = start
            progressAnimation.toValue = progress
            progressAnimation.duration = duration
            progressShape.add(progressAnimation, forKey: progressAnimation.keyPath)
        }
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
