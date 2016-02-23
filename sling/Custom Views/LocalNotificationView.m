//
//  LocalNotificationView.m
//  grofer-consumer
//
//  Created by Satyam Krishna on 02/03/15.
//  Copyright (c) 2015 GroferIt. All rights reserved.
//

#import "LocalNotificationView.h"
#import "AppDelegate.h"

#define kCellPadding 15

@implementation LocalNotificationView
{
    UILabel *messageLabel;
    id parent;
    NSDictionary *dictionary;
    UILabel *notificationIcon;
    UIView *barView;
    UIImageView *logoImage;
    
    Notification *notif;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:UIColorFromRGBWithAlpha(NOTIFICATION_COLOR, 0.98f)];
        [self setWindowLevel:UIWindowLevelStatusBar + 1.0f];
        [self setHidden:NO];
        
        //explicitly setting the height of the dropdown
        CGRect orgFrame = self.frame;
        orgFrame.size.height = 69;
        orgFrame.origin.y = -1 * orgFrame.size.height;
        [self setFrame:orgFrame];
        [self setAlpha:1.0];
        
        barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 5)];
        [barView setCenter:CGPointMake(W(self)/2, H(self) - 8)];
        [barView setBackgroundColor:[UIColor whiteColor]];
        [barView setAlpha:0.5];
        barView.layer.cornerRadius = (barView.frame.size.height)/2;
        [barView setClipsToBounds:YES];
        
        [self addSubview:barView];
        
        logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(kCellPadding, 17, 36, 36)];
        //[logoImage setImage:IMG(GROFERS_LOGO)];
        [[logoImage layer] setCornerRadius:1.0f];
        [[logoImage layer] setMasksToBounds:YES];
        
        messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(AFTER(logoImage) + 15, 0, W(self) - (kCellPadding + AFTER(logoImage) + 15), H(self))];
        [messageLabel setTextColor:UIColorFromRGB(WHITE_COLOR)];
        [messageLabel setFont:FONT_REGULAR_12];
        [messageLabel setNumberOfLines:2];
        [messageLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [messageLabel setTextAlignment:NSTextAlignmentLeft];
        [messageLabel setText:@""];
        
        [self addSubview:logoImage];
        [self addSubview:messageLabel];
        
        [self createErrorSwipe];
        [self createClickGesture];
        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(autohide) userInfo:nil repeats:NO];
    }
    return self;
}

-(void) notificationClicked
{
    [self hidebacknotification];
}

- (void)createClickGesture
{
    UITapGestureRecognizer *clickGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(notificationClicked)];
    [clickGesture setNumberOfTapsRequired:1];
    [clickGesture setNumberOfTouchesRequired:1];
    [self addGestureRecognizer:clickGesture];
}


- (void)createErrorSwipe
{
    UIPanGestureRecognizer *hideGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureCallback:)];
    [hideGesture setMaximumNumberOfTouches:1];
    [hideGesture setMinimumNumberOfTouches:1];
    [self addGestureRecognizer:hideGesture];
}

- (void)panGestureCallback:(UIPanGestureRecognizer *)sender
{
    CGPoint newPoint = [sender velocityInView:self];
    
    if (newPoint.y < 0 && ABS(newPoint.x) < ABS(newPoint.y))
    {
        [self hideDropdownNotification];
    }
}

-(void) autohide
{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^
     {
         [self setTransform:CGAffineTransformMakeTranslation(0, 0)];
     }
                     completion:^(BOOL complete)
     {
         notif = nil;
         [messageLabel setText:@""];
         [NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(hideView) userInfo:nil repeats:NO];
     }];
}


- (void)displayDropdownNotificationWithNotification:(Notification *) notification
{
    notif = notification;
    
    [self setHidden:NO];
    
    //Repositioning the message label
    [messageLabel setText:[notification message]];
    CGRect messageFrame = messageLabel.frame;
    messageFrame.origin.x = AFTER(logoImage) + 10;
    messageFrame.size.width = W(self) - (kCellPadding + AFTER(logoImage) + 10);
    [messageLabel setFrame:messageFrame];
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:
     ^{
         [self setTransform:CGAffineTransformMakeTranslation(0, H(self))];
     } completion:nil];
}

- (void)hideDropdownNotification
{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^
    {
        [self setTransform:CGAffineTransformMakeTranslation(0, 0)];
    } completion:^(BOOL complete)
    {
        notif = nil;
        [messageLabel setText:@""];
        [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(hideView) userInfo:nil repeats:NO];
    }];
}

- (void)hidebacknotification
{
    [UIView animateWithDuration:0.2 delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^
    {
        [self setTransform:CGAffineTransformMakeTranslation(0, 0)];
    } completion:^(BOOL complete)
    {
        notif = nil;
        [messageLabel setText:@""];
        [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(hideView) userInfo:nil repeats:NO];
    }];
}

- (void)hideView
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HIDE_LOCAL_NOTIFICATION object:nil];
    [self setHidden:YES];
    [self removeFromSuperview];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
