//
//  SlingUser.h
//  Sling
//
//  Created by Satyam Krishna on 23/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "BaseObject.h"

@interface SlingUser : BaseObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *deviceToken;

+ (SlingUser *) sharedUser;
- (void) saveInstance;
- (void) deleteInstance;

@end
