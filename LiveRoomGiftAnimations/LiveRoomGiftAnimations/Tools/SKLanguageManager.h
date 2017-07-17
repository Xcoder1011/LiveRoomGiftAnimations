//
//  SKLanguageManager.h
//  LiveRoomGiftAnimations
//
//  Created by KUN on 17/7/14.
//  Copyright © 2017年 animation. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SKLocalizedString(key,comment) [[SKLanguageManager sharedManager] localizedStringForKey:(key) value:comment]

#define kAPPLanguageDidChangedNotificationName @"kAPPLanguageDidChangedNotificationName"

@interface SKLanguageManager : NSObject

@property (nonatomic , copy) void (^completion)();

+ (instancetype)sharedManager;

- (NSString *)currentLanguage;

- (NSBundle *)currentBundle;

- (UIImage *)imageWithName:(NSString *)imageName;

- (void)setLanguage:(NSString *)language;

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)comment;

#define kLanguageManager  [SKLanguageManager sharedManager]

@end

//static inline NSString *SKLocalizedString(NSString *key, NSString *comment) {
//    
//    return  [[SKLanguageManager sharedManager] localizedStringForKey:(key) value:comment];
//}
