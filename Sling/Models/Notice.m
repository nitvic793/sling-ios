//
//  Notice.m
//  Sling
//
//  Created by Satyam Krishna on 27/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "Notice.h"

@implementation Notice

@synthesize uuid;

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
}

@end
