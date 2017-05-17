//
//  BaseViewController.m
//  LiveRoomGiftAnimations
//
//  Created by KUN on 17/3/8.
//  Copyright © 2017年 animation. All rights reserved.
//

#import "BaseViewController.h"
#import <objc/runtime.h>

@interface BaseViewController () <UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setup];
}

- (void)setup {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.width = [[UIScreen mainScreen] bounds].size.width;
    self.height = [[UIScreen mainScreen] bounds].size.height;
    self.view.backgroundColor = [UIColor whiteColor];
    
    // enable full screen  PopGestureRecognizer
    self.enalbleFullScreenInteractivePopGestureRecognizer = YES;

}

- (void)dealloc {
}

@end



@implementation UIViewController (InteractivePopGestureRecognizer)

- (void)setEnalbleFullScreenInteractivePopGestureRecognizer:(BOOL)enalbleFullScreenInteractivePopGestureRecognizer {
    
    objc_setAssociatedObject(self, @selector(enalbleFullScreenInteractivePopGestureRecognizer), @(enalbleFullScreenInteractivePopGestureRecognizer), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)enalbleFullScreenInteractivePopGestureRecognizer {
    
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setShouldShowPopBackBtn:(BOOL)shouldShowPopBackBtn {

    objc_setAssociatedObject(self, @selector(shouldShowPopBackBtn), @(shouldShowPopBackBtn), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)shouldShowPopBackBtn {

    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end
