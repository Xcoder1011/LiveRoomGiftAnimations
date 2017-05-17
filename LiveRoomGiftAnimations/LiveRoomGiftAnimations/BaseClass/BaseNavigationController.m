//
//  BaseNavigationController.m
//  LiveRoomGiftAnimations
//
//  Created by KUN on 17/3/9.
//  Copyright © 2017年 animation. All rights reserved.
//

#import "BaseNavigationController.h"
#import "BaseViewController.h"

@interface BaseNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController navigationBarHidden:(BOOL)hidden {

    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:rootViewController];
    [nav setNavigationBarHidden:hidden];
    nav.navigationController.interactivePopGestureRecognizer.delegate = self;
    return nav;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Gets the target object that comes with the sliding gesture
    id target = self.interactivePopGestureRecognizer.delegate;
    
    // To create a full-screen slide gestures, sliding gesture to the target system at call the action method
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    
    // Set up the gestures agent, intercept gestures trigger
    pan.delegate = self;
    
    [self.view addGestureRecognizer:pan];
    
    // To ban the use of system with sliding gesture
    self.interactivePopGestureRecognizer.enabled = NO;
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count >= 1) {
        viewController.shouldShowPopBackBtn = YES;
        viewController.hidesBottomBarWhenPushed = YES; // 隐藏底部的工具条
    }
    [super pushViewController:viewController animated:animated];
}


/**
 *  Intercept gestures trigger
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.childViewControllers.count <= 1) {
        return NO;
    }
    
    UIViewController *topViewController = self.topViewController;
    if (!topViewController.enalbleFullScreenInteractivePopGestureRecognizer) {
        return NO;
    }
    
    // Ignore pan gesture when the navigation controller is currently in transition.
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    
    return YES;
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    
    return self.topViewController;
}

@end


