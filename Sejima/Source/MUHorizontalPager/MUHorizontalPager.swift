//
//  MUHorizontalPager.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 06/12/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// Delegate protocol for MUHorizontalPager.
public protocol MUHorizontalPagerDelegate: class {
    /// Will trigger each time the page index change.
    func didScroll(_ horizontalPager: MUHorizontalPager, to index: Int)
}

/// Class that act like UIScrollView + isPagingEnabled with more customizable options.
@IBDesignable
open class MUHorizontalPager: MUNibView {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var contentView: UIView!

    @IBOutlet private var scrollViewTraillingMargin: NSLayoutConstraint!
    @IBOutlet private var scrollViewLeadingMargin: NSLayoutConstraint!

    private var currentIndex = 0 // To don't call delegate each scroll moves

    /// The object that acts as the delegate of the pager.
    open weak var delegate: MUHorizontalPagerDelegate?

    /// The pager can interact with a page control.
    open weak var pageControl: MUPageControl? {
        didSet {
            pageControl?.numberOfPages = numberOfPages
            pageControl?.set(page: currentIndex, animated: false)
            pageControl?.delegate = self
        }
    }

    // MARK: - Public IBInspectable and UIAppearence variables

    /// Describes the margin around the scroll view (The part on the margin will be visible but not scrollable)
    @IBInspectable open dynamic var horizontalMargin: CGFloat = 0.0 {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    /// Describes the offset between two pages
    @IBInspectable open dynamic var offset: CGFloat = 0.0

    // MARK: - Visual functions

    open override func updateConstraints() {
        super.updateConstraints()

        scrollViewTraillingMargin.constant = horizontalMargin
        scrollViewLeadingMargin.constant = horizontalMargin
    }

    // MARK: - Add datas

    private var numberOfPages = 0

    open func add(views: [UIView]) {
        scrollView.subviews.filter({ $0 != contentView }).forEach({ $0.removeFromSuperview() })

        var lastTrailingAnchor = contentView.leadingAnchor
        var lastView: UIView?
        numberOfPages = views.count
        pageControl?.numberOfPages = numberOfPages

        views.enumerated().forEach { index, view in
            view.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(view)
            view.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            view.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
            view.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            view.leadingAnchor.constraint(equalTo: lastTrailingAnchor,
                                          constant: index == 0 ? 0 : offset).isActive = true

            lastTrailingAnchor = view.trailingAnchor
            lastView = view
        }

        lastView?.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
    }

    // MARK: - Public functions

    public func set(index: Int, animated: Bool = false) {
        guard index >= 0, index < numberOfPages else { return }

        pageControl?.set(page: index, animated: true)

        UIView.animate(withDuration: animated ? 0.3 : 0.0) { [weak self] in
            guard let offset = self?.contentOffset(at: CGFloat(index)) else { return }
            self?.scrollView.contentOffset.x = offset
        }
    }

    // MARK: - Private functions

    private func contentOffset(at index: CGFloat) -> CGFloat {
        return index * scrollView.bounds.width - scrollView.contentInset.left + index * offset
    }
}

extension MUHorizontalPager: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int(round(scrollView.contentOffset.x / scrollView.bounds.width))

        if index != currentIndex {
            currentIndex = index
            pageControl?.set(page: index, animated: true)
            delegate?.didScroll(self, to: currentIndex)
        }
    }

    public func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                          withVelocity velocity: CGPoint,
                                          targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = scrollView.bounds.width
        var pageIndex = round(scrollView.contentOffset.x / pageWidth)
        let pageX = pageIndex * pageWidth - scrollView.contentInset.left + pageIndex * offset

        if targetContentOffset.pointee.x < pageX - pageWidth * 0.5 {
            pageIndex -= pageIndex > 0 ? 1 : 0
        } else if targetContentOffset.pointee.x > pageX + pageWidth * 0.5 {
            pageIndex += pageIndex < CGFloat(numberOfPages) ? 1 : 0
        }

        targetContentOffset.pointee.x = contentOffset(at: pageIndex)
    }
}

extension MUHorizontalPager: MUPageControlDelegate {
    public func didTap(_ pageControl: MUPageControl, index: Int) {
        set(index: index, animated: true)
    }
}
