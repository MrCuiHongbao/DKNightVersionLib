//
//  DKFont.h
//  DKNightVersion
//
//  Created by CuiHongbao on 17/3/13.
//  Copyright © 2017年 Draveness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
typedef NSString DKFontVersion;

typedef UIFont  *(^DKFontPicker)(DKFontVersion *fontsVersion);
typedef NSDictionary *(^DKDictionaryPicker)(DKFontVersion *fontsVersion);
typedef NSMutableAttributedString *(^DKAttributedStringPicker)(DKFontVersion *fontsVersion);
@interface DKFont : NSObject

+ (DKFontPicker)fontPickerWithPathsize:(CGFloat)fontSize;
+ (UIFont *)fontWithPathsize:(CGFloat)fontSize;
+ (DKDictionaryPicker)fontWithDict:(NSMutableDictionary *)dict;
+ (DKAttributedStringPicker)attributedStringPickerDict:(NSMutableDictionary *)dict;
+ (DKAttributedStringPicker)attributedStringPickerWithString:(NSString *)attString attributes:(NSMutableDictionary *)dict;//富文本
@end
