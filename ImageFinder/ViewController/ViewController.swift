//
//  ViewController.swift
//  ImageFinder
//
//  Created by Andrea Altea on 29/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dataSource: CollectionDataSource!
    
    @IBOutlet weak var searchBar: ExpandableSearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        self.searchBar.alpha = 0.0
        
        self.registerCells()
        self.dataSource = CollectionDataSource(collection: self.collectionView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.searchBar.alpha == 0.0 {
            self.showSearchBar()
        }
    }
    
    private func showSearchBar() {
        
        UIView.animate(withDuration: 0.3) {
            self.searchBar.alpha = 1.0
            self.searchBar.becomeFirstResponder()
        }
    }
}

// MARK: - Search Interaction

extension ViewController: ExpandableSearchBarDelegate {
    
    func searchBarDidBeginEditing(_ searchBar: ExpandableSearchBar) {
        
        self.collectionView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.collectionView.alpha = 0.2
        }
    }
    
    func searchBar(_ searchBar: ExpandableSearchBar, didEndEditingWith string: String?) {

        self.collectionView.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.3) {
            self.collectionView.alpha = 1
        }
        
        guard let string = string else {
            self.dataSource.model = []
            return
        }
        
        APIManager.standard.getImages(for: string) { (result) in
            
            switch result {
            case .failure:
                self.dataSource.model = []
                
            case .success(value: let searchResult):
                
                let section = UnsplashSectionViewModel.prepare(searchResult)
                self.dataSource.model = [section]
            }
        }
    }
}

// MARK: - CollectionView Setup

extension ViewController {
    
    func registerCells() {
        
        let identifier = UnsplashCell.nibIdentifier
        let nib = UINib(nibName: identifier, bundle: .main)
        self.collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
}
