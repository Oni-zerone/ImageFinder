//
//  ImageLoadStep.swift
//  ImageFinder
//
//  Created by Andrea Altea on 30/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import Foundation

class ImageLoadStep: DataStep {
    
    var provider: APIManager = .standard
    
    var queryString: String? {
        didSet {
            guard self.queryString != oldValue else { return }
            self.loadImages()
        }
    }
    
    func loadImages(at page: Int = 1) {
        
        guard let query = self.queryString else {
            self.sendContent(.reset)
            return
        }
        
        self.provider.getImages(for: query, page: page) { (result) in
            
            switch result {
                
            case .failure(let error):
                self.failed(with: error)
                
            case .success(let searchResults):
                
                let viewModels = searchResults.results.viewModels
                let section = UnsplashSectionViewModel(unsplashItems: viewModels)
                self.sendContent(.value([section]))
            }
        }
    }
}

extension Array where Element == Image {
    
    var viewModels: [ImageViewModel] {
        
        return self.map({ (image) -> ImageViewModel in
            return ImageViewModel(image: image, fullImage: nil)
        })
    }
}

