//
//  ParticleSprayController.m
//  LiveRoomGiftAnimations
//
//  Created by KUN on 17/5/10.
//  Copyright © 2017年 animation. All rights reserved.
//

#import "ParticleSprayController.h"
#import "SKEmitterLayer.h"

@interface ParticleSprayController () <SKEmitterLayerDelegate>

@end

@implementation ParticleSprayController

- (void)setup {

    [super setup];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.titleView.hidden = YES;
    [self emitterAnimationWithImage: [UIImage imageNamed:@"Faces.png"]
                      startPosition:CGPointMake(self.contentView.centerX , 0)
                           lifetime:5.0
                  emittersCountRate:0.8
                           cellSize:CGSizeMake(1.6, 1.6)];
    
}


- (void)emitterAnimationWithImage:(UIImage *)image
                    startPosition:(CGPoint)startPosition
                         lifetime:(float)lifetime
                emittersCountRate:(float)emittersCountRate
                         cellSize:(CGSize)cellSize {
    
    SKEmitterLayer *customEmitter = [SKEmitterLayer layer];
    customEmitter.frame = self.contentView.layer.bounds;
    [self.contentView.layer addSublayer:customEmitter];
    
    customEmitter.emitterDelegate = self;
    customEmitter.emitterImage = image;
    customEmitter.startPosition = startPosition;
    customEmitter.emitterImagePosition = CGPointMake(self.contentView.centerX, self.contentView.centerY);
    customEmitter.lifetime = lifetime;
    customEmitter.emittersCountRate = emittersCountRate;
    customEmitter.cellSize = cellSize;
    [customEmitter animate];
}

#pragma mark -- SKEmitterLayerDelegate

- (void)emitterLayerDidRemoveFromSuperView:(SKEmitterLayer *)emitter {
    
    kWeakObj(self)
    NSInteger random = arc4random_uniform(2) ? 1:0;
    CGPoint startPosition = CGPointMake(weakself.contentView.centerX , random * weakself.contentView.height);
    static NSInteger index = 1;
    if (index > 4)  index = 1;
    NSString *imageName = [NSString stringWithFormat:@"Snip20170418_%ld.png",index];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakself emitterAnimationWithImage: [UIImage imageNamed:imageName]
                              startPosition:startPosition
                                   lifetime:5.0
                          emittersCountRate:0.8
                                   cellSize:CGSizeMake(1.6, 1.6)];
        index++;
    });
}

- (void)dealloc {
}

@end
