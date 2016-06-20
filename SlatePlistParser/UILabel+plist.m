//
//  UILabel+plist.m
//  SlateCore
//
//  Created by tiezhu huang on 12-6-13.
//  Copyright (c) 2012年 islate. All rights reserved.
//

#import "UILabel+plist.h"

#import "SlateConstants.h"

@implementation UILabel (plist)

- (void)setLabelShadowOffset:(NSArray *)offsetArray
{
    if ((offsetArray == nil) || ([offsetArray count] < 2))
    {
        return;
    }
    
    self.shadowOffset = CGSizeMake([[offsetArray objectAtIndex:0] floatValue], [[offsetArray objectAtIndex:1] floatValue]);
}

- (void)setLabelShadowColor:(NSArray *)color
{
    if ((color == nil) || ([color count] < 3))
    {
        return;
    }
    
    self.shadowColor = COLOR(color);
}

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
    self.font = [UIFont fontWithName:[font objectAtIndex:0] size:[[font objectAtIndex:1] floatValue]];
}

- (void)setLabelTextAlignment:(NSNumber *)alignment
{
    self.textAlignment = [alignment intValue];
}

- (void)setViewNumberOfLines:(NSNumber *)number
{
    self.numberOfLines = [number intValue];
}

- (void)setViewText:(NSString *)text
{
    self.text = text;
}

- (void)setViewSystemFontSize:(NSNumber *)fontSize
{
    self.font = [UIFont systemFontOfSize:[fontSize floatValue]];
}

- (void)setViewBoldSystemFontSize:(NSNumber *)fontSize
{
    self.font = [UIFont boldSystemFontOfSize:[fontSize floatValue]];
}

@end
