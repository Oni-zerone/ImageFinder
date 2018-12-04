//
//  ViewController.swift
//  ImageFinder
//
//  Created by Andrea Altea on 29/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var pipeline: Pipeline!
    var loader: ImageLoadStep?
    
    private var alreadyScrolled = false
    
    @IBOutlet weak var searchBar: ExpandableSearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak private var dismissGesture: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        self.searchBar.alpha = 0.0
        
        self.setupGesture()
        self.registerCells()
        self.setupPipeline()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
    
    private func setupGesture() {

        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissSearch(_:)))
        gesture.delegate = self
        self.view.addGestureRecognizer(gesture)
        self.dismissGesture = gesture
    }
}

// MARK: - Search Interaction

extension ViewController: ExpandableSearchBarDelegate {
    
    func searchBarDidBeginEditing(_ searchBar: ExpandableSearchBar) {
        
        UIView.animate(withDuration: 0.3) {
            self.collectionView.alpha = 0.2
        }
    }
    
    func searchBar(_ searchBar: ExpandableSearchBar, didEndEditingWith string: String?) {

        UIView.animate(withDuration: 0.3) {
            self.collectionView.alpha = 1
        }
        
        guard let string = string else {
            self.loader?.reset()
            return
        }
        self.loader?.queryString = string
    }
    
    @objc func dismissSearch(_ sender: Any) {
        
        self.searchBar.textField.endEditing(true)
    }
}

// MARK: - CollectionView Setup

extension ViewController {
    
    func registerCells() {
        
        let imageIdentifier = UnsplashCell.nibIdentifier
        let imageNib = UINib(nibName: imageIdentifier, bundle: .main)
        self.collectionView.register(imageNib, forCellWithReuseIdentifier: imageIdentifier)
        
        let messageIdentifier = MessageCollectionViewCell.nibIdentifier
        let messageNib = UINib(nibName: messageIdentifier, bundle: .main)
        self.collectionView.register(messageNib, forCellWithReuseIdentifier: messageIdentifier)
    }
    
    func setupPipeline() {
        
        self.pipeline = Pipeline()
        
        let loader = ImageLoadStep()
        self.pipeline.append(loader)
        self.loader = loader
        
        self.pipeline.append(FullImageLoaderStep())
        self.pipeline.append(FailureMessageDataStep())
        
        let dataSource = CollectionDataSource(collection: self.collectionView)
        dataSource.scrollViewDelegate = self
        dataSource.interactionDelegate = self
        let sourceStep = DataSourceStep(dataSource: dataSource)
        self.pipeline.append(sourceStep)
    }
}

// MARK: - InteractionDelegate

extension ViewController: InteractionDelegate {
    
    func didSelect(item: ItemViewModel, in collection: UICollectionView, at indexPath: IndexPath) {
        
        let cell = collection.cellForItem(at: indexPath)
        guard let viewController = (item as? Builder)?.make(from: cell) else { return }
        self.show(viewController, sender: self)
    }
}

// MARK: - ScrollViewDelegate

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard !alreadyScrolled,
            scrollView.contentOffset.y > self.view.bounds.height / 2,
            scrollView.contentSize.height - (scrollView.contentOffset.y + self.view.bounds.height * 1.2)  < 0 else {
                alreadyScrolled = false
                return
        }
        
        self.alreadyScrolled = true
        self.loader?.loadImages()
    }
}

// MARK: - UIGestureRecognizer

extension ViewController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return self.searchBar.textField.isEditing && !(self.searchBar.text?.isEmpty ?? true)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        return self.searchBar.textField.isEditing && !(self.searchBar.text?.isEmpty ?? true)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return gestureRecognizer == self.dismissGesture
    }
}
