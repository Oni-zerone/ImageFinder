//
//  ImageViewModel+Builder.swift
//  ImageFinder
//
//  Created by Andrea Altea on 02/12/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

extension ImageViewModel: Builder {
    
    func make(from: UIView?) -> UIViewController? {
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let detailController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return nil
        }
        detailController.image = self.fullImage
        return detailController
    }
}
