//
//  UnsplashSectionViewModel.swift
//  ImageFinder
//
//  Created by Andrea Altea on 30/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

struct UnsplashSectionViewModel: SectionViewModel {
    
    var columns: Int {
        
        return 2
    }

    var unsplashItems: [ImageViewModel]
    
    var items: [ItemViewModel] {
        set {
            self.unsplashItems  = newValue as? [ImageViewModel] ?? []
        }
        get {
            return self.unsplashItems
        }
    }
    
    var insets: UIEdgeInsets {
        
        return UIEdgeInsets(top: 60, left: 8.0, bottom: 0, right: 8.0)
    }
    
    var interItemSpacing: CGFloat {
        
        return 8.0
    }
    
    var interLineSpacing: CGFloat {
        
        return 8.0
    }
}

extension UnsplashSectionViewModel {
    
    static func prepare(_ searchResult: SearchResult) -> UnsplashSectionViewModel {
        
        return UnsplashSectionViewModel(unsplashItems: searchResult.results.viewModels)
    }
    
    mutating func setFullImage(_ fullImage: FullImage, itemAt index: Int) {
        
        if self.unsplashItems.indices.contains(index) {
            self.unsplashItems[index].fullImage = fullImage
        }
    }
}
