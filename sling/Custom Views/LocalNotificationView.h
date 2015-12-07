//
//  LocalNotificationView.h
//  grofer-consumer
//
//  Created by Satyam Krishna on 02/03/15.
//  Copyright (c) 2015 GroferIt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notification.h"
#import "CommonFunction.h"

@interface LocalNotificationView : UIWindow

- (id)initWithFrame:(CGRect)frame;
- (void)displayDropdownNotificationWithNotification:(Notification *) notification;
- (void)hideDropdownNotification;
- (void)hidebacknotification;

@end
