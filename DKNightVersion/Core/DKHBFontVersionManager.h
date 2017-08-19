//
//  DKHBFontVersionManager.h
//  DKNightVersion
//
//  Created by CuiHongbao on 17/3/9.
//  Copyright © 2017年 Draveness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKFont.h"

typedef NSString DKFontVersion;

extern DKFontVersion * const DKFontVersionDEFAULT;
extern DKFontVersion * const DKFontVersionOTHER;

extern CGFloat const DKFontVersionAnimationDuration;

extern NSString * const DKFontVersionThemeChangingNotification;

extern NSString * const DKFontVersionCurrentFontVersionKey;

@interface DKHBFontVersionManager : NSObject

@property (nonatomic, strong) DKFontVersion *fontVersion;
+ (DKHBFontVersionManager *)sharedManager;

- (void)defaultFonting;

- (void)otherFonting:(NSString *)fontother;
@end
