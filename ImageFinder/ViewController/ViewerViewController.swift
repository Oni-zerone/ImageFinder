//
//  DetailViewController.swift
//  ImageFinder
//
//  Created by Andrea Altea on 01/12/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit
import Kingfisher

protocol ViewerContent {
    
    var imageRatio: CGFloat { get }
    
    var lowResPath: String { get }
    
    var midResPath: String { get }
    
    var highResPath: String { get }
    
    var likes: String { get }
    
    var downloads: String { get }
        
    var detailBuilder: Builder { get }
}

class ViewerViewController: UIViewController {

    var image: ViewerContent? {
        didSet {
            self.loadContent()
        }
    }
    var highRes = false
    var midRes = false
    
    @IBOutlet weak var ratioConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var downloadsLabel: UILabel!
    @IBOutlet weak var userButton: UIButton!
    
    var transition: ZoomInAnimatedTransitioning?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(tapZoom(_:)))
        doubleTap.numberOfTapsRequired = 2
        self.scrollView.addGestureRecognizer(doubleTap)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        self.navigationController?.setNavigationBarHidden(false, animated: true)

        self.loadContent()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.view.clipsToBounds = true
    }
    
    @IBAction func showDetail(_ sender: Any) {
        
        guard let builder = self.image?.detailBuilder,
            let detailController = builder.make(from: nil) else {
                return
        }
        self.present(detailController, animated: true, completion: nil)
    }
    
    func loadContent() {
        
        guard self.isViewLoaded else { return }
        
        self.activityIndicator.startAnimating()
        self.favoritesLabel.text = self.image?.likes
        self.downloadsLabel.text = self.image?.downloads
        
        guard let resource = ImageLoader(path: self.image?.lowResPath) else { return }
        self.imageView.kf.setImage(with: resource, placeholder: self.imageView.image) { (image, error, cache, url) in
            
            self.imageView.image = image
            self.midRes = false
            self.highRes = false
            self.activityIndicator.stopAnimating()
        }
    }
    
    func loadMidResContent() {
        
        guard !self.midRes, !self.highRes,
            let resource = ImageLoader(path: self.image?.midResPath) else {
                return
        }

        self.midRes = true
        self.imageView.kf.setImage(with: resource, placeholder: self.imageView.image)
    }
    
    func loadHighResContent() {

        guard !self.highRes,
            let resource = ImageLoader(path: self.image?.highResPath) else {
                return
        }
        
        self.highRes = true
        self.imageView.kf.setImage(with: resource, placeholder: self.imageView.image)

    }
}

// MARK: - Zoom

extension ViewerViewController {
    
    @objc func tapZoom(_ sender: UITapGestureRecognizer?) {
        if self.scrollView.zoomScale > 2 {
            self.zoomOut(sender)
            return
        }
        self.zoomIn(sender)
    }
    
    private func zoomIn(_ sender: UITapGestureRecognizer?) {
        if let location = sender?.location(in: self.scrollView) {
            
            let scale: CGFloat = 4.0
            let size = self.scrollView.bounds.size
            let zoomedHeight = size.height / scale
            let zoomedWidth = size.width / scale
            
            let originY = location.y - zoomedHeight / 2
            let originX = location.x - zoomedHeight / 2
            let rect = CGRect(x: originX, y: originY, width: zoomedWidth, height: zoomedHeight)
            self.scrollView.zoom(to: rect, animated: true)
        }
    }
    
    private func zoomOut(_ sender: UITapGestureRecognizer?) {
        self.scrollView.setZoomScale(1, animated: true)
    }
}

// MARK: - ScrollViewDelegate

extension ViewerViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
        if !self.highRes,
            scrollView.zoomScale > 3.5 {
            self.loadHighResContent()
            return
        }

        if !self.midRes,
            !self.highRes,
            scrollView.zoomScale > 1.5 {
            self.loadMidResContent()
            return
        }
    }
}

extension ViewerViewController: UIViewControllerTransitioningDelegate {
    
    override var transitioningDelegate: UIViewControllerTransitioningDelegate? {
        set {  }
        get {
            return self
        }
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.loadView()
        let transition = self.transition
        transition?.destinationView = self.imageView
        return transition
    }
}
