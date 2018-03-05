//
//  JLScaleTransition.m
//  AnimatedTransitioning
//
//  Created by home on 2018/3/5.
//  Copyright © 2018年 home. All rights reserved.
//

#import "JLScaleTransition.h"

@implementation JLScaleTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return 2.0f;
    
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController * toVC =  (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    UIView * fromView =  fromVC.view;
    UIView * toView = toVC.view;
    
    [containerView addSubview:toView];
    [containerView bringSubviewToFront:fromView];

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        
        fromView.transform = CGAffineTransformMakeScale(0.2, 0.2);
       
    }completion:^(BOOL finished) {
        fromView.transform = CGAffineTransformMakeScale(1, 1);
        [transitionContext completeTransition:YES];
    }];
}



@end
