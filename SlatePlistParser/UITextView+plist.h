//
//  UITextView+plist.h
//  SlateCore
//
//  Created by tiezhu huang on 12-6-13.
//  Copyright (c) 2012年 islate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (plist)

- (void)setViewFontColor:(NSArray *)color;
- (void)setViewFont:(NSArray *)font;
- (void)setViewSystemFontSize:(NSNumber *)fontSize;
- (void)setViewContentInset:(NSArray *)inset;

@end
