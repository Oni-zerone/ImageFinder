//
//  FullImage.swift
//  ImageFinder
//
//  Created by Andrea Altea on 30/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import Foundation

struct FullImage: Parsable, Hashable {
    
    let id: String
    
    let downloads: Int
    
    let urls: URLS
    
    struct URLS: Codable, Hashable {
        
        var full: String
        
        var regular: String
        
        var small: String
        
        var thumb: String
    }
}
