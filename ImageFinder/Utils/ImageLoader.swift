//
//  ImageLoader.swift
//  ImageFinder
//
//  Created by Andrea Altea on 03/12/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import Foundation
import Kingfisher

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
