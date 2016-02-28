//
//  Notice.m
//  Sling
//
//  Created by Satyam Krishna on 27/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "Notice.h"

@implementation Notice

@synthesize classRoom;
@synthesize uuid;
@synthesize title;
@synthesize message;

-(id) init
{
    self = [super init];
    if (self) {
        classRoom = [[ClassRoom alloc] init];
        uuid = @"";
        title = @"Should come from backend";
        message = @"";
    }
    return self;
}

-(void) parseObject:(NSDictionary *)responseObject withInitialParams:(NSDictionary *)params
{
    [classRoom parseObject:[responseObject objectForKey:@"classRoom"] withInitialParams:params];
    
    uuid = [self getStringForKey:@"id" fromDictionary:responseObject withInitialValue:uuid];
    title = [self getStringForKey:@"title" fromDictionary:responseObject withInitialValue:title];
    message = [self getStringForKey:@"notice" fromDictionary:responseObject withInitialValue:message];
}

@end
