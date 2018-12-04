//
//  ZoomInTransition.swift
//  ImageFinder
//
//  Created by Andrea Altea on 04/12/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

class ZoomInAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    var originFrame: CGRect
    var image: UIImage
    weak var destinationView: UIView?
    
    init(originFrame: CGRect, image: UIImage) {
        
        self.originFrame = originFrame
        self.image = image
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from),
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
                return
        }
        
        container.addSubview(fromView)
        container.addSubview(toView)
        toView.alpha = 0.0
        toView.layoutIfNeeded()
        self.destinationView?.alpha = 0.0
        
        
        let imageView = UIImageView(image: self.image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = originFrame
        imageView.alpha = 0.0
        container.addSubview(imageView)
        
        UIView.animate(withDuration: 0.2, animations: {
            fromView.alpha = 0.0
            imageView.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.18, options: .curveEaseOut, animations: {
           
            if let destinationView = self.destinationView {
                let frame = destinationView.convert(destinationView.bounds, to: container)
                imageView.frame = frame
            }
            toView.alpha = 1.0

        }) { (finished) in

            self.destinationView?.alpha = 1.0
            fromView.alpha = 1.0
            imageView.removeFromSuperview()
            transitionContext.completeTransition(finished)
        }
    }
}
