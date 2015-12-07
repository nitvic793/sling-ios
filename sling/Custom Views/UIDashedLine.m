//
//  UIDashedLine.m
//  grofer-consumer
//
//  Created by Satyam Krishna on 17/04/15.
//  Copyright (c) 2015 GroferIt. All rights reserved.
//

#import "UIDashedLine.h"
#import "Constants.h"

@implementation UIDashedLine

-(void)drawRect:(CGRect)rect
{
    CGFloat thickness = 4.0;
    
    CGContextRef cx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(cx, thickness);
    CGContextSetStrokeColorWithColor(cx, UIColorFromRGB(SEPARATOR_COLOR).CGColor);
    
    CGFloat ra[] = {4,2};
    CGContextSetLineDash(cx, 0.0, ra, 2); // nb "2" == ra count
    
    CGContextMoveToPoint(cx, 0,thickness*0.5);
    CGContextAddLineToPoint(cx, self.bounds.size.width, thickness*0.5);
    CGContextStrokePath(cx);
}

@end
