//
//  Item.m
//  LiveRoomGiftAnimations
//
//  Created by KUN on 17/3/10.
//  Copyright © 2017年 animation. All rights reserved.
//

#import "Item.h"

@implementation Item

+ (Item *)itemWithName:(NSString *)name object:(id)object {

    Item *item = [[Item alloc] init];
    item.name = name;
    item.object = object;
    return item;
}

@end
