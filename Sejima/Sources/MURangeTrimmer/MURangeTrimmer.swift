//
//  MURangeTrimmer.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 02/02/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Delegate protocol for MURangeTrimmer.
@objc public protocol MURangeTrimmerDelegate: class {
    /// Will trigger each time a range trimmer is selected.
    func didSelect(trimmer: MURangeTrimmer, at index: Int)
    /// Will trigger when a range is cancelled.
    func didCancel(trimmer: MURangeTrimmer)
}

private enum DragType {
    case none, left, center, right
}

/// Controller to create one to n range(s) trimmer
@IBDesignable
open class MURangeTrimmer: MUNibView {
    /// The object that acts as the delegate of the range trimmer.
    @IBOutlet public weak var delegate: MURangeTrimmerDelegate? // swiftlint:disable:this private_outlet strong_iboutlet line_length

    // MARK: - Private variables

    private var dragType = DragType.none
    private var dragIndex = 0
    private var subRanges = [MUSubRange]()
    private var minimumRangePercentage: CGFloat = 5.0
    private var maximumRangeCount: Int = 10

    // MARK: - Public IBInspectable and UIAppearence variables

    /// Define the width of the picker to increase or decrease one range
    @IBInspectable open dynamic var pickerWidth: CGFloat = 8.0 {
        didSet {
            subRanges.forEach { $0.view.pickerWidth = pickerWidth }
        }
    }

    /// Define the width of the clickable area of the picker: 1.0 will be pickerWidth + borderWidth
    @IBInspectable open dynamic var pickerAreaMultiplierWidth: CGFloat = 2.0

    /// Define the color of the indicator of pickers
    @IBInspectable open dynamic var indicatorColor: UIColor = .black {
        didSet {
            subRanges.forEach { $0.view.indicatorColor = indicatorColor }
        }
    }

    /// Define the border's width of each SubRange
    @IBInspectable open dynamic var borderWidth: CGFloat = 0.0 {
        didSet {
            subRanges.forEach { $0.view.borderWidth = borderWidth }
        }
    }

    /// Define the border's color of each SubRange
    @IBInspectable open dynamic var borderColor: UIColor = .white {
        didSet {
            subRanges.forEach { $0.view.borderColor = borderColor }
        }
    }

    /// Define the corner radius of the trimmer and of each SubRange
    @IBInspectable open dynamic var cornerRadius: CGFloat = 0.0 {
        didSet {
            subRanges.forEach { $0.view.cornerRadius = cornerRadius }
        }
    }

    /// Define the padding left and right of the title of each SubRange
    @IBInspectable open dynamic var titlePadding: CGFloat = 20.0 {
        didSet {
            subRanges.forEach { $0.view.titlePadding = titlePadding }
        }
    }

    /// Define the title's color of each SubRange
    @IBInspectable open dynamic var titleColor: UIColor = .black {
        didSet {
            subRanges.forEach { $0.view.titleColor = titleColor }
        }
    }

    /// Define the font of each SubRange
    @objc open dynamic var titleFont: UIFont = .systemFont(ofSize: 16.0) {
        didSet {
            subRanges.forEach { $0.view.titleFont = titleFont }
        }
    }

    /// Define the string that will be add the index + 1 as a new range name
    @IBInspectable open dynamic var defaultTitle: String = "" {
        didSet {
            subRanges.enumerated().forEach { index, subRange in
                if subRange.view.title == oldValue + String(index + 1) {
                    subRanges[index].view.title = defaultTitle + String(index + 1)
                }
            }
        }
    }

    /// Define the appearence of the keyboard when editing the title
    @objc open dynamic var keyboardAppearance: UIKeyboardAppearance = .default {
        didSet {
            subRanges.forEach { $0.view.keyboardAppearance = keyboardAppearance }
        }
    }

    /// Define the caret's color of the UITextField
    @IBInspectable open dynamic var caretColor: UIColor = .clear {
        didSet {
            subRanges.forEach { $0.view.caretColor = caretColor }
        }
    }

    // MARK: - Public functions

    /// Define the title for a given  range trimmer index
    open func set(title: String, at index: Int) {
        guard index >= 0, index < subRanges.count else { return }

        subRanges[index].view.title = title
    }

