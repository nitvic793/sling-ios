//
//  Notification.m
//  grofer-consumer
//
//  Created by Satyam Krishna on 27/02/15.
//  Copyright (c) 2015 GroferIt. All rights reserved.
//

#import "Notification.h"
#import "DBManager.h"

@implementation Notification

@synthesize title;
@synthesize message;
@synthesize shouldOpen;
@synthesize notificationType;
@synthesize unique_id;
@synthesize extra_message;
@synthesize image_url;
@synthesize read;
@synthesize expiry_timestamp;
@synthesize shouldOpenMerchant;
@synthesize landing_page_id;
@synthesize landingPageType;
@synthesize shouldSave;
@synthesize extra_message_json_string =_extra_message_json_string;

-(id) init
{
    self = [super init];
    if(self)
    {
        shouldOpen = NO;
        read = NO;
        notificationType = NotificationTypeNone;
        title = @"";
        message = @"";
        unique_id = [NSNumber numberWithInt:0];
        expiry_timestamp = [NSNumber numberWithLong:0];
        extra_message = @"";
        image_url = @"";
        shouldOpenMerchant = NO;
        landing_page_id = @"-1";
        landingPageType = LandingPageTypeNone;
        _extra_message_json_string =@"";
        shouldSave = NO;
    }
    return self;
}

- (void)setExtra_message_json_string:(NSString *)extra_message_json_string
{
    NSError *jsonError;
    NSData *objectData = [extra_message_json_string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                          error:&jsonError];
    if(jsonError == nil)
    {
        extra_message = [self getStringForKey:@"extra_message" fromDictionary:dic withInitialValue:extra_message];
        landing_page_id = [self getStringForKey:@"landing_page_id" fromDictionary:dic withInitialValue:landing_page_id];
        landingPageType = [[self getNumberForKey: @"landing_page_type" fromDictionary:dic withInitialValue:@(LandingPageTypeNone)] intValue];
        
        _extra_message_json_string = extra_message_json_string;
        
        if([landing_page_id intValue] !=-1)
        {
            shouldOpenMerchant = YES;
        }
    }
    else
    {
        NSLog(@"Got an error: %@", jsonError);
    }
}

-(void) parseObject:(NSDictionary *)responseObject withInitialParams:(NSDictionary *)params
{
    NSMutableDictionary *aps = [responseObject objectForKey:@"aps"];

    NSNumber *type_id = [self getNumberForKey:@"type_id" fromDictionary:responseObject withInitialValue:@(NotificationTypeNone)];
    unique_id = [self getNumberForKey:@"notification_id" fromDictionary:responseObject withInitialValue:unique_id];
    title = [self getStringForKey:@"title" fromDictionary:responseObject withInitialValue:title];
    message = [self getStringForKey:@"alert" fromDictionary:aps withInitialValue:message];
    image_url = [self getStringForKey:@"image_url" fromDictionary:responseObject withInitialValue:image_url];
    expiry_timestamp = [self getNumberForKey:@"expiry_timestamp" fromDictionary:responseObject withInitialValue:expiry_timestamp];
    
    notificationType = [type_id intValue];
    shouldSave = [self getBoolForKey:@"should_save" fromDictionary:responseObject withInitialValue:shouldSave];
    landingPageType = [[self getNumberForKey: @"landing_page_type" fromDictionary:responseObject withInitialValue:@(LandingPageTypeNone)] intValue];
    landing_page_id = [self getStringForKey:@"landing_page_id" fromDictionary:responseObject withInitialValue:landing_page_id];
    
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"landing_page_type",@"landing_page_id", nil];
    NSMutableArray *values = [[NSMutableArray alloc] initWithObjects:@(landingPageType),landing_page_id, nil];
    
    switch (notificationType)
    {
        case NotificationTypeMessage:
            if([landing_page_id intValue] !=-1)
            {
                shouldOpenMerchant = YES;
            }
            break;
        case NotificationTypeOffer:
        {
            extra_message = [self getStringForKey:@"coupon_code" fromDictionary:responseObject withInitialValue:extra_message];
            extra_message = [extra_message uppercaseString];
            
            if([landing_page_id intValue] !=-1)
            {
                shouldOpenMerchant = YES;
            }
            
            [keys addObject:@"extra_message"];
            [values addObject:extra_message];
            
            break;
        }
        case NotificationTypeNone:
            break;
        default:
            break;
    }
    
    NSDictionary * extra_msg_dic = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    
    NSError *error;
    NSData *jsonData =[NSJSONSerialization dataWithJSONObject:extra_msg_dic
                                                      options:NSJSONWritingPrettyPrinted
                                                        error:&error];
    if (error != nil)
    {
        NSLog(@"Got an error: %@", error);
        shouldOpenMerchant = NO;
    }
    else
    {
        _extra_message_json_string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    [self updateOpenStatus];
}

-(void) updateOpenStatus
{
    switch (notificationType)
    {
        case NotificationTypeReferral:
            shouldOpen = YES;
            break;
        case NotificationTypeOffer:
            shouldOpen = YES;
            break;
        case NotificationTypeMessage:
            shouldOpen = YES;
            break;
        case NotificationTypeNone:
            shouldOpen = NO;
            break;
       default:
            break;
    }
}

-(void) saveInstance
{
    
}

-(BOOL) isExpired
{
    double current_time = [[NSDate date] timeIntervalSince1970];
    
    if ([expiry_timestamp doubleValue] != 0 && [expiry_timestamp doubleValue] < current_time)
    {
        return YES;
    }
    
    return NO;
}

-(NSString *) description
{
    return message;
}

@end
