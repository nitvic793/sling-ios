//
//  GroferObject.h
//  grofer-consumer
//
//  Created by Satyam Krishna on 07/12/14.
//  Copyright (c) 2014 GroferIt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImagePrefetcher.h"

@interface BaseObject : NSObject

@property (nonatomic, strong) NSString* uuid;

- (BOOL) isObjectWithSameGid : (BaseObject *) gObject;


+ (NSInteger) getRetryCount;
+ (NSString *) getAPIPath;
+ (NSString *) getAPIPathWithParams:(NSDictionary *)params;

- (void) parseObject:(NSDictionary *)responseObject withInitialParams:(NSDictionary *)params;
- (NSString *) getStringForKey:(NSString *)key fromDictionary:(NSDictionary *)dictionary withInitialValue:(NSString *)initialValue;
- (NSNumber *) getNumberForKey:(NSString *)key fromDictionary:(NSDictionary *)dictionary withInitialValue:(NSNumber *)initialValue;
- (BOOL) getBoolForKey:(NSString *)key fromDictionary:(NSDictionary *)dictionary withInitialValue:(BOOL)initialValue;

@end
