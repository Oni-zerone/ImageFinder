//
//  MessageViewModel.swift
//  ImageFinder
//
//  Created by Andrea Altea on 03/12/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

struct MessageViewModel: ItemViewModel {
    
    var message: String
    
    var cellIdentifier: String {
        return MessageCollectionViewCell.nibIdentifier
    }
    
    var multiplier: CGFloat {
        return 0
    }
    
    var constant: CGFloat {
        
        return 90
    }
    
    func setup(cell: UICollectionViewCell, in collection: UICollectionView, at indexPath: IndexPath) {
        
        guard let cell = cell as? MessageCollectionViewCell else {
            return
        }
        
        cell.messageLabel.text = self.message
    }
}
