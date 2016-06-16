//
//  UIButton+plist.h
//  SlateCore
//
//  Created by Xiangjian Meng on 12-8-15.
//  Copyright (c) 2012年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (plist)

- (void)setImageName:(NSString *)name;
- (void)setHighlightImageName:(NSString *)name;
- (void)setSelectImageName:(NSString *)name;
- (void)setselectorName:(NSString *)selectorName;
- (void)setSelectorName:(NSString *)selectorName;

@end