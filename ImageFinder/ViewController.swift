//
//  ViewController.swift
//  ImageFinder
//
//  Created by Andrea Altea on 29/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIManager.standard.getImages(for: "balloon") { response in
            
            switch response {
                
            case .failure(let error):
                print(error.localizedDescription)
                
            case .success(let searchResult):
                print(searchResult)
            }
            
        }
    }
}

