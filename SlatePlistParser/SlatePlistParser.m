//
//  SlatePlistParser.m
//  SlateCore
//
//  Created by lin yize on 14-1-23.
//  Copyright (c) 2014年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import "SlatePlistParser.h"

@implementation SlatePlistParser

+ (void)setPropertyWithKey:(NSString *)key value:(id)value target:(id)target
{
    if (!key || key.length == 0 || !target)
    {
        return;
    }
    
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"set%@:", key]);
    
    if (![target respondsToSelector:selector])
    {
        return;
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    
    [target performSelector:selector withObject:value];
    
#pragma clang diagnostic pop
}

+ (id)getPropertyWithKey:(NSString *)key target:(id)target
{
    id value = nil;
    if (!key || key.length == 0 || !target)
    {
        return nil;
    }
    
    SEL selector = NSSelectorFromString(key);
    
    if (![target respondsToSelector:selector])
    {
        return nil;
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    
    value = [target performSelector:selector];
    
#pragma clang diagnostic pop
    return value;
}

+ (void)setPropertyDictionary:(NSDictionary *)propertyDictionary target:(id)target
{
    if (![propertyDictionary isKindOfClass:[NSDictionary class]] || !target)
    {
        return;
    }

    for (NSString *key in [propertyDictionary allKeys])
    {
        id value = [propertyDictionary objectForKey:key];
        [self setPropertyWithKey:key value:value target:target];
    }
}

/**
 *  解析item字典，设置target的属性及其子对象的属性
 *
 *  @param itemDictionary   item字典，对应每个item的字典
 *  @param target           要处理的对象
 *  @param orientation      目前的UI方向
 */
+ (void)applyPropertyWithItemDictionary:(NSDictionary *)itemDictionary target:(id)target orientation:(UIInterfaceOrientation)orientation
{
    if (![itemDictionary isKindOfClass:[NSDictionary class]])
    {
        return;
    }
    
    if (!target)
    {
        target = [itemDictionary objectForKey:@"instance"];
        if (!target)
        {
            return;
        }
    }

    // 跟方向有关的属性
    if (UIInterfaceOrientationIsLandscape(orientation))
    {
        // @"Landscape" or @"HVProperty"
        NSDictionary *propertyDictionary = [itemDictionary objectForKey:@"Landscape"] ?: [itemDictionary objectForKey:@"HVProperty"];
        [self setPropertyDictionary:propertyDictionary target:target];
    }
    else
    {
        // "Portrait" or @"VVProperty"
        NSDictionary *propertyDictionary = [itemDictionary objectForKey:@"Portrait"] ?: [itemDictionary objectForKey:@"VVProperty"];
        [self setPropertyDictionary:propertyDictionary target:target];
    }

    // 与方向无关的属性
    NSArray *commonPropertyKeys = @[@"ColumnItemViewType", @"ColumnItemViewTypeArray"];
    for (NSString *key in commonPropertyKeys)
    {
        id value = [itemDictionary objectForKey:key];
        if (value)
        {
            [self setPropertyWithKey:key value:value target:target];
        }
    }
    
    // 已存在的子对象
    NSDictionary *itemViews = [itemDictionary objectForKey:@"itemViews"];
    if ([itemViews isKindOfClass:[NSDictionary class]])
    {
        for (NSString *itemName in [itemViews allKeys])
        {
            NSDictionary *subItemDictionary = [itemViews objectForKey:itemName];
            if ([subItemDictionary isKindOfClass:[NSDictionary class]])
            {
                id subTarget = [self getPropertyWithKey:itemName target:target];
                if (!subTarget)
                {
                    continue;
                }
                [self applyPropertyWithItemDictionary:subItemDictionary target:subTarget orientation:orientation];
            }
        }
    }
    
    // 动态插入的子对象
    NSDictionary *subviews = [itemDictionary objectForKey:@"subviews"];
    if ([subviews isKindOfClass:[NSDictionary class]] && [target isKindOfClass:[UIView class]])
    {
        [self applyPropertyWithPlistDictionary:subviews orientation:orientation];
    }
}

/**
 *  解析已生成子对象的plist字典，设置其子对象的属性
 *
 *  @param plistDictionary  plist字典，从plist文件中解析出来的字典并且已生成子对象
 *  @param orientation      目前的UI方向
 */
+ (void)applyPropertyWithPlistDictionary:(NSDictionary *)plistDictionary orientation:(UIInterfaceOrientation)orientation
{
    for (NSString *itemName in [plistDictionary allKeys])
    {
        if ([[plistDictionary objectForKey:itemName] isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *itemDictionary = [plistDictionary objectForKey:itemName];
            id target = [itemDictionary objectForKey:@"instance"];
            if (!target)
            {
                continue;
            }
            [self applyPropertyWithItemDictionary:itemDictionary target:target orientation:orientation];
        }
        else if ([[plistDictionary objectForKey:itemName] isKindOfClass:[NSArray class]])
        {
            NSArray *itemArray = [plistDictionary objectForKey:itemName];
            for (NSDictionary *itemDictionary in itemArray)
            {
                id target = [itemDictionary objectForKey:@"instance"];
                if (!target)
                {
                    continue;
                }
                [self applyPropertyWithItemDictionary:itemDictionary target:target orientation:orientation];
            }
        }
    }
}

/**
 *  解析item字典，创建子视图添加到视图上
 *
 *  @param itemDictionary 未创建子视图的item字典
 *  @param itemName       item的名称
 如果该item是早已存在的对象，则需要传递itemName  如果该item是需要创建的对象，则itemName为nil
 *  @param view           要添加子视图的视图
 *  @param objectBlock    对每个被创建的子视图做处理的block
 *
 *  @return 已创建子视图的item字典
 */
+ (NSMutableDictionary *)addSubviewsWithItemDictionary:(NSDictionary *)itemDictionary itemName:(NSString *)itemName toView:(UIView *)view objectBlock:(void(^)(id object))objectBlock
{
    if (![itemDictionary isKindOfClass:[NSDictionary class]])
    {
        return nil;
    }
    
    NSMutableDictionary *mutableItemDictionary = [NSMutableDictionary dictionaryWithDictionary:itemDictionary];
    id object = nil;
    BOOL needAddSubView = NO;
    if (itemName)
    {
        object = [self getPropertyWithKey:itemName target:view];
    }
    else
    {
        NSString *classString = [itemDictionary objectForKey:@"class"];
        if (view && [classString isKindOfClass:[NSString class]])
        {
            Class classPointer = NSClassFromString(classString);
            if (classPointer)
            {
                object = [classPointer new];
                needAddSubView = YES;
            }
        }
        
        if (object == nil)
        {
            NSString *fallbackClassString = [itemDictionary objectForKey:@"fallbackClass"];
            if (view && [fallbackClassString isKindOfClass:[NSString class]])
            {
                Class classPointer = NSClassFromString(fallbackClassString);
                if (classPointer)
                {
                    object = [classPointer new];
                    needAddSubView = YES;
                }
            }
        }
    }
    
    if (object)
    {
        [mutableItemDictionary setObject:object forKey:@"instance"];
        
        if (view && [object isKindOfClass:[UIView class]])
        {
            if (needAddSubView)
            {
                [view addSubview:object];
            }
        }
        
        // 待创建的子视图 subviews
        id subviews = [itemDictionary objectForKey:@"subviews"];
        if ([subviews isKindOfClass:[NSDictionary class]])
        {
            NSMutableDictionary *mutableSubviewsDictionary = [self addSubviewsWithPlistDictionary:subviews toView:object objectBlock:objectBlock];
            if (mutableSubviewsDictionary)
            {
                [mutableItemDictionary setObject:mutableSubviewsDictionary forKey:@"subviews"];
            }
        }
        
        // 早已存在的子视图 itemViews
        id itemViews = [itemDictionary objectForKey:@"itemViews"];
        if ([itemViews isKindOfClass:[NSDictionary class]])
        {
            NSMutableDictionary *mutableItemViewsDictionary = [NSMutableDictionary dictionaryWithDictionary:itemViews];
            for (NSString *key in [mutableItemViewsDictionary allKeys])
            {
                id value = [mutableItemViewsDictionary objectForKey:key];
                // 为了递归创建子视图的subviews字典
                NSMutableDictionary *mutableItemDictionary = [self addSubviewsWithItemDictionary:value itemName:key toView:object objectBlock:objectBlock];
                if (mutableItemDictionary)
                {
                    [mutableItemViewsDictionary setObject:mutableItemDictionary forKey:key];
                }
            }
            [mutableItemDictionary setObject:mutableItemViewsDictionary forKey:@"itemViews"];
        }
        
        if (objectBlock)
        {
            objectBlock(object);
        }
    }
    
    return mutableItemDictionary;
}

/**
 *  解析plist字典，创建子视图添加到视图上，并递归创建每一层子视图
 *
 *  @param plistDictionary 未创建子视图的plist字典
 *  @param view            要添加子视图的视图
 *  @param objectBlock     对每个被创建的子视图做处理的block
 *
 *  @return 已创建子视图的plist字典
 */
+ (NSMutableDictionary *)addSubviewsWithPlistDictionary:(NSDictionary *)plistDictionary toView:(UIView *)view objectBlock:(void(^)(id object))objectBlock
{
    if (![plistDictionary isKindOfClass:[NSDictionary class]])
    {
        return nil;
    }
    
    NSMutableDictionary *mutablePlistDictionary = [NSMutableDictionary dictionaryWithDictionary:plistDictionary];
    NSArray *allKeys = [plistDictionary allKeys];
    NSArray *keys = [allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

    for (int i = 0; i < [keys count]; i++)
    {
        NSString *key = [keys objectAtIndex:i];
        id value = [plistDictionary objectForKey:key];
        
        if ([value isKindOfClass:[NSArray class]])
        {
            NSMutableArray *itemArray = value;
            NSMutableArray *mutableItemArray = [NSMutableArray arrayWithCapacity:[itemArray count]];
            
            for (NSDictionary *itemDictionary in itemArray)
            {
                NSMutableDictionary *mutableItemDictionary = [self addSubviewsWithItemDictionary:itemDictionary itemName:nil toView:view objectBlock:objectBlock];
                if (mutableItemDictionary)
                {
                    [mutableItemArray addObject:mutableItemDictionary];
                }
            }

            [mutablePlistDictionary setObject:mutableItemArray forKey:key];
        }
        else if ([value isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *itemDictionary = value;
            NSMutableDictionary *mutableItemDictionary = [self addSubviewsWithItemDictionary:itemDictionary itemName:nil toView:view objectBlock:objectBlock];
            if (mutableItemDictionary)
            {
                [mutablePlistDictionary setObject:mutableItemDictionary forKey:key];
            }
        }
    }
    return mutablePlistDictionary;
}

@end
