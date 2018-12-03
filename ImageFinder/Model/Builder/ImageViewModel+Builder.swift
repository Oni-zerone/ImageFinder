//
//  ImageViewModel+Builder.swift
//  ImageFinder
//
//  Created by Andrea Altea on 02/12/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

extension ImageViewModel: Builder {
    
    func make(from view: UIView?) -> UIViewController? {
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let detailController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? ViewerViewController else {
            return nil
        }
        
        if let view = view as? UnsplashCell,
            let image = view.imageView.image {
            
            let frame = view.imageView.convert(view.imageView.bounds, to: nil)
            detailController.transition = ZoomInAnimatedTransitioning(originFrame: frame, image: image)
        }
        
        detailController.image = ImageViewerContent(image: self.image, fullImage: self.fullImage)
        return detailController
    }
}

struct ImageViewerContent: ViewerContent {
    
    var image: Image
    
    var fullImage: FullImage?
    
    var imageRatio: CGFloat {
        return CGFloat(self.image.height) / CGFloat(self.image.width)
    }
    
    var lowResPath: String {
        return self.fullImage?.urls.small ?? image.links.download
    }
    
    var midResPath: String {
        return self.fullImage?.urls.regular ?? image.links.download
    }
    
    var highResPath: String {
        return self.fullImage?.urls.full ?? self.image.links.download
    }

    var likes: String {
        return String(self.image.likes)
    }
    
    var downloads: String {
        
        guard let image = self.fullImage else { return "--" }
        return String(image.downloads)
    }
    
    var detailBuilder: Builder {
        
        return UserDetailBuilder(user: self.image.user)
    }
}
