//
//  GImageSlider.h
//  grofer-consumer
//
//  Created by Prince Shekhar Valluri on 25/05/15.
//  Copyright (c) 2015 GroferIt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface ImageSlider : UIView <UIScrollViewDelegate>

- (id)initWithFrame:(CGRect)frame andImages:(NSArray *)images andContentMode:(UIViewContentMode)contentMode andSidePadding:(CGFloat)sidePadding;
- (void)setCurrentPageTintColor:(UIColor *)color1 andOtherPagesTintColor:(UIColor *)color2;
@end
