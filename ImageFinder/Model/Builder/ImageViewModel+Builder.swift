//
//  ImageViewModel+Builder.swift
//  ImageFinder
//
//  Created by Andrea Altea on 02/12/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

extension ImageViewModel: Builder {
    
    func make(from: UIView?) -> UIViewController? {
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let detailController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? ViewerViewController else {
            return nil
        }
        detailController.image = ImageViewerContent(image: self.image, fullImage: self.fullImage)
        return detailController
    }
}

struct ImageViewerContent: ViewerContent {
    
    var image: Image
    
    var fullImage: FullImage?
    
    var lowResPath: String {
     
        return self.fullImage?.urls.thumb ?? image.links.download
    }
    
    var highResPath: String {
        
        return self.image.links.download
    }

    var likes: String {
        return String(self.image.likes)
    }
    
    var downloads: String {
        
        guard let image = self.fullImage else { return "--" }
        return String(image.downloads)
    }
    
    var userDetail: String { return "" }

}
