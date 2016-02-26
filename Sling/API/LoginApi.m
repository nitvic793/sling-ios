//
//  LoginApi.m
//  Sling
//
//  Created by Satyam Krishna on 26/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "LoginApi.h"
#import "CommonFunction.h"

@implementation LoginApi
{
    SlingUser *user;
}

-(void) loginWithUser:(SlingUser *) aUser withCompletion:(SimpleErrorCompletionBlock)block
{
    user = aUser;
    NSDictionary *postParams = [self serializeObject];
    
    [[APIManager sharedManager] sendOperationForURL:@"/login/"
                                          andMethod:HTTP_POST
                                         andHeaders:nil
                                          andParams:postParams
                                            andBody:nil
                                    andSuccessBlock:^(id responseObject) {
                                        [self parseObject:responseObject withInitialParams:postParams];
                                        block(nil);
                                    }
                                    andFailureBlock:^(NSCustomError *error) {
                                        block(error);
                                    }];
}

-(NSDictionary *) serializeObject
{
    NSMutableDictionary *requestDict = [[NSMutableDictionary alloc] init];
    [requestDict setObject:[user mobile] forKey:@"phone"];
    [requestDict setObject:[user password] forKey:@"password"];
    return requestDict;
}

-(void) parseObject:(NSDictionary *)responseObject withInitialParams:(NSDictionary *)params
{
    SlingUser *sharedUser = [SlingUser sharedUser];
    sharedUser.name = [self getStringForKey:@"name" fromDictionary:responseObject withInitialValue:sharedUser.name];
    sharedUser.mobile = [self getStringForKey:@"phoneNumber" fromDictionary:responseObject withInitialValue:sharedUser.mobile];
    sharedUser.uuid = [self getStringForKey:@"id" fromDictionary:responseObject withInitialValue:sharedUser.uuid];
    [sharedUser saveInstance];
    [CommonFunction setUserLoggedIn];
}

@end
