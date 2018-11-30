//
//  CollectionDataSource.swift
//  ImageFinder
//
//  Created by Andrea Altea on 30/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

protocol InteractionDelegate: class {
    
    func didSelect(item: ItemViewModel, in collection: UICollectionView, at indexPath: IndexPath)
}

class CollectionDataSource: NSObject {

    weak var interactionDelegate: InteractionDelegate?
    weak var scrollViewDelegate: UIScrollViewDelegate?
    
    weak var collectionView: UICollectionView?

    var model: CollectionModel {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    init(collection: UICollectionView, model: CollectionModel = []) {

        self.model = model
        super.init()
        
        self.collectionView = collection
        collection.dataSource = self
        collection.delegate = self
    }
}

extension CollectionDataSource: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.item(at: section)?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let model = self.model.item(at: indexPath) else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.cellIdentifier, for: indexPath)
        model.setup(cell: cell, in: collectionView, at: indexPath)
        return cell
    }
}

extension CollectionDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let model = self.model.item(at: indexPath) else { return }
        self.interactionDelegate?.didSelect(item: model, in: collectionView, at: indexPath)
    }
}
