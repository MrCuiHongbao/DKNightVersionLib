//
//  DKHBFontVersionManager.m
//  DKNightVersion
//
//  Created by CuiHongbao on 17/3/9.
//  Copyright © 2017年 Draveness. All rights reserved.
//

#import "DKHBFontVersionManager.h"
NSString * const DKFontVersionDEFAULT = @"DEFAULT";
NSString * const DKFontVersionOTHER = @"OTHER";

CGFloat const DKFontVersionAnimationDuration = 0.3;

NSString * const DKFontVersionThemeChangingNotification = @"DKFontVersionThemeChangingNotification";

NSString * const DKFontVersionCurrentFontVersionKey = @"com.dkfontversion.manager.fontversion";
@implementation DKHBFontVersionManager
+ (DKHBFontVersionManager *)sharedManager {
    static dispatch_once_t once;
    static DKHBFontVersionManager *instance;
    dispatch_once(&once, ^{
        instance = [self new];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        DKFontVersion *fontVersion = [userDefaults valueForKey:DKFontVersionCurrentFontVersionKey];
        fontVersion = fontVersion ?: DKFontVersionDEFAULT;
        instance.fontVersion = fontVersion;
    });
    return instance;
}
- (void)defaultFonting {
    self.fontVersion = DKFontVersionDEFAULT;
}

- (void)otherFonting:(NSString *)fontother{
    self.fontVersion = fontother;
}
- (void)setFontVersion:(DKFontVersion *)fontVersion {
    if ([_fontVersion isEqualToString:fontVersion]) {
        // if type does not change, don't execute code below to enhance performance.
        return;
    }
    _fontVersion = fontVersion;
    
    // Save current theme version to user default
    [[NSUserDefaults standardUserDefaults] setValue:fontVersion forKey:DKFontVersionCurrentFontVersionKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:DKFontVersionThemeChangingNotification
                                                        object:nil];
}
@end
