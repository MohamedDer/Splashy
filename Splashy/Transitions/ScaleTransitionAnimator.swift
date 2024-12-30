//
//  ScaleTransitionAnimator.swift
//  Splashy
//
//  Created by Mohamed Derkaoui on 16/09/2024.
//

import UIKit

class ScaleTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var originFrame: CGRect = .zero
    var destinationFrame: CGRect = .zero
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.45
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toView)
        toView.frame = originFrame
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.3,
                       options: [],
                       animations: {
            toView.frame = self.destinationFrame
            fromView.alpha = 0.0
        }) { _ in
            fromView.alpha = 1
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
}

