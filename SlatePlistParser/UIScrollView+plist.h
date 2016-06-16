//
//  UIScrollView+plist.h
//  SlateCore
//
//  Created by tiezhu huang on 12-6-13.
//  Copyright (c) 2012年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (plist)

- (void)setViewContentSize:(NSArray *)contentSize;
- (void)setViewScrollEnable:(NSNumber *)enable;

- (void)setViewHorizontalScrollIndicator:(NSNumber *)enable;
- (void)setVerticalScrollIndicator:(NSNumber *)enable;

@end