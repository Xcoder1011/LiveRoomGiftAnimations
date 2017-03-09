//
//  BaseContentViewController.m
//  LiveRoomGiftAnimations
//
//  Created by KUN on 17/3/8.
//  Copyright © 2017年 animation. All rights reserved.
//

#import "BaseContentViewController.h"

@interface BaseContentViewController ()

@end

@implementation BaseContentViewController


- (void)setup {

    [super setup];
    
    [self setupBackgroundView];
    [self setupContentView];
    [self setupTitleView];
}

- (void)setupTitleView {
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 64)];
    self.titleView = titleView;
    [self.view addSubview:titleView];
}

- (void)setupContentView {
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.width, self.height - 64)];
    self.contentView = contentView;
    [self.view addSubview:contentView];
}

- (void)setupBackgroundView {

    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    self.backgroundView = backgroundView;
    [self.view addSubview:backgroundView];
}


@end
