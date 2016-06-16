//
//  UITableView+plist.h
//  SlateCore
//
//  Created by tiezhu huang on 12-6-13.
//  Copyright (c) 2012年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (plist)

- (void)setViewSeparatorStyle:(NSNumber *)hidden;
- (void)setTableSeparatorColor:(NSArray *)array;
- (void)setViewSeparatorColor:(NSArray *)SeparatorColor;
- (void)setViewBackgroundImage:(NSString *)imageName;

@end