//
//  Error.swift
//  ImageFinder
//
//  Created by Andrea Altea on 05/12/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import Foundation

protocol ConvertibleError: Error {
    
    var message: String { get }
}

extension ConvertibleError where Self: RawRepresentable, Self.RawValue == String{
    
    var message: String {
        return self.rawValue
    }
}
