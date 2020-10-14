//
//  CustomUICollectionViewLayout.swift
//  CollectionView
//
//  Created by Роман Копылов on 31.08.2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import Foundation
import UIKit

class CustomCVLayout: UICollectionViewFlowLayout {
    
    var contentBounds = CGRect.zero
    var cachedAttributes = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        super.prepare()
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    
     override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let layoutAttributes = super.layoutAttributesForElements(in: rect) else { return  nil}
//        print("layoutAttributesForElements")
        
        // Helpers
        var sectionsToAdd = Set<Int>()
        var newLayoutAttributes = [UICollectionViewLayoutAttributes]()
                layoutAttributes.forEach { (attribute) in
                switch attribute.representedElementCategory {
                case .cell:
                    newLayoutAttributes.append(attribute)
                    sectionsToAdd.insert(attribute.indexPath.section)
                case .supplementaryView:
                    sectionsToAdd.insert(attribute.indexPath.section)
                default:
                    break
                }
            }
        
            sectionsToAdd.forEach { (section) in
                let indexPath = IndexPath(item: 0, section: section)
                if let sectionAttributes = self.layoutAttributesForSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    at: indexPath) {
                    newLayoutAttributes.append(sectionAttributes)
                }
            }
        
        return newLayoutAttributes
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard let layoutAttributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath) else { return nil }
        guard let boundaries = boundaries(forSection: indexPath.section) else { return layoutAttributes }
        guard let collectionView = collectionView else { return layoutAttributes }

        let contentOffsetY = collectionView.contentOffset.y
        var frameForSupplementaryView = layoutAttributes.frame

        let minimum = boundaries.minimum - frameForSupplementaryView.height
        let maximum = boundaries.maximum - frameForSupplementaryView.height

        if contentOffsetY < minimum {
            frameForSupplementaryView.origin.y = minimum
        } else if contentOffsetY > maximum {
            frameForSupplementaryView.origin.y = maximum
        } else {
            frameForSupplementaryView.origin.y = contentOffsetY
        }

        layoutAttributes.frame = frameForSupplementaryView

        return layoutAttributes
    }
    
    private func boundaries(forSection section: Int) -> (minimum: CGFloat, maximum: CGFloat)? {
        
        var result = (minimum: CGFloat(0.0), maximum: CGFloat(0.0))
        guard let collectionView = collectionView else { return result }
        let numberOfItems = collectionView.numberOfItems(inSection: section)
        
        guard numberOfItems > 0 else { return result }

        if let firstItem = layoutAttributesForItem(at: IndexPath(item: 0, section: section)),
           let lastItem = layoutAttributesForItem(at: IndexPath(item: (numberOfItems - 1), section: section)) {
            result.minimum = firstItem.frame.minY
            result.maximum = lastItem.frame.maxY
            
            result.minimum -= headerReferenceSize.height
            result.maximum -= headerReferenceSize.height

            result.minimum -= sectionInset.top
            result.maximum += (sectionInset.top + sectionInset.bottom)
        }

        return result
    }
}
