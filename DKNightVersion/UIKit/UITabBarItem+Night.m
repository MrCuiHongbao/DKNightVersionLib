//
//  UITabBarItem+Night.m
//  DKNightVersion
//
//  Created by CuiHongbao on 17/3/14.
//  Copyright © 2017年 Draveness. All rights reserved.
//

#import "UITabBarItem+Night.h"
@interface UITabBarItem()
@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *fontPickers;
@end
@implementation UITabBarItem (Night)
- (void)dk_setTitleTextAttributes:(DKDictionaryPicker)fontPickers forState:(UIControlState)state{
    [self setTitleTextAttributes:fontPickers(self.dk_fontManager.fontVersion) forState:state];
    NSString *key = [NSString stringWithFormat:@"%@", @(state)];
    NSMutableDictionary *dictionary = [self.fontPickers valueForKey:key];
    if (!dictionary) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    [dictionary setValue:[fontPickers copy] forKey:NSStringFromSelector(@selector(setTitleTextAttributes:forState:))];
    [self.fontPickers setValue:dictionary forKey:key];
}
- (void)night_updateFont{
    [self.fontPickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary<NSString *, DKDictionaryPicker> *dictionary = (NSDictionary *)obj;
            [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull selector, DKDictionaryPicker  _Nonnull picker, BOOL * _Nonnull stop) {
                UIControlState state = [key integerValue];
                [UIView animateWithDuration:DKNightVersionAnimationDuration
                                 animations:^{
                                     if ([selector isEqualToString:NSStringFromSelector(@selector(setTitleTextAttributes:forState:))]) {
                                         NSDictionary *resultDict = picker(self.dk_fontManager.fontVersion);
                                         [self setTitleTextAttributes:resultDict forState:state];
                                     }
                                 }];
            }];
        } else {
            SEL sel = NSSelectorFromString(key);
            DKDictionaryPicker picker = (DKDictionaryPicker)obj;
            NSDictionary *resultDict = picker(self.dk_fontManager.fontVersion);
            [UIView animateWithDuration:DKNightVersionAnimationDuration
                             animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                                 [self performSelector:sel withObject:resultDict];
#pragma clang diagnostic pop
                             }];
            
        }
    }];
}
@end
