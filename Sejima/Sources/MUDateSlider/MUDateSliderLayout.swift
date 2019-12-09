//
//  MUDateSliderLayout.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 31/10/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//
//  Based on: https://github.com/itsmeichigo/DateTimePicker
//

import UIKit

/// Class that describe the MUDateSlider layout
final class MUDateSliderLayout: UICollectionViewFlowLayout {

    // MARK: - Override functions

    /// Returns the content offset to use after an animated layout update or change.
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)

        guard let collectionView = self.collectionView else {
            return .zero
        }

        let targetRect = CGRect(x: proposedContentOffset.x,
                                y: 0.0,
                                width: collectionView.bounds.size.width,
                                height: collectionView.bounds.size.height)

        guard let layout = layoutAttributesForElements(in: targetRect) else {
            return .zero
        }

        let array: [UICollectionViewLayoutAttributes] = layout as [UICollectionViewLayoutAttributes]
        let horizontalCenter = CGFloat(proposedContentOffset.x + (collectionView.bounds.size.width / 2.0))
        var offSetAdjustment = CGFloat.greatestFiniteMagnitude

        for layoutAttributes: UICollectionViewLayoutAttributes in array
            where layoutAttributes.representedElementCategory == UICollectionView.ElementCategory.cell {
                let itemHorizontalCenter: CGFloat = layoutAttributes.center.x
                if abs(itemHorizontalCenter - horizontalCenter) < abs(offSetAdjustment) {
                    offSetAdjustment = itemHorizontalCenter - horizontalCenter
                }
        }

        var contentOffset = CGPoint(x: proposedContentOffset.x, y: proposedContentOffset.y)
        var nextOffset: CGFloat = proposedContentOffset.x + offSetAdjustment

        repeat {
            contentOffset.x = nextOffset
            let deltaX = proposedContentOffset.x - collectionView.contentOffset.x
            let velX = velocity.x

            if deltaX == 0.0 || velX == 0 || (velX > 0.0 && deltaX > 0.0) || (velX < 0.0 && deltaX < 0.0) {
                break
            }

            if velocity.x > 0.0 {
                nextOffset += snapStep()
            } else if velocity.x < 0.0 {
                nextOffset -= snapStep()
            }
        } while isValidOffset(offset: nextOffset)

        contentOffset.y = 0.0

        return contentOffset
    }

    // MARK: - Private functions

    private func isValidOffset(offset: CGFloat) -> Bool {
        return (offset >= CGFloat(minContentOffset()) && offset <= CGFloat(maxContentOffset()))
    }

    private func minContentOffset() -> CGFloat {
        guard let collectionView = self.collectionView else {
            return 0
        }

        return -CGFloat(collectionView.contentInset.left)
    }

    private func maxContentOffset() -> CGFloat {
        guard let collectionView = self.collectionView else {
            return 0
        }

        return CGFloat(minContentOffset() + collectionView.contentSize.width - itemSize.width)
    }

    private func snapStep() -> CGFloat {
        return itemSize.width + minimumLineSpacing
    }
}
