//
//  User.swift
//  ImageFinder
//
//  Created by Andrea Altea on 29/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import Foundation

struct User: Codable, Hashable {
    
    var id: String
    
    var username: String
    
    var name: String
    
    var profileImage: Avatar
    
    var links: Links
    
    struct Avatar: Codable, Hashable {
        
        var small: String
        
        var medium: String
        
        var large: String
    }
    
    struct Links: Codable, Hashable {
        
        var html: String
    }
}

extension User {
    
    enum AvatarSize {
        
        case small
        case medium
        case large
    }
    
    func avatar(size: AvatarSize) -> String? {
        
        switch size {
            
        case .small:
            return self.profileImage.small
            
        case .medium:
            return self.profileImage.medium
            
        case .large:
            return self.profileImage.large
        }
    }
}
