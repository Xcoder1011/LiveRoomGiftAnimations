//
//  SKLanguageManager.m
//  LiveRoomGiftAnimations
//
//  Created by KUN on 17/7/14.
//  Copyright © 2017年 animation. All rights reserved.
//

#import "SKLanguageManager.h"

#define kMyLanguage @"kMyLanguage"
#define kLocalizedStringTableName @"MyLocallizable"  // or default "Locallizable"

@interface SKLanguageManager ()

@property (nonatomic,strong) NSBundle *bundle;

@end

@implementation SKLanguageManager

+ (instancetype)sharedManager {
    
    static SKLanguageManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SKLanguageManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init {

    if (self = [super init]) {
      
        [self _initManager];
    }
    return self;
}

- (void)setLanguage:(NSString *)language {
    
    if ([[self currentLanguage] isEqualToString:language]) {
        return;
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:[self languageFormat:language] ofType:@"lproj"];
    _bundle = [NSBundle bundleWithPath:path];
    
    [[NSUserDefaults standardUserDefaults] setValue:language forKey:kMyLanguage];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kAPPLanguageDidChangedNotificationName object:language];

}


- (NSString *)languageFormat:(NSString*)language {
    if([language rangeOfString:@"zh-Hans"].location != NSNotFound)
    {
        return @"zh-Hans";
    }
    else if([language rangeOfString:@"zh-Hant"].location != NSNotFound)
    {
        return @"zh-Hant";
    }
    else
    {
        if([language rangeOfString:@"-"].location != NSNotFound) {
            NSArray *ary = [language componentsSeparatedByString:@"-"];
            if (ary.count > 1) {
                NSString *str = ary[0];
                return str;
            }
        }
    }
    return language;
}

- (void)_initManager {

    NSString *userLanguage = [[NSUserDefaults standardUserDefaults] valueForKey:kMyLanguage];
    if (userLanguage.length == 0) {
        //获取系统偏好语言数组
        NSArray *languages = [NSLocale preferredLanguages];
        userLanguage = [languages firstObject];
        
        [[NSUserDefaults standardUserDefaults] setValue:userLanguage forKey:kMyLanguage];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:[self languageFormat:userLanguage] ofType:@"lproj"];
    _bundle = [NSBundle bundleWithPath:path];
}

- (NSString *)currentLanguage {
    
    NSString *userLanguage = [[NSUserDefaults standardUserDefaults] valueForKey:kMyLanguage];
    NSLog(@"currentLanguage == %@",userLanguage);
    return userLanguage;
}

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)comment {
    
    if (!_bundle) {
        [self _initManager];
    }
    if (key.length > 0) {
        NSString *string = NSLocalizedStringFromTableInBundle(key, kLocalizedStringTableName, _bundle, comment);
        if (string.length > 0) {
            return string;
        }
    }
    return @"";
}


- (UIImage *)imageWithName:(NSString *)imageName {
    NSString *suffix = [self languageFormat:[self currentLanguage]];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%@",imageName,suffix]];
    return image;
    
}

- (NSBundle *)currentBundle {
    return _bundle;
}

@end
