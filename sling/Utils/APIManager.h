//
//  GAPIManager.h
//  grofer-consumer
//
//  Created by Prince Shekhar Valluri on 20/05/15.
//  Copyright (c) 2015 GroferIt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "Constants.h"
#import "NSCustomError.h"

#define AUTH_ERROR_STATUS_CODE 403
#define ACCESS_ERROR_STATUS_CODE 401
#define ERROR_404 404
#define SERVER_ERROR_STATUS_CODE 500

#define REQUEST_METHOD    @"REQUEST_METHOD"
#define REQUEST_URL       @"REQUEST_URL"
#define REQUEST_HEADERS   @"REQUEST_HEADERS"
#define REQUEST_PARAMS    @"REQUEST_PARAMS"
#define REQUEST_BODY      @"REQUEST_BODY"
#define REQUEST_USER      @"REQUEST_USER"
#define REQUEST_AUTHORITY @"REQUEST_AUTHORITY"

@interface APIManager : AFHTTPSessionManager

@property (strong, nonatomic) AFHTTPSessionManager *apiManager;

+ (APIManager *)sharedManager;

+ (NSURL *) baseURLPath;
+ (NSArray *) apiURLs;
+ (NSString *) getCurrentURLTarget;
+ (NSDictionary *) defaultHeaders;

- (NSURLSessionDataTask *)sendOperationForClass:(Class)klass
                                      andMethod:(NSString *)method
                                      andParams:(NSDictionary *)params
                                andSuccessBlock:(GOperationCompletionBlock)successBlock
                                andFailureBlock:(SimpleErrorCompletionBlock)failureBlock;

- (NSURLSessionDataTask *)sendOperationForClass:(Class)klass
                                      andMethod:(NSString *)method
                                      andParams:(NSDictionary *)params
                                      andNewAPi:(BOOL) isNewApi
                                andSuccessBlock:(GOperationCompletionBlock)successBlock
                                andFailureBlock:(SimpleErrorCompletionBlock)failureBlock;


- (NSURLSessionDataTask *)sendOperationForClass:(Class)klass
                                      andMethod:(NSString *)method
                                     andHeaders:(NSDictionary *)headers
                                      andParams:(NSDictionary *)params
                                        andBody:(NSData *)body
                                andSuccessBlock:(GOperationCompletionBlock)successBlock
                                andFailureBlock:(SimpleErrorCompletionBlock)failureBlock;

#pragma mark - Absolute URL ( JSON / HTML )

- (NSURLSessionDataTask *) requestForURL:(NSString*) url
                               withClass:(Class)Klass
                               andMethod:(NSString *)method
                             withHeaders:(NSMutableDictionary *)headers
                          withParameters:(NSDictionary *)params
                                 andBody:(NSData *)postBody
                        withHTMLResponse:(BOOL)isHTMLResponse
                         andSuccessBlock:(GOperationCompletionBlock)successBlock
                         andFailureBlock:(SimpleErrorCompletionBlock)failureBlock;
@end
