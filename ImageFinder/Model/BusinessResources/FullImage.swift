//
//  FullImage.swift
//  ImageFinder
//
//  Created by Andrea Altea on 30/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import Foundation

struct FullImage: Parsable {
    
    let id: String
    
    let urls: URLS
    
    struct URLS: Codable {
        
        var full: String
        
        var small: String
        
        var thumb: String
    }
}
