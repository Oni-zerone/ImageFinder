//
//  CollectionModel.swift
//  ImageFinder
//
//  Created by Andrea Altea on 30/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

typealias CollectionModel = [SectionViewModel]

protocol SectionViewModel {
    
    var columns: Int { get }
    
    var items: [ItemViewModel] { get }
    
    var insets: UIEdgeInsets { get }
    
    var interItemSpacing: CGFloat { get }
    
    var interLineSpacing: CGFloat { get }
}

protocol ItemViewModel {
    
    var cellIdentifier: String { get }
    
    var multiplier: CGFloat { get }

    var constant: CGFloat { get }

    func setup(cell: UICollectionViewCell, in collection: UICollectionView, at indexPath: IndexPath)
    
    func sizeofCell(in collectionView: UICollectionView, with module: SizeModule) -> CGSize
}

extension ItemViewModel {
    
    func sizeofCell(in collectionView: UICollectionView, with module: SizeModule) -> CGSize {
        
        return module.size(multiplier: self.multiplier, constant: self.constant)
    }
}

struct SizeModule {
    
    var width: CGFloat
    
    func size(multiplier: CGFloat, constant: CGFloat) -> CGSize {
        
        let height = self.width * multiplier + constant
        return CGSize(width: self.width, height: height)
    }
}
