//
//  UILabelCustomStyle.h
//  grofer-consumer
//
//  Created by Satyam Krishna on 09/01/15.
//  Copyright (c) 2015 GroferIt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabelCustomStyle : NSObject

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic) BOOL allCaps;

- (id) initWithFont : (UIFont *) customFont;
- (id) initWithFont : (UIFont *) customFont color:(UIColor *) customColor;
- (id) initWithFont : (UIFont *) customFont color:(UIColor *) customColor allCaps : (BOOL) isAllCaps;

@end
