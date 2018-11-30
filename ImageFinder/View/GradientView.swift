//
//  GradientView.swift
//  ImageFinder
//
//  Created by Andrea Altea on 30/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let locations: [CGFloat] = [0.0, 0.7, 1.0]
        let colors = [UIColor.deepNight,
                      UIColor.deepNight.withAlphaComponent(0.7),
                      UIColor.deepNight.withAlphaComponent(0.0)]
        
        let colorSpaceReference = CGColorSpaceCreateDeviceRGB()
        guard let context = UIGraphicsGetCurrentContext(),
            let gradient = CGGradient(colorsSpace: colorSpaceReference,
                                      colors: colors as CFArray,
                                      locations: locations) else {
            return
        }
        context.drawLinearGradient(gradient,
                                   start: CGPoint(x: rect.midX, y: rect.minY),
                                   end: CGPoint(x: rect.midX, y: rect.maxY),
                                   options: CGGradientDrawingOptions(rawValue: 0))
    }
}
