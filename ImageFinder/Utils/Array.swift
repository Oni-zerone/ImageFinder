//
//  Array.swift
//  ImageFinder
//
//  Created by Andrea Altea on 30/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import Foundation

extension Array {
    
    func item(at index: Int) -> Element? {
        
        guard self.indices.contains(index) else { return nil }
        return self[index]
    }
}

extension Array where Element == SectionViewModel {
    
    func item(at indexPath: IndexPath) -> ItemViewModel? {
        
        return self.item(at: indexPath.section)?.items.item(at: indexPath.item)
    }
}
