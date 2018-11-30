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
        print("SEARCHBAR: didStartEditing")
    }
    
    func searchBar(_ searchBar: ExpandableSearchBar, didEndEditingWith string: String?) {
        print("SEARCHBAR: didEndEditing string: \(string ?? "nil")")
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
