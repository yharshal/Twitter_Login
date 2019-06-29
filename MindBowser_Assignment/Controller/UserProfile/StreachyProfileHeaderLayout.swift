//
//  StreachyProfileHeaderLayout.swift
//  Macys
//
//  Created by Redbytes on 12/06/19.
//  Copyright © 2019 Macys. All rights reserved.
//

import UIKit

class StreachyProfileHeaderLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        layoutAttributes?.forEach({ (attributes) in
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader{
                guard let collectionView = collectionView else {
                    return
                }
                sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                itemSize = CGSize(width: collectionView.frame.width / 2 - 2.5, height: collectionView.frame.width / 2 - 2.5)
                minimumInteritemSpacing = 2.5
                minimumLineSpacing = 5
                if collectionView.contentOffset.y > 0{
                    return
                }
                let width = collectionView.frame.width
                let height = attributes.frame.height - collectionView.contentOffset.y
                attributes.frame = CGRect(x: 0, y: collectionView.contentOffset.y, width: width, height: height)
            }
        })
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
