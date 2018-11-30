//
//  UnsplashSectionViewModel.swift
//  ImageFinder
//
//  Created by Andrea Altea on 30/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

struct UnsplashSectionViewModel: SectionViewModel {
    
    var items: [ItemViewModel]
    
    var sectionInsets: UIEdgeInsets {
        
        return UIEdgeInsets(top: 70, left: 8.0, bottom: 70, right: 8.0)
    }
    
    var interItemSpacing: CGFloat {
        
        return 8.0
    }
    
    var interLineSpacing: CGFloat {
        
        return 8.0
    }
}
