//
//  MessageSectionViewModel.swift
//  ImageFinder
//
//  Created by Andrea Altea on 03/12/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

struct MessageSectionViewModel: SectionViewModel {
    
    var extendedTopMargin: Bool
    
    var columns: Int {
        return 1
    }
    
    var items: [ItemViewModel]
    
    var insets: UIEdgeInsets {
        return UIEdgeInsets(top: self.extendedTopMargin ? 140 : 24, left: 8.0, bottom: 0, right: 8.0)
    }
    
    var interItemSpacing: CGFloat {
        return 0
    }
    
    var interLineSpacing: CGFloat {
        return 24
    }
}
