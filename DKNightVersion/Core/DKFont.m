//
//  DKFont.m
//  DKNightVersion
//
//  Created by CuiHongbao on 17/3/13.
//  Copyright © 2017年 Draveness. All rights reserved.
//

#import "DKFont.h"
#import "DKHBFontVersionManager.h"
#import <CoreText/CoreText.h>
#import <objc/runtime.h>
static void *DKFontHelperKey;

@implementation DKFont
+ (DKFontPicker)fontPickerWithPathsize:(CGFloat)fontSize{
    return ^(DKFontVersion *fontVersion) {
        if ([fontVersion isEqualToString:DKFontVersionDEFAULT]) {
            UIFont *font = [UIFont systemFontOfSize:fontSize];
            objc_setAssociatedObject(self, &DKFontHelperKey, font, OBJC_ASSOCIATION_ASSIGN);
            return font;
        }
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//documents文件路径
        NSString *docDir = [paths objectAtIndex:0];
        NSString *absolutPath =[NSString stringWithFormat:@"%@/%@",docDir,fontVersion];
        NSURL *fontUrl = [NSURL fileURLWithPath:absolutPath];
        CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)fontUrl);
        CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
        CGDataProviderRelease(fontDataProvider);
        CFErrorRef error;
        if (!CTFontManagerUnregisterGraphicsFont(fontRef, &error)) {
            CFStringRef errorDescription = CFErrorCopyDescription(error);
            NSLog(@"Failed to unregister font: %@", errorDescription);
            CFRelease(errorDescription);
        }
        if (!CTFontManagerRegisterGraphicsFont(fontRef, &error)) {
            CFStringRef errorDescription = CFErrorCopyDescription(error);
            NSLog(@"Failed to load font: %@", errorDescription);
            CFRelease(errorDescription);
        }
        NSString *fontName = CFBridgingRelease(CGFontCopyPostScriptName(fontRef));
        UIFont *font = [UIFont fontWithName:fontName size:fontSize];
        objc_setAssociatedObject(self, &DKFontHelperKey, font, OBJC_ASSOCIATION_ASSIGN);
        CGFontRelease(fontRef);
        return font;
    };
}
+ (UIFont *)fontWithPathsize:(CGFloat)fontSize{
    id obj = objc_getAssociatedObject(self, &DKFontHelperKey);
    UIFont *font = (UIFont *)obj;
    if (!font) {
        font = [UIFont systemFontOfSize:fontSize];
    }
    font = [font fontWithSize:fontSize];
   return  font;
}
+ (DKDictionaryPicker)fontWithDict:(NSMutableDictionary *)dict{
    return ^(DKFontVersion *fontVersion) {
        UIFont  *font = [dict objectForKey:NSFontAttributeName];
        CGFloat  pointSize = font.pointSize;
        DKFontPicker picker = [self fontPickerWithPathsize:pointSize];
        [dict setObject:picker(fontVersion) forKey:NSFontAttributeName];
        return dict;
    };
}
+ (DKAttributedStringPicker)attributedStringPickerWithString:(NSString *)attString attributes:(NSMutableDictionary *)dict{
    return ^(DKFontVersion *fontVersion) {
        if ([fontVersion isEqualToString:DKFontVersionDEFAULT]) {
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:attString attributes:dict];
            return attr;
        } else {
            UIFont  *font = [dict objectForKey:NSFontAttributeName];
            CGFloat  pointSize = font.pointSize;
            DKFontPicker picker = [self fontPickerWithPathsize:pointSize];
            [dict setObject:picker(fontVersion) forKey:NSFontAttributeName];
            
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:attString attributes:dict];
            return attr;
        }
    };
}
@end
