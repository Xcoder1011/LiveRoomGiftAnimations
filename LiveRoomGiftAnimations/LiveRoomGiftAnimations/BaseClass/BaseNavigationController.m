//
//  BaseNavigationController.m
//  LiveRoomGiftAnimations
//
//  Created by KUN on 17/3/9.
//  Copyright © 2017年 animation. All rights reserved.
//

#import "BaseNavigationController.h"

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
}


- (UIViewController *)childViewControllerForStatusBarStyle{
    
    return self.topViewController;
}


@end
