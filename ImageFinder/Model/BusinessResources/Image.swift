//
//  Image.swift
//  ImageFinder
//
//  Created by Andrea Altea on 29/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import Foundation

struct Image: Codable {
    
    var id: String
    
    var createdAt: String
    
    var width: Int
    
    var height: Int
    
    var color: String
    
    var description: String
    
    var likes: Int
    
    var user: User
    
    var links: Link
    
    struct Link: Codable {
        
        var download: String
        
        var html: String
    }
}

extension Image {

    var ratio: Float {
        return Float(self.height) / Float(self.width)
    }
}
