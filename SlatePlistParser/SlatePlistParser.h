//
//  SlatePlistParser.h
//  SlateCore
//
//  Created by lin yize on 14-1-23.
//  Copyright (c) 2014年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import "UIButton+plist.h"
#import "UIImageView+plist.h"
#import "UILabel+plist.h"
#import "UIScrollView+plist.h"
#import "UITableView+plist.h"
#import "UITextView+plist.h"
#import "UIView+plist.h"

/**
 *  用plist设置视图属性的解释器
 */
@interface SlatePlistParser : NSObject

/**
 *  解析item字典，设置target的属性及其子对象的属性
 *
 *  @param itemDictionary   item字典，对应每个item的字典
 *  @param target           要处理的对象
 *  @param orientation      目前的UI方向
 */
+ (void)applyPropertyWithItemDictionary:(NSDictionary *)itemDictionary target:(id)target orientation:(UIInterfaceOrientation)orientation;

/**
 *  解析已生成子对象的plist字典，设置其子对象的属性
 *
 *  @param plistDictionary  plist字典，从plist文件中解析出来的字典并且已生成子对象
 *  @param orientation      目前的UI方向
 */
+ (void)applyPropertyWithPlistDictionary:(NSDictionary *)plistDictionary orientation:(UIInterfaceOrientation)orientation;

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
+ (NSMutableDictionary *)addSubviewsWithItemDictionary:(NSDictionary *)itemDictionary itemName:(NSString *)itemName toView:(UIView *)view objectBlock:(void(^)(id object))objectBlock;

/**
 *  解析plist字典，创建子视图添加到视图上，并递归创建每一层子视图
 *
 *  @param plistDictionary 未创建子视图的plist字典
 *  @param view            要添加子视图的视图
 *  @param objectBlock     对每个被创建的子视图做处理的block
 *
 *  @return 已创建子视图的plist字典
 */
+ (NSMutableDictionary *)addSubviewsWithPlistDictionary:(NSDictionary *)plistDictionary toView:(UIView *)view objectBlock:(void(^)(id object))objectBlock;

@end
