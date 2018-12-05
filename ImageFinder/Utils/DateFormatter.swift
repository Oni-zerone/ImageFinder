//
//  DateFormatter.swift
//  ImageFinder
//
//  Created by Andrea Altea on 02/12/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import Foundation


extension DateFormatter {
    
    static let simpleFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM YYYY"
        return formatter
    }()
    
    static let RFC3339: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}

extension Date {
    
    var simpleFormat: String {
        return DateFormatter.simpleFormat.string(from: self)
    }
}
