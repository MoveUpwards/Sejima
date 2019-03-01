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
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var contentView: UIView!

    @IBOutlet private var scrollViewTraillingMargin: NSLayoutConstraint!
    @IBOutlet private var scrollViewLeadingMargin: NSLayoutConstraint!

    private var currentIndex = 0 // To don't call delegate each scroll moves
    private var numberOfPages = 0
    private var margin = CGFloat(0.0)

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

    /// Describes the margin around the scroll view (The part on the margin will be visible but not scrollable).
    @IBInspectable open dynamic var horizontalMargin: CGFloat = 0.0 {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    // MARK: - Life cycle functions

    /// Updates constraints for the view.
    open override func updateConstraints() {
        super.updateConstraints()

        scrollViewTraillingMargin.constant = horizontalMargin
        scrollViewLeadingMargin.constant = horizontalMargin
    }

    // MARK: - Public functions

    /// Add all views to the pager with an optional margin between each pages.
    open func add(views: [UIView], margin: CGFloat = 0.0) {
        self.margin = margin
        scrollView.subviews.filter({ $0 != contentView }).forEach({ $0.removeFromSuperview() })

        var lastTrailingAnchor = contentView.leadingAnchor
        var lastView: UIView?
        numberOfPages = views.count
        pageControl?.numberOfPages = numberOfPages

        views.enumerated().forEach { index, view in
            scrollView.addAutolayoutSubview(view, leading: nil)
            view.leadingAnchor.constraint(equalTo: lastTrailingAnchor,
                                          constant: index == 0 ? 0 : margin).isActive = true

            lastTrailingAnchor = view.trailingAnchor
            lastView = view
        }

        lastView?.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
    }

    /// Define the current page index, animated or not.
    open func set(page: Int, animated: Bool = false) {
        guard page >= 0, page < numberOfPages else {
            return
        }

        pageControl?.set(page: page, animated: animated)

        UIView.animate(withDuration: animated ? 0.3 : 0.0) { [weak self] in
            guard let offset = self?.contentOffset(at: CGFloat(page)) else {
                return
            }
            self?.scrollView.contentOffset.x = offset
        }
    }

    // MARK: - Private functions

    private func contentOffset(at index: CGFloat) -> CGFloat {
        return index * scrollView.bounds.width - scrollView.contentInset.left + index * margin
    }
}

extension MUHorizontalPager: UIScrollViewDelegate {
    /// Tells the delegate when the user scrolls the content view within the receiver.
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int(round(scrollView.contentOffset.x / scrollView.bounds.width))

        if index != currentIndex {
            currentIndex = index
            pageControl?.set(page: index, animated: true)
            delegate?.didScroll(self, to: currentIndex)
        }
    }

    /// Tells the delegate when the user finishes scrolling the content.
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                          withVelocity velocity: CGPoint,
                                          targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = scrollView.bounds.width
        var pageIndex = round(scrollView.contentOffset.x / pageWidth)
        let pageX = contentOffset(at: pageIndex)

        if targetContentOffset.pointee.x < pageX - pageWidth * 0.5 {
            pageIndex -= pageIndex > 0 ? 1 : 0
        } else if targetContentOffset.pointee.x > pageX + pageWidth * 0.5 {
            pageIndex += pageIndex < CGFloat(numberOfPages) ? 1 : 0
        }

        targetContentOffset.pointee.x = contentOffset(at: pageIndex)
    }
}

extension MUHorizontalPager: MUPageControlDelegate {
    /// Will trigger each time the page control is tapped.
    public func didTap(_ pageControl: MUPageControl, at index: Int) {
        set(page: index, animated: true)
    }
}
