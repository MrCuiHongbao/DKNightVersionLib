//
//  UITabBarItem+Night.h
//  DKNightVersion
//
//  Created by CuiHongbao on 17/3/14.
//  Copyright © 2017年 Draveness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+Night.h"

@interface UITabBarItem (Night)
- (void)dk_setTitleTextAttributes:(DKDictionaryPicker)attributes forState:(UIControlState)state;
@end
