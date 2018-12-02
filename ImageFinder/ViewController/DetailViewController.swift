//
//  DetailViewController.swift
//  ImageFinder
//
//  Created by Andrea Altea on 01/12/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    var image: FullImage?
    var highRes = false
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(tapZoom(_:)))
        doubleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap)
        
        guard let resource = ImageLoader(path: image?.urls.small) else { return }
        self.imageView.kf.setImage(with: resource)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func tapZoom(_ sender: UITapGestureRecognizer?) {
        if self.scrollView.zoomScale > 2 {
            self.zoomOut(sender)
            return
        }
        self.zoomIn(sender)
    }
    
    private func zoomIn(_ sender: UITapGestureRecognizer?) {
        self.scrollView.setZoomScale(4, animated: true)
    }
    
    private func zoomOut(_ sender: UITapGestureRecognizer?) {
        self.scrollView.setZoomScale(1, animated: true)
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
        guard !self.highRes,
            scale > 2.0 else {
                return
        }
        
        self.highRes = true
        guard let resource = ImageLoader(path: image?.urls.full) else { return }
        self.imageView.kf.setImage(with: resource, placeholder: self.imageView.image)
    }
}
