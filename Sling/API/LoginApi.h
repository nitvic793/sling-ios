//
//  LoginApi.h
//  Sling
//
//  Created by Satyam Krishna on 26/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "BaseObject.h"
#import "SlingUser.h"
#import "APIManager.h"

@interface LoginApi : BaseObject

-(void) loginWithUser:(SlingUser *) aUser withCompletion:(SimpleErrorCompletionBlock)block;

@end
