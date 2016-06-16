//
//  UIImageView+plist.m
//  SlateCore
//
//  Created by tiezhu huang on 12-6-13.
//  Copyright (c) 2012年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import "UIImageView+plist.h"

@implementation UIImageView (plist)

- (void)setImageName:(NSString *)name
{
    self.image = [UIImage imageNamed:name];
}

- (void)setStretchImageName:(NSArray *)info
{
    if ([info count] == 3) {
        
        NSString *imageName = [info objectAtIndex:0];
        
        NSNumber *leftCap = [info objectAtIndex:1];
        
        NSNumber *topCap = [info objectAtIndex:2];
        
        if ([imageName isKindOfClass:[NSString class]] &&
            [topCap isKindOfClass:[NSNumber class]] &&
            [leftCap isKindOfClass:[NSNumber class]])
        {
            UIImage *image = [UIImage imageNamed:imageName];
            
            if (image) {
                UIImage *stretchImage = [image stretchableImageWithLeftCapWidth:[leftCap integerValue] topCapHeight:[topCap integerValue]];
                
                self.image = stretchImage;
            }
        }
        
    }
}

@end
