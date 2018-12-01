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
        
        var layoutAttributes: [IndexPath: UICollectionViewLayoutAttributes] = [:]
        var sectionPosition = CGPoint.zero
        
        let sectionCount = self.numberOfSections
        (0 ..< sectionCount).forEach { (section) in
            let sectionAttributes = self.prepareAttributes(for: section, startPoint: sectionPosition)
            sectionPosition = sectionAttributes.endPoint
            sectionAttributes.attributes.forEach({ layoutAttributes[$0] = $1 })
        }
        self.layoutAttributes = layoutAttributes
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

// MARK: - Attributes Calculation

fileprivate extension UICollectionViewStaggeredFlowLayout {
    
    func prepareAttributes(for section: Int, startPoint: CGPoint) -> (endPoint: CGPoint, attributes: [IndexPath: UICollectionViewLayoutAttributes]) {

        let itemsCount = self.numberOfItems(in: section)
        guard itemsCount > 0 else {
            return (endPoint: startPoint, attributes: [:])
        }
        
        let columns = defineColumns(in: section, from: startPoint, totalItems: itemsCount)
        var anchors = columns.anchors
        let columnsCount = anchors.count
        var attributes = columns.attributes

        let interlineSpace = self.interLineSpacing(in: section)
        
        (anchors.count ..< itemsCount).forEach { itemIndex in
            
            let column = itemIndex % columnsCount
            let indexPath = IndexPath(item: itemIndex, section: section)
            let itemAttributes = self.prepareAttributes(forItemAt: indexPath, anchor: anchors[column])
            attributes[indexPath] = itemAttributes
            
            anchors[column] = CGPoint(x: itemAttributes.frame.minX,
                                      y: itemAttributes.frame.maxY + interlineSpace)
        }
        
        var maxY: CGFloat = 0
        anchors.forEach { anchor in
            maxY = max(maxY, anchor.y)
        }
        return (endPoint: CGPoint(x: startPoint.x, y: maxY + self.insets(in: section).bottom), attributes: attributes)
    }
    
    private func defineColumns(in section: Int,
                               from startPoint: CGPoint,
                               totalItems: Int) -> (anchors: [CGPoint], attributes: [IndexPath : UICollectionViewLayoutAttributes]) {
        
        guard let collection = self.collectionView else {
            return (anchors: [], attributes: [:])
        }
        
        let insets = self.insets(in: section)
        let interItemSpacing = self.interItemSpacing(in: section)
        let interLineSpacing = self.interLineSpacing(in: section)
        let maxX = collection.bounds.width - insets.right
        var origin = CGPoint(x: startPoint.x + insets.left, y: startPoint.y + insets.top)
        
        var anchors: [CGPoint] = []
        var attributes: [IndexPath: UICollectionViewLayoutAttributes] = [:]
        
        _ = (0 ..< totalItems).first(where: { (index) -> Bool in
            
            let indexPath = IndexPath(item: index, section: section)
            let itemSize = self.sizeofItem(at: indexPath)
            let itemMaxX = itemSize.width + origin.x
            guard itemMaxX <= maxX else {
                return true
            }
            
            anchors.append(CGPoint(x: origin.x, y: origin.y + itemSize.height + interLineSpacing))
            let itemAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            itemAttributes.frame = CGRect(origin: origin, size: itemSize)
            attributes[indexPath] = itemAttributes
            origin = CGPoint(x: itemMaxX + interItemSpacing, y: origin.y)
            return false
        })
        
        return (anchors: anchors, attributes: attributes)
    }
    
    func prepareAttributes(forItemAt indexPath: IndexPath, anchor: CGPoint) -> UICollectionViewLayoutAttributes {
        
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let size = self.sizeofItem(at: indexPath)
        attributes.frame = CGRect(origin: anchor, size: size)
        return attributes
    }
}

// MARK: - DataSource Helper

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

// MARK: - Delegate Helper

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
