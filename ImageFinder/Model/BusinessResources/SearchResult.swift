//
//  SearchResult.swift
//  ImageFinder
//
//  Created by Andrea Altea on 29/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    
    var total: Int
    
    var totalPages: Int
    
    var results: [Image]
}
