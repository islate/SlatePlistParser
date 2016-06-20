//
//  UIView+plist.h
//  SlateCore
//
//  Created by tiezhu huang on 12-6-13.
//  Copyright (c) 2012年 islate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (plist)

- (void)setViewHidden:(NSNumber *)hidden;
- (void)setViewFrame:(NSArray *)frame;
- (void)setViewFrame_iPhone5:(NSArray *)frame;
- (void)setViewFrame_iPhone6:(NSArray *)frame;
- (void)setViewFrame_iPhone6Plus:(NSArray *)frame;
- (void)setViewBackgroundColor:(NSArray *)backgroundColor;
- (void)setViewTag:(NSNumber *)tag;
- (void)setViewAlpha:(NSNumber *)alpha;
- (void)setViewClearColor:(NSNumber *)clear;
- (void)setViewCornerRadius:(NSNumber *)radius;
- (void)setViewShadow:(NSNumber *)shadow;
- (void)setViewShadowColor:(NSArray *)backgroundColor;
- (void)setViewShadowOffset:(NSArray *)offsetArray;
- (void)setViewShadowOpacity:(NSNumber *)shadow;
- (void)setViewShadowRadius:(NSNumber *)shadow;
- (void)setViewUserInteractionEnabled:(NSNumber *)Enabled;
- (void)setViewOrigin:(NSArray *)xy;
- (void)setViewRelativeHeight:(NSNumber *)height;
- (void)setViewRightOrigin:(NSArray *)rightMarginAndY;
- (void)setViewBackgroundColorAndAlpha:(NSArray *)backgroundColorAndAlpha;
- (void)setViewBackgroundImageColor:(NSString *)imageName;
- (UIInterfaceOrientation)currentOrientation;
- (void)setViewClipsToBounds:(NSNumber *)hidden;

@end