    /// Returns all range trimmer
    open var ranges: [MUBasicRange] {
        get {
            return subRanges.enumerated().map({ index, subRange in
                return MUBasicRange(with: subRanges[index].view.title, range: subRange.range)
            })
        }
        set {
            subRanges.forEach({ $0.view.removeFromSuperview() })
            subRanges.removeAll()

            newValue.forEach { args in
                addSubRange(start: args.range.location, length: args.range.length)
                subRanges.last?.view.title = args.title
            }
        }
    }

    /// Define the minimum size of a range in percentage, return false if impossible
    @discardableResult
    open func set(minimumPercentage: CGFloat) -> Bool {
        guard minimumPercentage >= 0.0, minimumPercentage <= 100.0,
            let min = subRanges.map({ $0.range.length }).min(),
            minimumPercentage <= min else { return false }

        minimumRangePercentage = minimumPercentage
        return true
    }

    /// Define the max number of range
    @discardableResult
    open func set(maximumCount: Int) -> Bool {
        guard maximumCount >= subRanges.count else { return false }

        maximumRangeCount = maximumCount
        return true
    }

    // MARK: - Add/Remove functions

    /// Split the selected range trimmer
    @discardableResult
    open func split(at index: Int) -> Bool {
        guard subRanges.count < maximumRangeCount, index < subRanges.count,
            subRanges[index].range.length > minimumRangePercentage * 2.0 else { return false }

        let newLength = subRanges[index].range.length * 0.5
        subRanges[index].range.length = newLength
        updateSubRange(at: index)

        addSubRange(start: subRanges[index].range.location + newLength, length: newLength, at: index + 1)

        return true
    }

    /// Remove the selected range trimmer
    @discardableResult
    open func remove(at index: Int) -> Bool {
        guard subRanges.count > 1, index < subRanges.count else { return false }

        subRanges[index].view.removeFromSuperview()
        subRanges.remove(at: index)

        return true
    }

    // MARK: - Life cycle functions

    /// Default setup to load the view from a xib file.
    open override func xibSetup() {
        super.xibSetup()

        addSubRange(start: 0.0, length: 100.0) // Add a full SubRange by default
    }

    /// Lays out subviews.
    override open func layoutSubviews() {
        super.layoutSubviews()

        subRanges.enumerated().forEach({ updateSubRange(at: $0.offset) })
    }
}

// MARK: - Private functions

extension MURangeTrimmer {
    private func addSubRange(start: CGFloat, length: CGFloat, at index: Int? = nil) {
        var subRange = MUSubRange(range: MURange(location: start, length: length), view: MUSubRangeView())
        subRange.view.borderColor = borderColor
        subRange.view.borderWidth = borderWidth
        subRange.view.cornerRadius = cornerRadius
        subRange.view.pickerWidth = pickerWidth
        subRange.view.indicatorColor = indicatorColor
        subRange.view.titleColor = titleColor
        subRange.view.titleFont = titleFont
        subRange.view.title = defaultTitle + String((index ?? 0) + 1)
        subRange.view.keyboardAppearance = keyboardAppearance
        subRange.view.caretColor = caretColor
        addSubview(subRange.view)

        subRange.view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        subRange.view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        subRange.leading = subRange.view.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                                  constant: start / 100.0 * bounds.width)
        subRange.leading?.isActive = true
        let constraint = NSLayoutConstraint(item: subRange.view,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: self,
                                            attribute: .width,
                                            multiplier: length / 100.0)
        constraint.priority = .init(0.1)
        constraint.isActive = true
        subRange.width = constraint

