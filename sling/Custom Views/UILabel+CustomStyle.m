//
//  UILabel+CustomStyle.m
//  grofer-consumer
//
//  Created by Satyam Krishna on 09/01/15.
//  Copyright (c) 2015 GroferIt. All rights reserved.
//

#import "UILabel+CustomStyle.h"

@implementation UILabel (CustomStyle)

- (id) initWithCustomStyle : (UILabelCustomStyle *) style
{
    self = [[UILabel alloc] init];
    if(self)
    {
        [self setFont:[style font]];
        [self setTextColor:[style color]];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

@end
