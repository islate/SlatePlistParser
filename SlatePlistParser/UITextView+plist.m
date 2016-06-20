//
//  UITextView+plist.m
//  SlateCore
//
//  Created by tiezhu huang on 12-6-13.
//  Copyright (c) 2012年 islate. All rights reserved.
//

#import "UITextView+plist.h"

#import "SlateConstants.h"

@implementation UITextView (plist)

- (void)setViewFontColor:(NSArray *)color
{
    if ((color == nil) || ([color count] < 3))
    {
        return;
    }

    self.textColor = COLOR(color);
}

- (void)setViewFont:(NSArray *)font
{
    if ((font == nil) || ([font count] < 2))
    {
        return;
    }

    self.font = [UIFont fontWithName:[font objectAtIndex:0] size:[[font objectAtIndex:1] floatValue]];
}

- (void)setViewSystemFontSize:(NSNumber *)fontSize
{
    self.font = [UIFont systemFontOfSize:[fontSize floatValue]];
}

- (void)setViewContentInset:(NSArray *)inset
{
    if ((inset == nil) || ([inset count] < 4))
    {
        return;
    }
    
    self.contentInset = UIEdgeInsetsMake([[inset objectAtIndex:0] floatValue], [[inset objectAtIndex:1] floatValue], [[inset objectAtIndex:2] floatValue], [[inset objectAtIndex:3] floatValue]);
}


#ifdef DEBUG
// 解决xCode7.3 无法debugView的问题
- (void)_firstBaselineOffsetFromTop
{
    
}

- (void)_baselineOffsetFromBottom
{
    
}
#endif

@end
