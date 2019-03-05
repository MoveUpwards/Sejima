//
//  MUSegmentedControl.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 13/12/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// Delegate protocol for MUSegmentControl.
@objc public protocol MUSegmentControlDelegate: class {
    /// Will trigger each time a button is tapped.
    func didSelect(_ button: MUSegmentedControl, at index: Int)
}

/// Class that act like UISegmentedControl with more customizable options.
@IBDesignable
open class MUSegmentedControl: UIControl {
    private var initialIndicatorViewFrame: CGRect?
    private var normalSegmentsView = UIView()
    private var selectedSegmentsView = UIView()
    private var indicatorView = MUSegmentIndicatorView()

    @IBOutlet public weak var delegate: MUSegmentControlDelegate? // swiftlint:disable:this private_outlet strong_iboutlet line_length

    /// The button’s corner radius.
    @IBInspectable open dynamic var cornerRadius: CGFloat = 0.0 {
        didSet {
            updateCornerRadius()
        }
    }

    /// The button’s border width.
    @IBInspectable open dynamic var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    /// Define the font if there is no theme
    @objc open dynamic var titleFont: UIFont = .systemFont(ofSize: 12.0) {
        didSet {
            normalSegmentsView.subviews.compactMap({ $0 as? UILabel }).forEach { label in
                label.font = titleFont
            }
            selectedSegmentsView.subviews .compactMap({ $0 as? UILabel }) .forEach { label in
                label.font = titleFont
            }
        }
    }

    /// Define the title color if there is no theme.
    @IBInspectable open dynamic var titleColor: UIColor = .black {
        didSet {
            normalSegmentsView.subviews.compactMap({ $0 as? UILabel }).forEach { label in
                label.textColor = titleColor
            }
        }
    }

    /// Define the selected title color if there is no theme.
    @IBInspectable open dynamic var selectedTitleColor: UIColor = .white {
        didSet {
            selectedSegmentsView.subviews .compactMap({ $0 as? UILabel }) .forEach { label in
                label.textColor = selectedTitleColor
            }
        }
    }

    /// Define the selected color if there is no theme.
    @IBInspectable open dynamic var selectedColor: UIColor = .lightGray {
        didSet {
            selectedSegmentsView.subviews .compactMap({ $0 as? UILabel }) .forEach { label in
                label.backgroundColor = selectedColor
            }
        }
    }

    /// Define the inset between the indicator and the border.
    @IBInspectable open dynamic var indicatorInset: CGFloat = 4.0 {
        didSet {
            layer.masksToBounds = indicatorInset >= 0.0
            updateCornerRadius()
            setNeedsLayout()
        }
    }

    /// Define the space between each segment.
    @IBInspectable open dynamic var segmentSpacing: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }

    /// Define if the user can pan to change the index.
    @IBInspectable open dynamic var allowPanningGesture: Bool = true

    /// Returns the number of segments the receiver has.
    public var numberOfSegments: Int {
        return segments.count
    }

    /// The index number identifying the selected segment (that is, the last segment touched).
    public private(set) var selectedSegmentIndex: Int = 0 {
        didSet {
            delegate?.didSelect(self, at: selectedSegmentIndex)
        }
    }

    /// The segments available for selection
    public var segments = [MUSegmentItem]() {
        didSet {
            guard segments.count > 1 else { return }

            normalSegmentsView.subviews.forEach({ $0.removeFromSuperview() })
            selectedSegmentsView.subviews.forEach({ $0.removeFromSuperview() })

            for segment in segments {
                let font = segment.titleFont ?? titleFont
                let selectedColor = segment.selectedColor ?? self.selectedColor
                let titleColor = segment.titleColor ?? self.titleColor
                let selectedTitleColor = segment.selectedTitleColor ?? self.selectedTitleColor

                normalSegmentsView.addSubview(label(with: segment.title,
                                                    selectedColor: .clear,
                                                    font: font,
                                                    textColor: titleColor))
                selectedSegmentsView.addSubview(label(with: segment.title,
                                                      selectedColor: selectedColor,
                                                      font: font,
                                                      textColor: selectedTitleColor))
            }

            setNeedsLayout()
        }
    }

    // MARK: - Public methods

    /// Define the current segment index, animated or not.
    public func set(index: Int, animated: Bool = false) {
        guard normalSegmentsView.subviews.indices.contains(index) else {
            return
        }

        selectedSegmentIndex = index
        moveIndicatorView(to: index, animated: animated)
        setNeedsLayout()
    }

    // MARK: - Life cycle functions

    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    public override init(frame: CGRect) {
        super.init(frame: frame)

//        translatesAutoresizingMaskIntoConstraints = true
        setup()
    }

    /// Returns an object initialized from data in a given unarchiver.
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

