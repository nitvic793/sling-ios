
//
//  SlingUser.m
//  Sling
//
//  Created by Satyam Krishna on 23/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "SlingUser.h"
#import "Constants.h"


@implementation SlingUser

@synthesize gid;
@synthesize name;
@synthesize email;
@synthesize mobile;
@synthesize deviceToken;


+ (SlingUser *) sharedUser
{
    NSData *encodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:SLING_USER];
    SlingUser *user =  [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    
    if(!user)
        user = [[SlingUser alloc] init];
    
    return user;
}

- (void) saveInstance
{
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:SLING_USER];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) deleteInstance
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SLING_USER];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(instancetype) init
{
    self = [super init];
    if (self)
    {
        name             = @"";
        mobile           = @"";
        email            = @"";
        deviceToken      = @"";
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if(self)
    {
        gid         = [decoder decodeObjectForKey:@"user_id"];
        name        = [decoder decodeObjectForKey:@"user_name"];
        mobile      = [decoder decodeObjectForKey:@"user_mobile"];
        email       = [decoder decodeObjectForKey:@"user_email"];
        deviceToken = [decoder decodeObjectForKey:@"device_token"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:gid forKey:@"user_id"];
    [encoder encodeObject:name forKey:@"user_name"];
    [encoder encodeObject:mobile forKey:@"user_mobile"];
    [encoder encodeObject:email forKey:@"user_email"];
    [encoder encodeObject:deviceToken forKey:@"device_token"];
}

@end
