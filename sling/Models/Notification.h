//
//  Notification.h
//  grofer-consumer
//
//  Created by Satyam Krishna on 27/02/15.
//  Copyright (c) 2015 GroferIt. All rights reserved.
//

#import "SlingObject.h"

typedef NS_ENUM(NSUInteger, NotificationType)
{
    NotificationTypeOffer = 7,
    NotificationTypeMessage = 9,
    NotificationTypeReferral = 10,
    NotificationTypeNone
};

typedef NS_ENUM(NSUInteger, LandingPageType)
{
    LandingPageTypeNotificationCenter = 1,
    LandingPageTypeOrderHistory = 2,
    LandingPageTypeOrderHistoryDetail = 3,
    LandingPageTypeFeedback = 4,
    LandingPageTypeCart = 5,
    LandingPageTypeMerchant = 6,
    LandingPageTypeSearch = 7,
    LandingPageTypeCategory = 8,
    LandingPageTypeHome = 9,
    LandingPageTypeNone
};

@interface Notification : SlingObject

@property (nonatomic,strong) NSNumber *unique_id;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSString *extra_message;
@property (nonatomic,strong) NSString *image_url;
@property (nonatomic,strong) NSNumber *expiry_timestamp;
@property (nonatomic,strong) NSString *landing_page_id;
@property (nonatomic,strong) NSString *extra_message_json_string;
@property (nonatomic) BOOL shouldOpenMerchant;
@property (nonatomic) BOOL shouldOpen;
@property (nonatomic) BOOL shouldSave;
@property (nonatomic) BOOL read;

@property (nonatomic) NotificationType notificationType;
@property (nonatomic) LandingPageType landingPageType;

-(void) updateOpenStatus;
-(void) saveInstance;
-(BOOL) isExpired;

@end
