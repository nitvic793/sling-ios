//
//  GroferObject.m
//  grofer-consumer
//
//  Created by Satyam Krishna on 07/12/14.
//  Copyright (c) 2014 GroferIt. All rights reserved.
//

#import "BaseObject.h"

@implementation BaseObject

- (BOOL) isObjectWithSameGid : (BaseObject *) gObject;
{
    if(gObject.uuid == Nil || self.uuid == Nil)
    {
        return NO;
    }
    else
    {
        if(gObject.uuid.integerValue == self.uuid.integerValue)
        {
            return YES;
        }
    }
    return NO;
}

-(NSString *) inspect{
    return @"Grofers Object";
}

#pragma Networking Stuff

+ (NSInteger) getRetryCount
{
    return 3;
}

+ (NSString *)getAPIPath
{
    return nil;
}

+ (NSString *) getAPIPathWithParams:(NSDictionary *)params
{
    return nil;
}

- (void) parseObject:(NSDictionary *)responseObject withInitialParams:(NSDictionary *)params
{
    
}

- (NSNumber *) getNumberForKey:(NSString *)key fromDictionary:(NSDictionary *)dictionary withInitialValue:(NSNumber *)initialValue
{
    NSNumber *returnVal = initialValue;
    
    @try
    {
        returnVal = [dictionary valueForKeyPath:key];
    }
    @catch (NSException *exception)
    {
        NSLog(@"catched");
    }
    
    if (returnVal == nil || [returnVal class] == [NSNull class])
    {
        return initialValue;
    }
    else
    {
        if([returnVal isKindOfClass:[NSString class]])
        {
            NSString *tempString = (NSString *)returnVal;
            @try
            {
                returnVal = @([tempString doubleValue]);
            }
            @catch (NSException *exception)
            {
                NSLog(@"catched in get number of key %@", returnVal);
            }
        }
    }
    
    return returnVal;
}

- (NSString *) getStringForKey:(NSString *)key fromDictionary:(NSDictionary *)dictionary withInitialValue:(NSString *)initialValue
{
    NSString *returnVal = initialValue;
    @try
    {
        returnVal = [dictionary valueForKeyPath:key];
    }
    @catch (NSException *exception)
    {
        NSLog(@"catched");
    }
    
    if ([returnVal class] == [NSNull class] ||returnVal == nil)
    {
        return initialValue;
    }
    else
    {
        returnVal = [NSString stringWithFormat:@"%@",returnVal];
    }
    
    return returnVal;
}

- (BOOL) getBoolForKey:(NSString *)key fromDictionary:(NSDictionary *)dictionary withInitialValue:(BOOL)initialValue
{
    BOOL result = initialValue;
    
    NSNumber *isSuccess = [self getNumberForKey:key fromDictionary:dictionary withInitialValue:[NSNumber numberWithBool:initialValue]];
    
    if ([isSuccess class] == [NSNull class] || isSuccess == nil)
    {
        return initialValue;
    }
    else
    {
        if([isSuccess intValue] == 1)
        {
            result = YES;
        }
        else
        {
            result = NO;
        }
    }
    
    return result;
}

@end
