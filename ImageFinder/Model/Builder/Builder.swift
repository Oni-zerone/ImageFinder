//
//  Builder.swift
//  ImageFinder
//
//  Created by Andrea Altea on 02/12/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

protocol Builder {
    
    func make(from: UIView?) -> UIViewController?
}
