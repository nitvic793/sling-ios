//
//  ClassRoom.m
//  Sling
//
//  Created by Satyam Krishna on 27/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "ClassRoom.h"

@implementation ClassRoom

@synthesize uuid;
@synthesize room;
@synthesize subject;
@synthesize teacher;

-(id) init
{
    self = [super init];
    if (self) {
        uuid = @"";
    }
    return self;
}

-(void) parseObject:(NSDictionary *)responseObject withInitialParams:(NSDictionary *)params
{
    uuid = [self getStringForKey:@"id" fromDictionary:responseObject withInitialValue:uuid];
    room = [self getStringForKey:@"room" fromDictionary:responseObject withInitialValue:room];
    subject = [self getStringForKey:@"subject" fromDictionary:responseObject withInitialValue:subject];
}

@end
