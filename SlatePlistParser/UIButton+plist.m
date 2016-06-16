//
//  UIButton+plist.m
//  SlateCore
//
//  Created by Xiangjian Meng on 12-8-15.
//  Copyright (c) 2012年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import "UIButton+plist.h"

@implementation UIButton (plist)

- (void)setImageName:(NSString *)name
{
    [self setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
}

- (void)setHighlightImageName:(NSString *)name
{
    [self setImage:[UIImage imageNamed:name] forState:UIControlStateHighlighted];
}

- (void)setSelectImageName:(NSString *)name
{
    [self setImage:[UIImage imageNamed:name] forState:UIControlStateSelected];
}

- (void)setselectorName:(NSString *)selectorName
{
    [self setSelectorName:selectorName];
}

- (void)setSelectorName:(NSString *)selectorName
{
    SEL selector = NSSelectorFromString(selectorName);
    
    if (self.allTargets.count == 0)
    {
        if ([self.superview respondsToSelector:selector])
        {
            [self addTarget:self.superview action:selector forControlEvents:UIControlEventTouchUpInside];
        }
        return;
    }
    
    for (id target in [self.allTargets mutableCopy])
    {
        if ([target respondsToSelector:selector])
        {
            [self removeTarget:target action:NULL forControlEvents:UIControlEventAllTouchEvents];
            [self addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

@end
