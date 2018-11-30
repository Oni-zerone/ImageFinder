//
//  Image+Downloadable.swift
//  ImageFinder
//
//  Created by Andrea Altea on 30/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

extension Image: Downloadable {
    
    static var session = URLSession(configuration: .default)
    
    var url: URL? {
        return URL(string: self.links.download)
    }
}
