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
    
    private var isLoading = false
    
    private(set) var currentPage: Int = 1
    private(set) var totalPages: Int = 1
    private(set) var content = UnsplashSectionViewModel(unsplashItems: [])
    
    var queryString: String? {
        didSet {
            guard self.queryString != oldValue else { return }
            self.resetContent()
        }
    }
    
    func resetContent() {
        
        self.content.unsplashItems = []
        self.currentPage = 1
        self.totalPages = 1
        self.loadImages()
    }
    
    func loadImages() {
        
        guard self.isLoading == false,
            self.currentPage <= self.totalPages else {
                return
        }
        
        self.isLoading = true
        
        let page = self.currentPage
        guard let query = self.queryString else {
            self.sendContent(.reset)
            return
        }
        
        self.provider.getImages(for: query, page: page) { (result) in
            
            switch result {
                
            case .failure(let error):
                if page == 1 {
                    self.failed(with: error)
                    self.isLoading = false
                    return
                }
                
                
            case .success(let searchResults):
                
                self.totalPages = searchResults.totalPages
                let viewModels = searchResults.results.viewModels
                self.content.unsplashItems.append(contentsOf: viewModels)
                self.sendContent(.value([self.content]))
            }
            
            self.currentPage += 1
            self.isLoading = false
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

