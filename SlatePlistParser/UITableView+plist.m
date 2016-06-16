//
//  UITableView+plist.m
//  SlateCore
//
//  Created by tiezhu huang on 12-6-13.
//  Copyright (c) 2012年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import "UITableView+plist.h"

#import "SlateConstants.h"

@implementation UITableView (plist)

- (void)setTableSeparatorColor:(NSArray *)array
{
    [self setViewSeparatorColor:array];
}

- (void)setViewSeparatorColor:(NSArray *)array
{
    if ((array == nil) || ([array count] < 3))
    {
        return;
    }

    self.separatorColor = COLOR(array);
}

- (void)setViewSeparatorStyle:(NSNumber *)hidden
{
    self.separatorStyle = [hidden boolValue];
}

- (void)setViewBackgroundImage:(NSString *)imageName
{
    UIImageView *backView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [self setBackgroundView:backView];
}

@end
