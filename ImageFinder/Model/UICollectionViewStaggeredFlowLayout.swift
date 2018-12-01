//
//  UICollectionViewStaggeredFlowLayout.swift
//  ImageFinder
//
//  Created by Andrea Altea on 01/12/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

class UICollectionViewStaggeredFlowLayout: UICollectionViewFlowLayout {

    private var layoutAttributes: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    
    override func prepare() {
        super.prepare()
        
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var rectAttributes: [UICollectionViewLayoutAttributes] = []
        self.layoutAttributes.values.forEach { attributes in
            
            if attributes.frame.intersects(rect) {
                rectAttributes.append(attributes)
            }
        }
        return rectAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.layoutAttributes[indexPath]
    }
}

fileprivate extension UICollectionViewStaggeredFlowLayout {
    
    var dataSource: UICollectionViewDataSource? {
        return self.collectionView?.dataSource
    }
    
    var numberOfSections: Int {
        
        guard let collection = self.collectionView else { return 0 }
        return self.dataSource?.numberOfSections?(in: collection) ?? 0
    }
    
    func numberOfItems(in section: Int) -> Int {
    
        guard let collection = self.collectionView else { return 0 }
        return self.dataSource?.collectionView(collection, numberOfItemsInSection: section) ?? 0
    }
}

fileprivate extension UICollectionViewStaggeredFlowLayout {
    
    var flowDelegate: UICollectionViewDelegateFlowLayout? {
        return self.collectionView?.delegate as? UICollectionViewDelegateFlowLayout
    }
    
    func insets(in section: Int) -> UIEdgeInsets {
        
        guard let collection = self.collectionView else { return .zero }
        return self.flowDelegate?.collectionView?(collection,
                                                  layout: self,
                                                  insetForSectionAt: section) ?? .zero
    }
    
    func interItemSpacing(in section: Int) -> CGFloat {
        
        guard let collection = self.collectionView else { return 0 }
        return self.flowDelegate?.collectionView?(collection,
                                                  layout: self,
                                                  minimumInteritemSpacingForSectionAt: section) ?? 0
    }
    
    func interLineSpacing(in section: Int) -> CGFloat {

        guard let collection = self.collectionView else { return 0 }
        return self.flowDelegate?.collectionView?(collection,
                                                  layout: self,
                                                  minimumLineSpacingForSectionAt: section) ?? 0
    }
    
    func sizeofItem(at indexPath: IndexPath) -> CGSize {
        
        guard let collection = self.collectionView else { return .zero }
        return self.flowDelegate?.collectionView!(collection, layout: self, sizeForItemAt: indexPath) ?? .zero
    }
}
