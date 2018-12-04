//
//  FullImageLoaderStep.swift
//  ImageFinder
//
//  Created by Andrea Altea on 01/12/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import Foundation

class FullImageLoaderStep: DataStep {
    
    var provider: APIManager = .standard
    
    override func success(with model: CollectionModel) {
        var model = model
        guard var section = model.first as? UnsplashSectionViewModel else {
            super.success(with: model)
            return
        }
        
        let queue = DispatchGroup()
        (0 ..< section.items.count).forEach { index in
            
            guard let item = section.unsplashItems.item(at: index),
                item.fullImage == nil else {
                    return
            }
            
            queue.enter()
            let viewModel = section.unsplashItems[index]
            self.provider.getImage(viewModel.image.id, completion: { (result) in
                
                switch result {
                    
                case .success(let fullImage):
                    section.setFullImage(fullImage, itemAt: index)
                    queue.leave()
                    
                case .failure:
                    queue.leave()
                }
            })
            queue.notify(queue: DispatchQueue(label: "ImageNotify"), execute: {
                model[0] = section
                self.sendContent(.value(model))
            })
        }
        
    }
}
