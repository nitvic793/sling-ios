//
//  GSettingsManager.h
//  grofer-consumer
//
//  Created by Prince Shekhar Valluri on 22/05/15.
//  Copyright (c) 2015 GroferIt. All rights reserved.
//

#import "BaseObject.h"

@interface SettingsManager : BaseObject

+ (SettingsManager *)sharedManager;

- (BOOL)isImagesDisbaled;
- (void)setImagesDisabled:(BOOL)disabled;
@end
