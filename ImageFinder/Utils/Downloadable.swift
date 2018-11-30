//
//  Image+Download.swift
//  ImageFinder
//
//  Created by Andrea Altea on 30/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

protocol Downloadable {

    static var session: URLSession { get }
    
    var url: URL? { get }
}

extension Downloadable {
    
    func loadImage(completion: @escaping (_ image: UIImage) -> Void) {
        
        guard let url = self.url else { return }
        
        Self.session.dataTask(with: url) { (data, response, error) in
            
            guard error == nil,
                let data = data,
                let image = UIImage(data: data) else {
                    return
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
