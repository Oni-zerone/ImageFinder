//
//  ImageViewModel.swift
//  ImageFinder
//
//  Created by Andrea Altea on 30/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

struct ImageViewModel: ItemViewModel, Hashable {
    
    var cellIdentifier: String {
        return UnsplashCell.nibIdentifier
    }
    
    var image: Image
    var fullImage: FullImage?
    
    var loadedImage: UIImage?
    
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
        
        if let loadedImage = self.loadedImage {
            cell.imageView.image = loadedImage
            return
        }
        
        self.loadImage { [weak collection] image in
            
            guard let collection = collection,
                let cell = collection.cellForItem(at: indexPath) as? UnsplashCell else {
                    return
            }
            cell.imageView.image = image
            self.loadedImage = image
        }
    }
}

extension ImageViewModel: Downloadable {
    
    static var session: URLSession = URLSession(configuration: .default)
    
    var url: URL? {
        guard let imagePath = self.fullImage?.urls.thumb else { return nil }
        return URL(string: imagePath)
    }
}
