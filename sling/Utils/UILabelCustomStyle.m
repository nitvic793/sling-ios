//
//  UILabelCustomStyle.m
//  grofer-consumer
//
//  Created by Satyam Krishna on 09/01/15.
//  Copyright (c) 2015 GroferIt. All rights reserved.
//

#import "UILabelCustomStyle.h"
#import "Constants.h"

@implementation UILabelCustomStyle

@synthesize font;
@synthesize color;
@synthesize allCaps;

- (id) initWithFont : (UIFont *) customFont
{
    self = [super init];
    if(self)
    {
        [self setFont:customFont];
        [self setColor:UIColorFromRGB(GBL5)];
        [self setAllCaps:NO];
        return self;
    }
    return nil;
}

- (id) initWithFont : (UIFont *) customFont color:(UIColor *) customColor
{
    self = [super init];
    if(self)
    {
        [self setFont:customFont];
        [self setColor:customColor];
        [self setAllCaps:NO];
        return self;
    }
    return nil;
    
}

- (id) initWithFont : (UIFont *) customFont color:(UIColor *) customColor allCaps : (BOOL) isAllCaps
{
    self = [super init];
    if(self != nil)
    {
        [self setFont:customFont];
        [self setColor:customColor];
        [self setAllCaps:isAllCaps];
        return self;
    }
    return nil;
}


@end
