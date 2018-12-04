//
//  ImageLoadStep.swift
//  ImageFinder
//
//  Created by Andrea Altea on 30/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import Foundation

enum ImageLoadErrors: String, Error {
    
    case noContent = "No search results"

    var localizedDescription: String {
        return self.rawValue
    }
}

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
                let messageSection = self.prepareMessageSection(message: error.localizedDescription)
                self.sendContent(.value([self.content, messageSection]))
                return
                
            case .success(let searchResults):
                
                guard searchResults.total > 0 else {
                    self.sendContent(.error(ImageLoadErrors.noContent))
                    return
                }
                
                self.totalPages = searchResults.totalPages
                let viewModels = searchResults.results.viewModels
                self.content.unsplashItems.append(contentsOf: viewModels)

                var content: CollectionModel = [self.content]
                
                if page == self.totalPages {
                    let section = self.prepareMessageSection(message: "End of content.")
                    content.append(section)
                }
                self.sendContent(.value(content))
            }
            
            self.currentPage += 1
            self.isLoading = false
        }
    }
    
    func prepareMessageSection(message: String) -> SectionViewModel {

        let messageViewModel = MessageViewModel(message: message)
        return MessageSectionViewModel(extendedTopMargin: false, items: [messageViewModel])
    }
}

extension Array where Element == Image {
    
    var viewModels: [ImageViewModel] {
        
        return self.map({ (image) -> ImageViewModel in
            return ImageViewModel(image: image, fullImage: nil)
        })
    }
}

