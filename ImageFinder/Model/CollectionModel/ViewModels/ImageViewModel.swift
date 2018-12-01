//
//  ImageViewModel.swift
//  ImageFinder
//
//  Created by Andrea Altea on 30/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit
import UIColor_Hex
import Kingfisher

struct ImageViewModel: ItemViewModel, Hashable {
    
    var cellIdentifier: String {
        return UnsplashCell.nibIdentifier
    }
    
    var image: Image
    var fullImage: FullImage?
    
    var multiplier: CGFloat {
        
        return CGFloat(self.image.ratio)
    }
    
    var constant: CGFloat {
        
        return 92
    }
    
    func setup(cell: UICollectionViewCell, in collection: UICollectionView, at indexPath: IndexPath) {
        
        guard let cell = cell as? UnsplashCell else {
            return
        }
        
        cell.descriptionLabel.text = self.image.description
        cell.creationDateLabel.text = self.image.createdAt
        cell.imageView.backgroundColor = UIColor(css: self.image.color)
        
        
        guard let resource = ImageLoader(path: self.fullImage?.urls.thumb) else { return }
        cell.imageView.kf.setImage(with: resource) { (image, error, cacheType, url) in
            
            guard let cell = collection.cellForItem(at: indexPath) as? UnsplashCell else { return }
            cell.imageView.image = image
        }
    }
}

struct ImageLoader: Resource {
    
    init?(path: String?) {
        
        guard let path = path,
            let url = URL(string: path) else {
                return nil
        }
        self.cacheKey = path
        self.downloadURL = url
    }
    
    var cacheKey: String
    
    var downloadURL: URL
}
