//
//  UserApi.m
//  Sling
//
//  Created by Satyam Krishna on 27/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "UserApi.h"
#import "CommonFunction.h"

@implementation UserApi
{
    SlingUser *user;
}

#pragma mark - Login Api

-(void) loginWithUser:(SlingUser *) aUser withCompletion:(SimpleErrorCompletionBlock)block
{
    user = aUser;
    NSDictionary *postParams = [self serializeObjectForLogin];
    
    [[APIManager sharedManager] sendOperationForURL:@"/login/"
                                          andMethod:HTTP_POST
                                         andHeaders:nil
                                          andParams:postParams
                                            andBody:nil
                                    andSuccessBlock:^(id responseObject) {
                                        [self parseObjectForLogin:responseObject withInitialParams:postParams];
                                        block(nil);
                                    }
                                    andFailureBlock:^(NSCustomError *error) {
                                        block(error);
                                    }];
}

-(NSDictionary *) serializeObjectForLogin
{
    NSMutableDictionary *requestDict = [[NSMutableDictionary alloc] init];
    [requestDict setObject:[user mobile] forKey:@"phone"];
    [requestDict setObject:[user password] forKey:@"password"];
    return requestDict;
}

-(void) parseObjectForLogin:(NSDictionary *)responseObject withInitialParams:(NSDictionary *)params
{
    SlingUser *sharedUser = [SlingUser sharedUser];
    sharedUser.name = [self getStringForKey:@"name" fromDictionary:responseObject withInitialValue:sharedUser.name];
    sharedUser.mobile = [self getStringForKey:@"phoneNumber" fromDictionary:responseObject withInitialValue:sharedUser.mobile];
    sharedUser.uuid = [self getStringForKey:@"id" fromDictionary:responseObject withInitialValue:sharedUser.uuid];
    [sharedUser saveInstance];
    
    // Login User
    
    NSData *plainData = [[NSString stringWithFormat:@"%@:%@", [user mobile], [user password]] dataUsingEncoding:NSUTF8StringEncoding];
    NSString *encodedUsernameAndPassword = [plainData base64EncodedStringWithOptions:0];
    [CommonFunction setUserAccessToken:[NSString stringWithFormat:@"Basic %@", encodedUsernameAndPassword]];
    [CommonFunction setUserLoggedIn];
}

#pragma mark - Sign Up Api

-(void) signUpWithUser:(SlingUser *) aUser withCompletion:(SimpleErrorCompletionBlock)block
{
    user = aUser;
    NSDictionary *postParams = [self serializeObjectForSignUp];
    
    [[APIManager sharedManager] sendOperationForURL:@"/user/create/"
                                          andMethod:HTTP_POST
                                         andHeaders:nil
                                          andParams:postParams
                                            andBody:nil
                                    andSuccessBlock:^(id responseObject) {
                                        [self parseObjectForSignUp:responseObject withInitialParams:postParams];
                                        block(nil);
                                    }
                                    andFailureBlock:^(NSCustomError *error) {
                                        block(error);
                                    }];
}

-(NSDictionary *) serializeObjectForSignUp
{
    NSMutableDictionary *requestDict = [[NSMutableDictionary alloc] init];
    [requestDict setObject:[user mobile] forKey:@"phone"];
    [requestDict setObject:[user password] forKey:@"password"];
    return requestDict;
}

-(void) parseObjectForSignUp:(NSDictionary *)responseObject withInitialParams:(NSDictionary *)params
{
    SlingUser *sharedUser = [SlingUser sharedUser];
    sharedUser.name = [self getStringForKey:@"name" fromDictionary:responseObject withInitialValue:sharedUser.name];
    sharedUser.mobile = [self getStringForKey:@"phoneNumber" fromDictionary:responseObject withInitialValue:sharedUser.mobile];
    sharedUser.uuid = [self getStringForKey:@"id" fromDictionary:responseObject withInitialValue:sharedUser.uuid];
    [sharedUser saveInstance];
    [CommonFunction setUserLoggedIn];
}

@end
