//
//  UILabel+plist.h
//  SlateCore
//
//  Created by tiezhu huang on 12-6-13.
//  Copyright (c) 2012年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (plist)

- (void)setViewFontColor:(NSArray *)color;
- (void)setViewFont:(NSArray *)font;
- (void)setViewSystemFontSize:(NSNumber *)fontSize;
- (void)setViewBoldSystemFontSize:(NSNumber *)fontSize;
- (void)setViewNumberOfLines:(NSNumber *)number;
- (void)setViewText:(NSString *)text;
- (void)setLabelTextAlignment:(NSNumber *)alignment;
- (void)setLabelShadowOffset:(NSArray *)offsetArray;
- (void)setLabelShadowColor:(NSArray *)backgroundColor;

@end