        if let index = index {
            subRanges.insert(subRange, at: index)
        } else {
            subRanges.append(subRange)
        }
    }

    private func updateSubRange(at index: Int) {
//        var subRange = subRanges[index]
        subRanges[index].leading?.constant = subRanges[index].range.location / 100.0 * bounds.width
        subRanges[index].width?.isActive = false
        let constraint = NSLayoutConstraint(item: subRanges[index].view,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: self,
                                            attribute: .width,
                                            multiplier: subRanges[index].range.length / 100.0)
        let priority: Float
        if let width = subRanges[index].width, width.priority.rawValue < 1000.0 - 0.1 {
            priority = width.priority.rawValue + 0.1
        } else {
            priority = 1000.0
        }
        constraint.priority = .init(priority)
        constraint.isActive = true
        subRanges[index].width = constraint
    }

    private func index(of touch: UITouch) -> Int {
        let location = touch.preciseLocation(in: self)

        for (index, subRange) in subRanges.enumerated() {
            guard subRange.view.frame.contains(location) else {
                continue
            }
            return index
        }

        return -1
    }

    private func update(at index: Int, with touch: UITouch) {
        let location = touch.location(in: subRanges[dragIndex].view)
        let previousLocation = touch.precisePreviousLocation(in: subRanges[dragIndex].view)

        guard abs(location.x - previousLocation.x) > 1.0 else { return } // Need 1 pixel to be a real drag

        let delta = (location.x - previousLocation.x) / bounds.width * 100.0
        let minStart = index > 0 ?
            subRanges[index - 1].range.location + subRanges[index - 1].range.length :
            CGFloat(0.0)
        let maxEnd = index < subRanges.count - 1 ? subRanges[index + 1].range.location : CGFloat(100.0)

        switch findDragType(for: location.x, width: subRanges[index].view.bounds.width) {
        case .left:
            updateLeft(for: delta, minStart: minStart, at: index)
        case .right:
            updateRight(for: delta, maxEnd: maxEnd, at: index)
        case.center:
            updateCenter(for: delta, minStart: minStart, maxEnd: maxEnd, at: index)
        case .none:
            return // Something went wrong
        }

        updateSubRange(at: index)
    }

    private func findDragType(for posX: CGFloat, width: CGFloat) -> DragType {
        guard dragType == .none else {
            return dragType
        }

        if posX < (pickerWidth + borderWidth) * pickerAreaMultiplierWidth {
            dragType = .left
        } else if posX > width - (pickerWidth + borderWidth) * pickerAreaMultiplierWidth {
            dragType = .right
        } else {
            dragType = .center
        }

        return dragType
    }

    private func updateLeft(for delta: CGFloat, minStart: CGFloat, at index: Int) {
        if subRanges[index].range.location + delta < minStart {
            subRanges[index].range.length += subRanges[index].range.location - minStart
            subRanges[index].range.location = minStart
        } else if subRanges[index].range.length - delta < minimumRangePercentage {
            subRanges[index].range.location += subRanges[index].range.length - minimumRangePercentage
            subRanges[index].range.length = minimumRangePercentage
        } else {
            subRanges[index].range.location += delta
            subRanges[index].range.length -= delta
        }
    }

    private func updateRight(for delta: CGFloat, maxEnd: CGFloat, at index: Int) {
        if subRanges[index].range.location + subRanges[index].range.length + delta > maxEnd {
            subRanges[index].range.length = maxEnd - subRanges[index].range.location
        } else if subRanges[index].range.length + delta < minimumRangePercentage {
            subRanges[index].range.length = minimumRangePercentage
        } else {
            subRanges[index].range.length += delta
        }
    }

    private func updateCenter(for delta: CGFloat, minStart: CGFloat, maxEnd: CGFloat, at index: Int) {
        if subRanges[index].range.location + delta < minStart {
            subRanges[index].range.location = minStart
        } else if subRanges[index].range.location + subRanges[index].range.length + delta > maxEnd {
            subRanges[index].range.location = maxEnd - subRanges[index].range.length
        } else {
            subRanges[index].range.location += delta
        }
    }
}

// MARK: - Delegate functions

extension MURangeTrimmer {
    @IBAction private func touchUpInside(_ sender: UIControl, forEvent event: UIEvent) {
        endEditing(true)
        guard dragType == .none else {
            dragEnded(sender)
            return
        }

        guard let touch = event.allTouches?.first else { return }

        let selectedIndex = index(of: touch)
        if selectedIndex >= 0 {
            delegate?.didSelect(trimmer: self, at: selectedIndex)
        } else {
            delegate?.didCancel(trimmer: self)
        }
    }

    // MARK: - Draggable functions

    // Connect TouchDragExit, TouchDragOutside, TouchUpOutside
    @IBAction private func dragEnded(_ sender: UIControl) {
        dragType = .none
    }

    @IBAction private func dragInside(_ sender: UIControl, forEvent event: UIEvent) {
        endEditing(true)
        delegate?.didCancel(trimmer: self)

        guard let touch = event.allTouches?.first else { return }
        guard dragType == .none else {
            update(at: dragIndex, with: touch)
            return
        }

        dragIndex = index(of: touch)
        guard dragIndex >= 0 else { return }

        update(at: dragIndex, with: touch)
    }
} //swiftlint:disable:this file_length
