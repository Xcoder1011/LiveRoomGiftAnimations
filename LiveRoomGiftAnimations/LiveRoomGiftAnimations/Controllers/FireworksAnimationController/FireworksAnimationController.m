//
//  FireworksAnimationController.m
//  LiveRoomGiftAnimations
//
//  Created by KUN on 17/3/10.
//  Copyright © 2017年 animation. All rights reserved.
//

#import "FireworksAnimationController.h"

@interface FireworksAnimationController ()

@end

@implementation FireworksAnimationController

- (void)setup {
    [super setup];
    self.contentView.backgroundColor = [UIColor blackColor];
    self.titleView.hidden = YES;
    // 1.开启背景烟花
    [self fireworksAnimation];
}


- (void)fireworksAnimation {
    
    CAEmitterLayer *fireworksEmitter = [CAEmitterLayer layer];
    CGRect viewBounds = self.contentView.layer.bounds;
    fireworksEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0, viewBounds.size.height);
    fireworksEmitter.emitterSize	= CGSizeMake(1.0, 0.0);
    fireworksEmitter.emitterMode	= kCAEmitterLayerOutline;
    fireworksEmitter.emitterShape	= kCAEmitterLayerLine;
    fireworksEmitter.renderMode		= kCAEmitterLayerAdditive;
    fireworksEmitter.seed = (arc4random()%100)+1;
    
    CAEmitterCell* rocket = [CAEmitterCell emitterCell];
    rocket.birthRate		= 2;
    rocket.emissionRange	= 0.25 * M_PI;
    rocket.velocity			= 530;
    rocket.velocityRange	= 100;
    rocket.yAcceleration	= 80;
    rocket.lifetime			= 1.02;
    rocket.contents			= (__bridge id)[[UIImage imageNamed:@"spark"] CGImage];
    rocket.scale			= 0.2;
    rocket.color			= [[UIColor colorWithRed:48/255.0 green:255/255.0 blue:59/255.0 alpha:1.0] CGColor];
    rocket.greenRange		= 2.0;
    rocket.redRange			= 2.0;
    rocket.blueRange		= 2.0;

    CAEmitterCell* burst = [CAEmitterCell emitterCell];
    burst.birthRate			= 1.0;
    burst.velocity			= 0;
    burst.scale				= 1.8;
    burst.scaleSpeed		= 1.0;
    burst.lifetime			= 0.25;
    
    CAEmitterCell* spark = [CAEmitterCell emitterCell];
    spark.birthRate			= 800;
    spark.velocity			= 80;
    spark.emissionRange		= 2 * M_PI;
    spark.yAcceleration	= 20;
    spark.lifetime			= 2.8;
    spark.contents			= (id) [[UIImage imageNamed:@"spark"] CGImage];
    spark.scaleSpeed		=-0.2;
    spark.greenSpeed		=+0.3;
    spark.redSpeed			=+0.3;
    spark.blueSpeed			=+0.1;
    spark.alphaSpeed		=-0.35;   // 不能设置的太小，会有阴影
    spark.spin				= 2 * M_PI;
    spark.spinRange			= 2 * M_PI;

    fireworksEmitter.emitterCells	= [NSArray arrayWithObject:rocket];
    rocket.emitterCells				= [NSArray arrayWithObject:burst];
    burst.emitterCells				= [NSArray arrayWithObject:spark];
    
    [self.contentView.layer addSublayer:fireworksEmitter];
}


- (void)dealloc {
}

@end
