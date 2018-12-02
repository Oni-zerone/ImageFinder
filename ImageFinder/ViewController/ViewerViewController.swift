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
    
    var lowResPath: String { get }
    
    var midResPath: String { get }
    
    var highResPath: String { get }
    
    var likes: String { get }
        
    var userDetail: String { get }
}

class ViewerViewController: UIViewController {

    var image: ImageViewerContent? {
        didSet {
            self.loadContent()
        }
    }
    var highRes = false
    var midRes = false
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var downloadsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadContent()
        
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(tapZoom(_:)))
        doubleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
        if let location = sender?.location(in: self.imageView) {
            
            let scale: CGFloat = 4.0
            let size = self.imageView.bounds.size
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
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
        if !self.highRes,
            scale > 2.5 {
            self.loadHighResContent()
            return
        }

        if !self.midRes,
            !self.highRes,
            scale > 1.5 {
            self.loadMidResContent()
            return
        }
    }
}
