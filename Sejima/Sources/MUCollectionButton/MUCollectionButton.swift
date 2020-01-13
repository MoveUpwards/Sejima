//
//  MUCollectionButton.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 28/01/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit
import Neumann

/// Delegate protocol for MUCollectionButton.
@objc public protocol MUCollectionButtonDelegate: class {
    /// Will trigger each time a button is tapped.
    func didTap(collectionButton: MUCollectionButton, at index: Int)
}

/// Class that regroup multiple UIButton with customizable options.
@IBDesignable
open class MUCollectionButton: MUNibView {
    @IBOutlet private var activityIndicator: MUActivityIndicatorProtocol!
    @IBOutlet private var stackView: UIStackView!

    @IBOutlet private var leading: NSLayoutConstraint!
    @IBOutlet private var trailing: NSLayoutConstraint!

    /// The object that acts as the delegate of the collection button.
    @IBOutlet public weak var delegate: MUCollectionButtonDelegate? // swiftlint:disable:this private_outlet strong_iboutlet line_length

    // MARK: - Activity Indicator design

    /// Specifies the loading indicator color appearance while it shows.
    @IBInspectable open dynamic var indicatorColor: UIColor = .white {
        didSet {
            activityIndicator.color = indicatorColor
        }
    }

    // MARK: - Background design

    /// Specifies the collection button border color.
    @IBInspectable open dynamic var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    /// Specifies the collection button border width.
    @IBInspectable open dynamic var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    /// Describes the spacing between text and separator but only on autolayout view
    @IBInspectable open dynamic var spacing: CGFloat = 0.0 {
        didSet {
            stackView.spacing = spacing
        }
    }

    /// Specifies collection button items have a separator view.
    @IBInspectable open dynamic var hasSeparator: Bool = false {
        didSet {
            updateStackView()
        }
    }

    /// Specifies collection button items separator height multiplier.
    @IBInspectable open dynamic var separatorHeightMultiplier: CGFloat = 1.0 {
        didSet {
            updateStackView()
        }
    }

    // MARK: - Text Button Design

    /// Specifies collection button items text color.
    @IBInspectable open dynamic var textColor: UIColor = .black {
        didSet {
            stackView.arrangedSubviews
                .compactMap({ $0 as? UIButton })
                .forEach({ button in
                    button.setTitleColor(textColor, for: .normal)
                    button.setTitleColor(textColor.withAlphaComponent(0.5), for: .disabled)
                })
        }
    }

    /// Specifies collection button items text color for selected state.
    @IBInspectable open dynamic var selectedTextColor: UIColor = .lightGray {
        didSet {
            stackView.arrangedSubviews
                .compactMap({ $0 as? UIButton })
                .forEach { button in
                    button.setTitleColor(selectedTextColor, for: .highlighted)
                }
        }
    }

    /// Specifies collection button items text font.
    @objc open dynamic var textFont: UIFont = .systemFont(ofSize: 17, weight: .regular) {
        didSet {
            updateStackView()
        }
    }

    /// Define the inset of the background and chart
    @IBInspectable open dynamic var horizontalPadding: CGFloat = 0.0 {
        didSet {
            leading.constant = horizontalPadding
            trailing.constant = horizontalPadding
        }
    }

    // MARK: - Public functions

    /// Define the button collection
    open var items: [MUCollectionItem] = [] {
        didSet {
            updateStackView()
        }
    }

    /// Show or hide the progress indicator.
    @IBInspectable open dynamic var isLoading: Bool = false {
        didSet {
            isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
            stackView.isHidden = isLoading
        }
    }

    // MARK: - Public functions

    /// Set a custom button progress view
    open func set(_ progress: MUActivityIndicatorProtocol) {
        guard let progressView = progress as? UIView else {
            return
        }

        (self.activityIndicator as? UIView)?.removeFromSuperview()
        progress.color = indicatorColor
        self.activityIndicator = progress

        addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        progressView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        progressView.frame.size = CGSize(width: 20, height: 20)
    }

    /// Define the button state at a given index
    public func set(enabled: Bool, at index: Int) {
        guard let button = stackView.arrangedSubviews
            .flatMap({ $0.subviews })
            .first(where: { $0.tag == index }) as? UIButton else {
                return
        }

        button.isEnabled = enabled
    }

    // MARK: - Private functions

    private func updateStackView() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        items.enumerated().forEach { index, item in
            // Add separator if needed
            if index > 0 && hasSeparator {
                let width: CGFloat
                if bounds.height > 0.0 {
                    width = bounds.height * separatorHeightMultiplier
                } else {
                    width = item.text.constrainedSize(font: textFont).height * separatorHeightMultiplier
                }
                stackView.addArrangedSubview(separatorView(width: width))
            }

            // Add button
            stackView.addArrangedSubview(buttonView(index: index,
                                                    item: item,
                                                    textWidth: item.text.constrainedSize(font: textFont).width,
                                                    imageWidth: bounds.height))
        }
    }

    private func separatorView(width: CGFloat) -> UIView {
        let colorView = UIView()
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.backgroundColor = borderColor

        let bkgView = MUProportionalView()
        bkgView.set(width: borderWidth)
        bkgView.addSubview(colorView)

        colorView.centerXAnchor.constraint(equalTo: bkgView.centerXAnchor).isActive = true
        colorView.centerYAnchor.constraint(equalTo: bkgView.centerYAnchor).isActive = true
        colorView.widthAnchor.constraint(equalToConstant: borderWidth).isActive = true
        colorView.heightAnchor.constraint(equalToConstant: width).isActive = true

        return bkgView
    }

    private func customButton(text: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(text, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.setTitleColor(textColor.withAlphaComponent(0.5), for: .disabled)
        button.setTitleColor(selectedTextColor, for: .highlighted)
        button.titleLabel?.font = textFont
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }

    private func buttonView(index: Int,
                            item: MUCollectionItem,
                            textWidth: CGFloat,
                            imageWidth: CGFloat) -> UIView {
        let buttonView = MUProportionalView()
        buttonView.set(width: textWidth)

        let button = customButton(text: item.text)
        button.tag = index

        if let image = item.image { // If image, change settings
            buttonView.set(width: imageWidth)
            button.setImage(image, for: .normal)
        }

        buttonView.addAutolayoutSubview(button)

        return buttonView
    }

    @objc
    private func buttonTapped(sender: UIButton) {
        delegate?.didTap(collectionButton: self, at: sender.tag)
    }

    // MARK: - Life cycle functions

    /// Default setup to load the view from a xib file.
    override open func xibSetup() {
        super.xibSetup()

        layer.cornerRadius = bounds.height * 0.5
    }
}
