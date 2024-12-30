//
//  SlideDismissalAnimator.swift
//  Splashy
//
//  Created by Mohamed Derkaoui on 16/09/2024.
//

import UIKit

class SlideDismissalAnimator: NSObject, UIViewControllerAnimatedTransitioning {
        
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        
        let finalFrame = CGRect(x: fromVC.view.frame.width, 
                                y: 0, 
                                width: fromVC.view.frame.width,
                                height: fromVC.view.frame.height)
        
        UIView.animate(animations: {
            fromVC.view.frame = finalFrame
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
