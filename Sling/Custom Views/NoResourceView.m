//
//  NoResourceView.m
//  Sling
//
//  Created by Satyam Krishna on 27/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "NoResourceView.h"
#import "CommonFunction.h"
#import "AFNetworkReachabilityManager.h"

#define IMG_SIZE 100

@implementation NoResourceView
{
    NSString *iconLabelText;
    NSString *mainLabelText;
    NSString *subLabelText;
    NSString *buttonLabelText;
    
    NSUInteger TAG;
    
    UIView *separator;
}

@synthesize iconImg;
@synthesize iconLabel;
@synthesize mainLabel;
@synthesize subLabel;
@synthesize button;
@synthesize delegate;
@synthesize imgSize;

-(id) init
{
    self = [super init];
    
    if (self)
    {
        [self initializeVariables];
    }
    
    return self;
}

-(void) initializeVariables
{
    imgSize.width = IMG_SIZE;
    imgSize.height = IMG_SIZE;
}

-(void) setupViews
{
    
}

-(void) setFrames
{
    
}

-(id) initWithIconText:(NSString *) iconText andMainText:(NSString *) mainText andSubText:(NSString *) subText andButtonText:(NSString *) buttonText andTag:(NSUInteger) tag
{
    self = [self initWithIconText:iconText andMainText:mainText andSubText:subText andButtonText:buttonText];
    if (self)
    {
        TAG = tag;
    }
    return self;
}

-(id) initWithIconText:(NSString *) iconText andMainText:(NSString *) mainText andSubAttrText:(NSAttributedString *) subText andButtonText:(NSString *) buttonText andTag:(NSUInteger) tag
{
    self = [self initWithIconText:iconText andMainText:mainText andSubAttrText:subText andButtonText:buttonText];
    if (self)
    {
        TAG = tag;
    }
    return self;
}

-(NSAttributedString *) getAttributedSubString:(NSString *) string
{
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:string];
    [result addAttribute:NSFontAttributeName value:FONT_REGULAR_14 range:NSMakeRange(0, result.length)];
    [result addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(GBL2) range:NSMakeRange(0, result.length)];
    return result;
}

-(id) initWithIconImg:(UIImage *) icon andMainText:(NSString *) mainText andSubText:(NSString *) subText andButtonText:(NSString *) buttonText andImgSize:(CGSize) img_size
{
    return  [self initWithIconText:nil orIconImage:icon andMainText:mainText andSubAttrText:[self getAttributedSubString:subText] andButtonText:buttonText andImgSize:img_size];
}

-(id) initWithIconImg:(UIImage *) icon andMainText:(NSString *) mainText andSubAttrText:(NSAttributedString *) subText andButtonText:(NSString *) buttonText
{
    return  [self initWithIconText:nil orIconImage:icon andMainText:mainText andSubAttrText:subText andButtonText:buttonText andImgSize:CGSizeZero];
}

-(id) initWithIconText:(NSString *) iconText andMainText:(NSString *) mainText andSubText:(NSString *) subText andButtonText:(NSString *) buttonText
{
    return  [self initWithIconText:iconText orIconImage:nil andMainText:mainText andSubAttrText:[self getAttributedSubString:subText] andButtonText:buttonText andImgSize:CGSizeZero];
}

-(id) initWithIconText:(NSString *) iconText andMainText:(NSString *) mainText andSubAttrText:(NSAttributedString *) subText andButtonText:(NSString *) buttonText
{
    return  [self initWithIconText:iconText orIconImage:nil andMainText:mainText andSubAttrText:subText andButtonText:buttonText andImgSize:CGSizeZero];
}

