//
//  User.swift
//  ImageFinder
//
//  Created by Andrea Altea on 29/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import Foundation

struct User: Codable {
    
    var id: String
    
    var username: String
    
    var name: String
    
    var profileImage: Avatar
    
    struct Avatar: Codable {
        
        var small: String
        
        var medium: String
        
        var large: String
    }
}

extension User {
    
    enum AvatarSize {
        
        case small
        case medium
        case large
    }
    
    func avatar(size: AvatarSize) -> URL? {
        
        switch size {
            
        case .small:
            return URL(string: self.profileImage.small)
            
        case .medium:
            return URL(string: self.profileImage.medium)
            
        case .large:
            return URL(string: self.profileImage.large)
        }
    }
}
