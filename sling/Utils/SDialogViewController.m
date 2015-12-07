//
//  GDialogViewController.m
//  grofer-consumer
//
//  Created by Satyam Krishna on 05/06/15.
//  Copyright (c) 2015 GroferIt. All rights reserved.
//

#import "SDialogViewController.h"
#import "AppDelegate.h"

@implementation SDialogViewController
@synthesize backgroundSnapshotView;
@synthesize containerView;
@synthesize closeButton;
@synthesize kbSize;
@synthesize tapGesture;

- (id) init
{
    self = [super init];
    
    if (self)
    {
        [self initializeVariables];
        [self registerForKeyboardNotifications];
        [self setupViews];
    }
    
    return self;
}

-(void) initializeVariables
{
    containerView = [[UIView alloc] init];
    self.containerView = containerView;

    closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.closeButton = closeButton;
}

- (void) createBackgroundSnapshotView
{
    backgroundSnapshotView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, W(self.view), H(self.view))];
    self.backgroundSnapshotView = backgroundSnapshotView;

    [backgroundSnapshotView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.5]];
    [[self view] addSubview:backgroundSnapshotView];
    
    tapGesture = [[UITapGestureRecognizer alloc] init];
    self.tapGesture = tapGesture;
    [tapGesture setNumberOfTapsRequired:1];
    [tapGesture setNumberOfTouchesRequired:1];
    [backgroundSnapshotView setGestureRecognizers:@[tapGesture]];
}

-(void) setupViews
{
    [self createBackgroundSnapshotView];
    
    [[closeButton titleLabel] setFont:FONT_ICON(14)];
    [closeButton setTitle:FONT_ICON_CLOSE forState:UIControlStateNormal];
    [closeButton setTitle:FONT_ICON_CLOSE forState:UIControlStateHighlighted];
    [closeButton setTitleColor:UIColorFromRGB(GBL1) forState:UIControlStateNormal];
    [closeButton setTitleColor:UIColorFromRGB(GBL1) forState:UIControlStateHighlighted];
    [closeButton setContentHorizontalAlignment: UIControlContentHorizontalAlignmentCenter];
    [closeButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    [containerView setBackgroundColor:UIColorFromRGB(WHITE_COLOR)];
    [[containerView layer] setCornerRadius:2];
    [[containerView layer] setMasksToBounds:YES];
    
    [[self view] addSubview:backgroundSnapshotView];
    [[self view] addSubview:containerView];
}

- (void) dismissDialogViewWithCompletionBlock:(DismissDialogCompletionBlock) block
{
    CGPoint endPoint = CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height + self.view.frame.size.height/2);
    
    POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    positionAnimation.toValue = [NSValue valueWithCGPoint:endPoint];
    positionAnimation.duration = 0.5;
    [containerView pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0.0);
    opacityAnimation.duration = 0.3;
    [backgroundSnapshotView.layer pop_addAnimation:opacityAnimation forKey:@"opacity"];
    [opacityAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished)
     {
         [[self view] removeFromSuperview];
         block(anim,finished);
     }];
}

- (void) startAnimating
{
    CGPoint startingPoint = CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height + self.view.frame.size.height/2);
    [containerView setCenter:startingPoint];
    CGPoint endPoint = CGPointMake(self.view.frame.size.width/2,(self.view.frame.size.height-kbSize.height)/2 );
    
    POPSpringAnimation *springPosition = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    springPosition.fromValue = [NSValue valueWithCGPoint:startingPoint];
    springPosition.toValue = [NSValue valueWithCGPoint:endPoint];
    springPosition.springBounciness = 8.0f;
    springPosition.springSpeed = 12.0f;
    [containerView pop_addAnimation:springPosition forKey:@"positionAnimation"];
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(1.0);
    opacityAnimation.fromValue =@(0.0);
    opacityAnimation.duration = 0.3;
    
    [backgroundSnapshotView.layer pop_addAnimation:opacityAnimation forKey:@"opacity"];
    
}

- (void) addToWindow
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[appDelegate window] addSubview:[self view]];
    [self startAnimating];
}

- (void) registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillBeShown:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.kbSize = kbSize;

    if(kbSize.height == 0)
    {
        kbSize.height = DAFAULT_KEYBOARD_HEIGHT;
    }
    
    CGRect rect = containerView.frame;
   // rect.origin.y -= kbSize.height;
    
    if(rect.size.height > [CommonFunction getPhoneHeight]- kbSize.height - 2*SIDE_PADDING)
    {
        rect.size.height -= kbSize.height;
    }
    else
    {
        rect.origin.y -= kbSize.height/2;
    }
    
    [containerView setFrame:rect];
 }

- (void)keyboardWillBeHidden:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    self.kbSize = kbSize;
    
    CGRect rect = containerView.frame;
    rect.size.height += kbSize.height;
   // rect.origin.y += kbSize.height;
    [containerView setFrame:rect];
    //[containerView setFrame:CGRectMake(SIDE_PADDING,SIDE_PADDING, [CommonFunction getPhoneWidth] -2 *SIDE_PADDING, [CommonFunction getPhoneHeight]-2*SIDE_PADDING)];

}

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
