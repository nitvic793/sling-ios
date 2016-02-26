//
//  UserApi.h
//  Sling
//
//  Created by Satyam Krishna on 27/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "BaseObject.h"
#import "SlingUser.h"
#import "APIManager.h"

@interface UserApi : BaseObject

-(void) loginWithUser:(SlingUser *) aUser withCompletion:(SimpleErrorCompletionBlock)block;
-(void) signUpWithUser:(SlingUser *) aUser withCompletion:(SimpleErrorCompletionBlock)block;

@end
