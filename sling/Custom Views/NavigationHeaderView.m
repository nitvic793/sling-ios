//
//  NavigationHeaderView.m
//  grofer-consumer
//
//  Created by Satyam Krishna on 09/01/15.
//  Copyright (c) 2015 GroferIt. All rights reserved.
//

#import "NavigationHeaderView.h"
#import "UILabel+CustomStyle.h"

@implementation NavigationHeaderView
{
    BOOL backButtonSpaceRequired;
}

@synthesize parentVC;
@synthesize titleLabel;
@synthesize backButton;
@synthesize barBackButton;
@synthesize hasCloseButton;
@synthesize negativeTitleSpace;

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        // Initalize Value
        negativeTitleSpace = 0;
    }
    return self;
}

- (id)initMainHeaderWithParent:(id)parent WithTitle:(NSString *)titletext backButtonRequired:(BOOL)backButtonRequired
{
    self = [self initWithFrame:CGRectMake(0, 0, [CommonFunction getPhoneWidth], MAIN_HEADER_HEIGHT)];
    
    negativeTitleSpace = 0;
    parentVC = parent;
    backButtonSpaceRequired = backButtonRequired;
    
    if(titletext != nil)
    {
        titleLabel = [[UILabel alloc] init];
        [titleLabel setFont:FONT_NAV_BAR_LABEL];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextAlignment:NSTextAlignmentLeft];
        [titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [titleLabel setTextColor:UIColorFromRGB(NAV_BAR_ITEMS_COLOR)];
        [titleLabel setText:titletext];
    }
    
    hasCloseButton = NO;
    return self;
}

- (void) layoutSubviews
{
    if (!hasCloseButton)
    {
        if ([CommonFunction isIOS9])
        {
            [titleLabel setFrame:CGRectMake(0, 0, [CommonFunction getPhoneWidth]-120, H(self))];
        }
        else
        {
            [titleLabel setFrame:CGRectMake(0, 0, [CommonFunction getPhoneWidth]-94, H(self))];
        }
    }
    else
    {
        [titleLabel setFrame:CGRectMake(0, 0, [CommonFunction getPhoneWidth]-89, H(self))];
    }
    
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self addSubview:titleLabel];
}

@end