-(id) initWithIconText:(NSString *) iconText orIconImage:(UIImage *)icon  andMainText:(NSString *) mainText andSubAttrText:(NSAttributedString *) subText andButtonText:(NSString *) buttonText andImgSize:(CGSize) img_size
{
    self = [self init];
    
    if (!CGSizeEqualToSize(img_size, CGSizeZero))
    {
        imgSize = img_size;
    }
    
    if(self)
    {
        TAG = 0;
        
        [self setBackgroundColor:UIColorFromRGB(GBL6)];
        
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [CommonFunction getPhoneWidth], MAIN_HEADER_SEPARATOR_HEIGHT)];
        [topLine setBackgroundColor:UIColorFromRGB(MHS_COLOR)];
        
        if (iconText != nil)
        {
            iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(SIDE_PADDING, [CommonFunction getPhoneHeight]/2-140,[CommonFunction getPhoneWidth]-2*SIDE_PADDING, 100)];
            [iconLabel setText:iconText];
            [iconLabel setFont:FONT_ICON(100)];
            [iconLabel setTextColor:UIColorFromRGB(GBL3)];
            [iconLabel setTextAlignment:NSTextAlignmentCenter];
            [self addSubview:iconLabel];
        }
        else if(icon !=nil)
        {
            iconImg = [[UIImageView alloc] init];
            [iconImg setImage:icon];
            [self addSubview:iconImg];
        }
        
        if (mainText != nil)
        {
            mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(SIDE_PADDING,BOTTOM(iconLabel)+SIDE_PADDING,[CommonFunction getPhoneWidth]-2*SIDE_PADDING, 30)];
            [mainLabel setText:mainText];
            [mainLabel setNumberOfLines:0];
            [mainLabel setFont:FONT_BOLD_16];
            [mainLabel setTextColor:UIColorFromRGB(GBL1)];
            [mainLabel setTextAlignment:NSTextAlignmentCenter];
            [self addSubview:mainLabel];
        }
        
        if (subText != nil)
        {
            subLabel = [[UILabel alloc] initWithFrame:CGRectMake(SIDE_PADDING,BOTTOM(mainLabel),[CommonFunction getPhoneWidth]-2*SIDE_PADDING, 50)];
            [subLabel setAttributedText:subText];
            [subLabel setNumberOfLines:0];
            [subLabel setTextAlignment:NSTextAlignmentCenter];
            [self addSubview:subLabel];
        }
        
        if (buttonText != nil)
        {
            button = [UIButton buttonWithType:UIButtonTypeSystem];
            [[button titleLabel] setFont:FONT_BOLD_16];
            [button setBackgroundColor:UIColorFromRGB(SLING_BLUE)];
            [button setTitle:buttonText forState:UIControlStateNormal];
            [button setTitle:buttonText forState:UIControlStateHighlighted];
            [button setTitleColor:UIColorFromRGB(WHITE_COLOR) forState:UIControlStateNormal];
            [button setTitleColor:UIColorFromRGB(WHITE_COLOR) forState:UIControlStateHighlighted];
            [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            [button setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
            [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
        
        separator = [[UIView alloc] initWithFrame:CGRectMake(0, Y(button), [CommonFunction getPhoneWidth], SEPARATOR_THIN)];
        [separator setBackgroundColor:UIColorFromRGB(SEPARATOR_COLOR)];
        
        [self addSubview:topLine];
        [self addSubview:separator];
        
        CGSize iconLabelSize = iconText?[iconLabel sizeThatFits:CGSizeMake([CommonFunction getPhoneWidth]-4*SIDE_PADDING, MAXFLOAT)]:CGSizeZero;
        CGSize mainLabelSize = mainText?[mainLabel sizeThatFits:CGSizeMake([CommonFunction getPhoneWidth]-4*SIDE_PADDING, MAXFLOAT)]:CGSizeZero;
        CGSize subLabelSize = subText?[subLabel sizeThatFits:CGSizeMake([CommonFunction getPhoneWidth]-4*SIDE_PADDING, MAXFLOAT)]:CGSizeZero;
        
        int remaingHeight = [CommonFunction getPhoneHeight]-STATUS_BAR_HEIGHT_ADDITION -NAVIGATION_BAR_HEIGHT-iconLabelSize.height-mainLabelSize.height- subLabelSize.height -(buttonText?50:0) - (icon ?imgSize.height:0);
        
        if (subText || mainText)
        {
            remaingHeight -= SIDE_PADDING;
        }
        else if(subText && mainText)
        {
            remaingHeight -= SIDE_PADDING/2;
        }
        
        int nextY= remaingHeight/2;
        
        if (iconText)
        {
            [iconLabel setFrame:CGRectMake(2*SIDE_PADDING, nextY,[CommonFunction getPhoneWidth]-4*SIDE_PADDING, iconLabelSize.height)];
            nextY = BOTTOM(iconLabel)+SIDE_PADDING;
        }
        else if(icon)
        {
            [iconImg setFrame:CGRectMake(([CommonFunction getPhoneWidth]-imgSize.width)/2, nextY, imgSize.width, imgSize.height)];
            nextY = BOTTOM(iconImg)+SIDE_PADDING;
        }
        
        if (mainText)
        {
            [mainLabel setFrame:CGRectMake(2*SIDE_PADDING,nextY,[CommonFunction getPhoneWidth]-4*SIDE_PADDING, mainLabelSize.height)];
            nextY = BOTTOM(mainLabel)+SIDE_PADDING/2;
        }
        
        if (subText)
        {
            [subLabel setFrame:CGRectMake(2*SIDE_PADDING,nextY,[CommonFunction getPhoneWidth]-4*SIDE_PADDING,subLabelSize.height)];
            nextY = BOTTOM(subLabel);
        }
        
        if (buttonText)
        {
            [button setFrame:CGRectMake(0, [CommonFunction getPhoneHeight]-NAVIGATION_BAR_HEIGHT-50, [CommonFunction getPhoneWidth], 50)];
        }
        
    }
    return self;
}

-(void) setButtonVisibility:(BOOL) visible
{
    [button setHidden:!visible];
    [separator setHidden:!visible];
}

- (void) buttonClicked
{
    if([delegate respondsToSelector:@selector(noResourceButtonClicked:)])
    {
        if(TAG == NO_RESOURCE_INTERNET_TAG || TAG == NO_RESOURCE_SERVER_TAG)
        {
            if([[AFNetworkReachabilityManager sharedManager] isReachable])
            {
                [delegate noResourceButtonClicked:TAG];
            }
        }
        else
        {
            [delegate noResourceButtonClicked:TAG];
        }
        
    }
}
@end
