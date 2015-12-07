//
//  GSettingsManager.m
//  grofer-consumer
//
//  Created by Prince Shekhar Valluri on 22/05/15.
//  Copyright (c) 2015 GroferIt. All rights reserved.
//

#import "SettingsManager.h"
#import "Constants.h"

@implementation SettingsManager

+ (SettingsManager *)sharedManager
{
    static SettingsManager *_sharedApiManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
      {
          _sharedApiManager = [[SettingsManager alloc] init];
      });
    
    return _sharedApiManager;
}

- (BOOL)isImagesDisbaled
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([userDefaults boolForKey:DISABLE_IMAGES])
    {
        return [userDefaults boolForKey:DISABLE_IMAGES];
    }
    
    return NO;
}

- (void)setImagesDisabled:(BOOL)disabled
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:disabled forKey:DISABLE_IMAGES];
    [userDefaults synchronize];
}

@end
