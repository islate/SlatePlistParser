//
//  UIView+plist.m
//  SlateCore
//
//  Created by tiezhu huang on 12-6-13.
//  Copyright (c) 2012年 islate. All rights reserved.
//

#import "UIView+plist.h"

#import "SlateConstants.h"

@implementation UIView (plist)

- (void)setViewShadowColor:(NSArray *)backgroundColor
{
    if ((backgroundColor == nil) || ([backgroundColor count] < 3))
    {
        return;
    }
    
    self.layer.shadowColor = (COLOR(backgroundColor)).CGColor;
}

- (void)setViewBackgroundColor:(NSArray *)backgroundColor
{
    if ((backgroundColor == nil) || ([backgroundColor count] < 3))
    {
        return;
    }

    self.backgroundColor = COLOR(backgroundColor);
}

- (void)setViewBackgroundColorAndAlpha:(NSArray *)backgroundColorAndAlpha
{
    if ((backgroundColorAndAlpha == nil) || ([backgroundColorAndAlpha count] < 3))
    {
        return;
    }

    self.backgroundColor = COLOR(backgroundColorAndAlpha);
}

- (void)setViewHidden:(NSNumber *)hidden
{
    if (hidden == nil)
    {
        return;
    }

    [self setHidden:[hidden boolValue]];
}

- (void)setViewUserInteractionEnabled:(NSNumber *)Enabled
{
    if (Enabled == nil)
    {
        return;
    }

    self.userInteractionEnabled = [Enabled boolValue];
}

- (void)setViewFrame:(NSArray *)frame
{
    if ((frame == nil) || ([frame count] < 4))
    {
        return;
    }

    if (IsPad || Is3P5Inch)
    {
        [self setFrame:FRAME(frame)];
    }
}

- (void)setViewFrame_iPhone5:(NSArray *)frame
{
    if ((frame == nil) || ([frame count] < 4))
    {
        return;
    }
    
    if (Is4Inch)
    {
        [self setFrame:FRAME(frame)];
    }
}

- (void)setViewFrame_iPhone6:(NSArray *)frame
{
    if ((frame == nil) || ([frame count] < 4))
    {
        return;
    }
    
    if (Is4P7Inch)
    {
        [self setFrame:FRAME(frame)];
    }
}

- (void)setViewFrame_iPhone6Plus:(NSArray *)frame
{
    if ((frame == nil) || ([frame count] < 4))
    {
        return;
    }
    
    if (Is5P5Inch)
    {
        [self setFrame:FRAME(frame)];
    }
}

- (void)setViewTag:(NSNumber *)tag
{
    if (tag == nil)
    {
        return;
    }

    self.tag = [tag intValue];
}

- (void)setViewAlpha:(NSNumber *)alpha
{
    if (alpha == nil)
    {
        return;
    }

    float aa = (float)[alpha intValue] / 10.0;
    [self setAlpha:aa];
}

- (void)setViewClearColor:(NSNumber *)clear
{
    if ([clear intValue] == 1)
    {
        self.backgroundColor = [UIColor clearColor];
    }
}

- (void)setViewCornerRadius:(NSNumber *)radius
{
    self.layer.cornerRadius = [radius intValue];
}

- (void)setViewShadow:(NSNumber *)shadow
{
    self.layer.shadowOffset = CGSizeMake([shadow intValue], [shadow intValue]);
}

- (void)setViewShadowOpacity:(NSNumber *)shadow
{
    self.layer.shadowOpacity = [shadow intValue];
}
- (void)setViewShadowRadius:(NSNumber *)shadow
{
    self.layer.shadowRadius = [shadow intValue];
}

- (void)setViewShadowOffset:(NSArray *)offsetArray
{
    if ((offsetArray == nil) || ([offsetArray count] < 2))
    {
        return;
    }
    
    self.layer.shadowOffset = CGSizeMake([[offsetArray objectAtIndex:0] floatValue], [[offsetArray objectAtIndex:1] floatValue]);
}

- (void)setViewOrigin:(NSArray *)xy
{
    if (xy && (xy.count == 2))
    {
        CGRect frame = CGRectMake([[xy objectAtIndex:0] floatValue], [[xy objectAtIndex:1] floatValue], self.frame.size.width, self.frame.size.height);
        self.frame = frame;
    }
}

- (void)setViewRightOrigin:(NSArray *)widthAndRightMarginAndY
{
    if (widthAndRightMarginAndY && (widthAndRightMarginAndY.count == 3))
    {
        CGFloat x = [[widthAndRightMarginAndY objectAtIndex:0] floatValue] - [[widthAndRightMarginAndY objectAtIndex:1] floatValue] - self.frame.size.width;
        CGRect  frame = CGRectMake(x, [[widthAndRightMarginAndY objectAtIndex:2] floatValue], self.frame.size.width, self.frame.size.height);
        self.frame = frame;
    }
}

- (void)setViewRelativeHeight:(NSNumber *)height
{
    if (self.superview)
    {
        CGRect frame = self.frame;
        frame.origin.y = self.superview.frame.size.height - [height floatValue];
        self.frame = frame;
    }
}

- (void)setViewBackgroundImageColor:(NSString *)imageName
{
    if([UIImage imageNamed:imageName])
    {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
    }
}

- (UIInterfaceOrientation)currentOrientation
{
    UIInterfaceOrientation statusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    static NSString *_orientationFlagNames[] = {
        Nil,                                        // UIDeviceOrientationUnknown
        @"UIInterfaceOrientationPortrait",          // UIDeviceOrientationPortrait,
        @"UIInterfaceOrientationPortraitUpsideDown",// UIDeviceOrientationPortraitUpsideDown,
        @"UIInterfaceOrientationLandscapeRight",    // UIDeviceOrientationLandscapeLeft [sic]
        @"UIInterfaceOrientationLandscapeLeft"      // UIDeviceOrientationLandscapeRight [sic]
        // UIDeviceOrientationFaceUp
        // UIDeviceOrientationFaceDown
    };
    
    NSString *supportedKey = @"UISupportedInterfaceOrientations";
    NSArray *supportedOrientations = [[[NSBundle mainBundle] infoDictionary] objectForKey:supportedKey];
    
    if ([supportedOrientations containsObject:_orientationFlagNames[statusBarOrientation]]) {
        return statusBarOrientation;
    }
    
    if ([supportedOrientations count] == 0) {
        return UIInterfaceOrientationPortrait;
    }
    
    NSString *orientationString = [supportedOrientations objectAtIndex:0];
    if ([orientationString rangeOfString:@"Portrait"].length > 0) {
        return UIInterfaceOrientationPortrait;
    }
    return UIInterfaceOrientationLandscapeLeft;
}

- (void)setViewClipsToBounds:(NSNumber *)hidden
{
    self.clipsToBounds = [hidden boolValue];
}

@end
