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
        
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(tapZoom(_:)))
        doubleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap)
        
        guard let resource = ImageLoader(path: image?.urls.small) else { return }
        self.imageView.kf.setImage(with: resource)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
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
