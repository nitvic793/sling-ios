//
//  GroferViewController.h
//  grofer-consumer
//
//  Created by Satyam Krishna on 17/12/14.
//  Copyright (c) 2014 GroferIt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonFunction.h"
#import "UIViewController+ScrollingNavbar.h"

@interface BaseViewController : UIViewController <UIGestureRecognizerDelegate,NoResourceViewDelegate>

@property (nonatomic, strong) NSString *screenName;

-(void) handleError:(NSCustomError *)error;
-(void) hideNoResourceView;

@end