//        translatesAutoresizingMaskIntoConstraints = false
        setup()
    }

    /// Initializes and returns a newly allocated view object with a zero frame rectangle.
    convenience init() {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }

    /// Lays out subviews.
    override open func layoutSubviews() {
        super.layoutSubviews()

        var currentSelectedColor = selectedColor
        if selectedSegmentIndex >= 0, selectedSegmentIndex < segments.count,
            let color = segments[selectedSegmentIndex].selectedColor {
            currentSelectedColor = color
        }

        layer.borderColor = currentSelectedColor.cgColor

        guard normalSegmentsView.subviews.count > 1 else {
            return
        }

        normalSegmentsView.frame = bounds
        selectedSegmentsView.frame = bounds

        indicatorView.frame = elementFrame(at: selectedSegmentIndex)

        for index in 0...normalSegmentsView.subviews.count - 1 {
            let frame = elementFrame(at: index)
            normalSegmentsView.subviews[index].frame = frame

            selectedSegmentsView.subviews[index].frame = frame
            selectedSegmentsView.subviews[index].backgroundColor = currentSelectedColor
        }

        invalidateIntrinsicContentSize()
    }

    /// The natural size for the receiving view, considering only properties of the view itself.
    override open var intrinsicContentSize: CGSize {
        return CGSize(width: 121, height: 28) // To act like a UISegmentedControl with a default size
    }

    // MARK: - Private methods

    private func setup() {
        layer.masksToBounds = true

        normalSegmentsView.clipsToBounds = true
        addSubview(normalSegmentsView)
        addSubview(indicatorView)
        selectedSegmentsView.clipsToBounds = true
        addSubview(selectedSegmentsView)

        selectedSegmentsView.layer.mask = indicatorView.layerMask

        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(MUSegmentedControl.tapped(_:)))
        addGestureRecognizer(tapGesture)
        let panGesture = UIPanGestureRecognizer(target: self,
                                                action: #selector(MUSegmentedControl.panned(_:)))
        panGesture.delegate = self
        addGestureRecognizer(panGesture)

        setNeedsLayout()
    }

    private func label(with title: String,
                       selectedColor: UIColor,
                       font: UIFont,
                       textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = title
        label.backgroundColor = selectedColor
        label.font = font
        label.textColor = textColor
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center

        return label
    }

    private func updateCornerRadius() {
        layer.cornerRadius = cornerRadius
        indicatorView.cornerRadius = cornerRadius - indicatorInset
        normalSegmentsView.subviews.forEach { $0.layer.cornerRadius = indicatorView.cornerRadius }
    }

    private func elementFrame(at index: Int) -> CGRect {
        let totalInsetSize = indicatorInset * 2.0
        let elementWidth = (bounds.width - totalInsetSize) / CGFloat(normalSegmentsView.subviews.count)
        let elementSpacing = segmentSpacing * CGFloat(index)
        return CGRect(x: CGFloat(index) * elementWidth + indicatorInset + elementSpacing,
                      y: indicatorInset,
                      width: elementWidth,
                      height: bounds.height - totalInsetSize)
    }

    private func nearestIndex(to point: CGPoint) -> Int {
        let distances = normalSegmentsView.subviews.map { abs(point.x - $0.center.x) }
        return distances.index(of: distances.min() ?? 0) ?? 0
    }

    private func moveIndicatorView(to index: Int, animated: Bool = true) {
        if animated {
            UIView.animate(withDuration: 0.25,
                           delay: 0.0,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 0.0,
                           options: [.beginFromCurrentState, .curveEaseOut],
                           animations: { [weak self] in
                            self?.moveIndicator()
            })
        } else {
            moveIndicator()
        }
    }

    private func moveIndicator() {
        indicatorView.frame = normalSegmentsView.subviews[selectedSegmentIndex].frame
        layoutIfNeeded()
    }

    // MARK: - Action handlers

    @objc
    private func tapped(_ gestureRecognizer: UITapGestureRecognizer) {
        set(index: nearestIndex(to: gestureRecognizer.location(in: self)))
    }

    @objc
    private func panned(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard allowPanningGesture else {
            return
        }

        switch gestureRecognizer.state {
        case .began:
            initialIndicatorViewFrame = indicatorView.frame
        case .changed:
            var frame = initialIndicatorViewFrame ?? .zero
            frame.origin.x += gestureRecognizer.translation(in: self).x
            let targetOriginX = min(frame.origin.x, bounds.width - indicatorInset - frame.width)
            frame.origin.x = max(targetOriginX, indicatorInset)
            indicatorView.frame = frame
        case .ended, .failed, .cancelled:
            let nearestPoint = nearestIndex(to: indicatorView.center)
            set(index: nearestPoint)
        default:
            break
        }
    }
}

// MARK: - UIGestureRecognizerDelegate

extension MUSegmentedControl: UIGestureRecognizerDelegate {
    /// Asks the view if the gesture recognizer should be allowed to continue tracking touch events.
    override open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let gesture = gestureRecognizer as? UIPanGestureRecognizer {
            return indicatorView.frame.contains(gesture.location(in: self))
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
}
