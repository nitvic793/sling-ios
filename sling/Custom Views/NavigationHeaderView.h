//
//  NavigationHeaderView.h
//  grofer-consumer
//
//  Created by Satyam Krishna on 09/01/15.
//  Copyright (c) 2015 GroferIt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonFunction.h"

@interface NavigationHeaderView : UIView

@property (weak, nonatomic) id parentVC;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UIBarButtonItem *barBackButton;
@property (nonatomic) BOOL hasCloseButton;
@property (nonatomic) int negativeTitleSpace;

- (id)initMainHeaderWithParent:(id)parent WithTitle:(NSString *)titletext backButtonRequired:(BOOL)backButtonRequired;

@end
