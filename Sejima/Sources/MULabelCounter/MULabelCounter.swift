//
//  MULabelCounter.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

private protocol MUCounter: class {
    func update(_ value: Double, rate: Float) -> Double
}

final private class MULabelCounterLinear: MUCounter {
    public func update(_ value: Double, rate: Float) -> Double {
        return value
    }
}

final private class MULabelCounterEaseIn: MUCounter {
    public func update(_ value: Double, rate: Float) -> Double {
        return Double(powf(Float(value), rate))
    }
}

final private class MULabelCounterEaseOut: MUCounter {
    public func update(_ value: Double, rate: Float) -> Double {
        return Double(1.0 - powf(Float(1.0 - value), rate))
    }
}

final private class MULabelCounterEaseInOut: MUCounter {
    public func update(_ value: Double, rate: Float) -> Double {
        let newt: Double = 2 * value
        if newt < 1 {
            return Double(0.5 * powf(Float(newt), rate))
        } else {
            return Double(0.5 * (2.0 - powf(Float(2.0 - newt), rate)))
        }
    }
}

/// Class that provide a counter label with customizable options.
@IBDesignable
open class MULabelCounter: MUNibView {
    @IBOutlet private var label: UILabel!

    // MARK: - Private variables

    private var displayLink: CADisplayLink?

    private var progress: TimeInterval = 0
    private var lastUpdate: TimeInterval = 0
    private var totalTime: TimeInterval = 0

    private var startValue: Double = 0
    private var targetValue: Double = 0

    private var completionBlock: (() -> Void)?

    private var counter: MUCounter = MULabelCounterLinear()

    // MARK: - Public IBInspectable and UIAppearence variables

    /// The label’s text font.
    @objc open dynamic var textFont: UIFont = .systemFont(ofSize: 24, weight: .bold) {
        didSet {
            label.font = textFont
        }
    }

    /// The label’s text color.
    @IBInspectable open dynamic var textColor: UIColor = .black {
        didSet {
            label.textColor = textColor
        }
    }

    /// Specifies the output format of the label value.
    @IBInspectable open dynamic var format: String = "%.f" {
        didSet {
            setTextValue(currentValue)
        }
    }

    /// The label’s text alignment.
    @objc open dynamic var textAlignment: NSTextAlignment = .center {
        didSet {
            label.textAlignment = textAlignment
        }
    }

    /// Optional: The IBInspectable version of the label’s text alignment.
    @IBInspectable open dynamic var textAlignmentInt: Int {
        get {
            return textAlignment.rawValue
        }
        set {
            textAlignment = NSTextAlignment(rawValue: newValue) ?? .center
        }
    }

    /// Specifies the counter animation type.
    open var animationType: AnimationCurve = .linear {
        didSet {
            switch animationType {
            case .linear:
                counter = MULabelCounterLinear()
            case .easeIn:
                counter = MULabelCounterEaseIn()
            case .easeOut:
                counter = MULabelCounterEaseOut()
            case .easeInOut:
                counter = MULabelCounterEaseInOut()
            @unknown default:
                print("TODO: handle new animation type")
                counter = MULabelCounterLinear()
            }
        }
    }

    /// Optional: The IBInspectable version of the counter animation type.
    @IBInspectable open dynamic var animationTypeInt: Int = 0 {
        didSet {
            switch animationTypeInt {
            case 1:
                animationType = .easeIn
            case 2:
                animationType = .easeOut
            case 3:
                animationType = .easeInOut
            default:
                animationType = .linear
            }
        }
    }

    /// Specifies a custom rate for counter animation
    @IBInspectable open dynamic var rate: Float = 0

    // MARK: - Public functions

    /// Returns the current value
    public var currentValue: Double {
        if progress == 0 {
            return 0
        } else if progress >= totalTime {
            return targetValue
        }

        let percentil = progress / totalTime
        let updatedValue = counter.update(Double(percentil), rate: rate)

        return startValue + updatedValue * (targetValue - startValue)
    }

    /// Start counter animation from 0 up to given value with optional animation duration. Default duration is 0.
    public func count(to value: Double, duration: TimeInterval = 0, completion: (() -> Void)? = nil) {
        startValue = currentValue
        targetValue = value

        displayLink?.invalidate()
        displayLink = nil

        guard duration > 0 else {
            setTextValue(targetValue)
            completion?()
            return
        }

        completionBlock = completion
        progress = 0
        totalTime = duration
        lastUpdate = Date.timeIntervalSinceReferenceDate

        configureTimer()
    }

    // MARK: - Private functions

    private func configureTimer() {
        displayLink = CADisplayLink(target: MUWeakProxy(self), selector: #selector(MUWeakProxy.onScreenUpdate))
        displayLink?.add(to: .current, forMode: .common)
    }

    @objc
    private func updateValue() {
        let now = Date.timeIntervalSinceReferenceDate
        progress += now - lastUpdate
        lastUpdate = now

        if progress >= totalTime {
            self.displayLink?.invalidate()
            self.displayLink = nil
            progress = totalTime
        }

        setTextValue(currentValue)

        if progress == totalTime {
            completionBlock?()
        }
    }

    private func setTextValue(_ value: Double) {
        // check if counting with ints - cast to int
        if nil != format.range(of: "%(.*)d", options: .regularExpression, range: nil)
            || nil != format.range(of: "%(.*)i") {
            label.text = String(format: format, Int(value))
        } else {
            label.text = String(format: format, value)
        }
    }

    private func set(format pattern: String) {
        format = pattern
        setTextValue(currentValue)
    }

    // MARK: - Life cycle functions

    /// Deinit the page control.
    deinit {
        displayLink?.remove(from: .current, forMode: .common)
        displayLink?.invalidate()
    }
}

extension MULabelCounter: Weakable {
    public func updateIfNeeded() {
        updateValue()
    }
}
