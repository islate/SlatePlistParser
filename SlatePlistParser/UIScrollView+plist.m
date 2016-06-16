//
//  UIScrollView+plist.m
//  SlateCore
//
//  Created by tiezhu huang on 12-6-13.
//  Copyright (c) 2012年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import "UIScrollView+plist.h"

@implementation UIScrollView (plist)

- (void)setViewContentSize:(NSArray *)contentSize
{
    if ((contentSize == nil) || ([contentSize count] < 2))
    {
        return;
    }

    [self setContentSize:CGSizeMake([[contentSize objectAtIndex:0]floatValue], [[contentSize objectAtIndex:1]floatValue])];
}

- (void)setViewScrollEnable:(NSNumber *)enable
{
    [self setScrollEnabled:[enable boolValue]];
}

- (void)setViewHorizontalScrollIndicator:(NSNumber *)enable
{
    self.showsHorizontalScrollIndicator = [enable boolValue];
}

- (void)setVerticalScrollIndicator:(NSNumber *)enable
{
    self.showsVerticalScrollIndicator = [enable boolValue];
}

@end
