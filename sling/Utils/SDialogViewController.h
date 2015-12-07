//
//  GDialogViewController.h
//  grofer-consumer
//
//  Created by Satyam Krishna on 05/06/15.
//  Copyright (c) 2015 GroferIt. All rights reserved.
//

#import "SlingViewController.h"
#import <pop/POP.h>

typedef void (^DismissDialogCompletionBlock)(POPAnimation *anim, BOOL finished);

@interface SDialogViewController : SlingViewController

@property (nonatomic,strong) UIView *backgroundSnapshotView;
@property (nonatomic,strong) UIButton *closeButton;
@property (nonatomic,strong) UIView *containerView;
@property (nonatomic) CGSize kbSize;
@property (nonatomic) UITapGestureRecognizer *tapGesture;

- (void) addToWindow;
- (void) dismissDialogViewWithCompletionBlock:(DismissDialogCompletionBlock) block;
- (void) keyboardWillBeShown:(NSNotification *)notification;
- (void) keyboardWillBeHidden:(NSNotification *)notification;
- (void) startAnimating;

@end
