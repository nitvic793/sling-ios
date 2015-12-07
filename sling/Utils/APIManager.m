//
//  GAPIManager.m
//  grofer-consumer
//
//  Created by Prince Shekhar Valluri on 20/05/15.
//  Copyright (c) 2015 GroferIt. All rights reserved.
//

#import "APIManager.h"
#import "Constants.h"
#import "SlingObject.h"
#import "CommonFunction.h"

typedef void (^AFSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^AFFailureBlock)(AFHTTPRequestOperation *operation, NSError *error);

@implementation APIManager

+ (APIManager *)sharedManager
{
    static APIManager *_sharedApiManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
      {
          _sharedApiManager = [[APIManager alloc] init];
          _sharedApiManager.apiManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[APIManager baseURLPath]];
          NSDictionary *headersDictionary = [APIManager defaultHeaders];
          for (id key in [headersDictionary allKeys])
          {
              [_sharedApiManager.apiManager.requestSerializer setValue:[headersDictionary objectForKey:key] forHTTPHeaderField:key];
          }
          
          [[AFNetworkReachabilityManager sharedManager] startMonitoring];
      });
    
    return _sharedApiManager;
}

+ (NSDictionary *) defaultHeaders
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:@"consumer_ios" forKey:@"app_client"];
    [dic setObject:[NSString stringWithFormat:@"%d",VERSION_NUMBER] forKey:@"app_version"];
    [dic setObject:@"gzip" forKey:@"Accept-Encoding"];
    [dic setObject:[[UIDevice currentDevice] systemVersion] forKey:@"device_os"];
    
    switch ([CommonFunction getIphoneType])
    {
        case iPhone4:
        case iPhone5:
            [dic setObject:@"2x" forKey:@"screen_density"];
            break;
        case iPhone6:
            [dic setObject:@"2.5x" forKey:@"screen_density"];
            break;
        case iPhone6Plus:
            [dic setObject:@"3x" forKey:@"screen_density"];
            break;
        default:
            [dic setObject:@"3x" forKey:@"screen_density"];
            break;
    }
    
    return dic;
}

- (void)sendGetWithStart:(NSInteger)start
{
    [self sendOperationForClass:nil andMethod:HTTP_GET andHeaders:nil andParams:nil andBody:nil andSuccessBlock:nil andFailureBlock:nil];
}


- (void)sendOperationForClass:(Class)klass
                    andMethod:(NSString *)method
                    andParams:(NSDictionary *)params
              andSuccessBlock:(GOperationCompletionBlock)successBlock
              andFailureBlock:(SimpleErrorCompletionBlock)failureBlock
{
    [self sendOperationForClass:klass andMethod:method andHeaders:nil andParams:params andBody:nil andNewAPi:NO andSuccessBlock:successBlock andFailureBlock:failureBlock];
}

- (void)sendOperationForClass:(Class)klass
                    andMethod:(NSString *)method
                    andParams:(NSDictionary *)params
                    andNewAPi:(BOOL) isNewApi
              andSuccessBlock:(GOperationCompletionBlock)successBlock
              andFailureBlock:(SimpleErrorCompletionBlock)failureBlock
{
    [self sendOperationForClass:klass andMethod:method andHeaders:nil andParams:params andBody:nil andNewAPi:isNewApi andSuccessBlock:successBlock andFailureBlock:failureBlock];
}

- (void)sendOperationForClass:(Class)klass
                   andMethod:(NSString *)method
                  andHeaders:(NSDictionary *)headers
                   andParams:(NSDictionary *)params
                     andBody:(NSData *)body
             andSuccessBlock:(GOperationCompletionBlock)successBlock
             andFailureBlock:(SimpleErrorCompletionBlock)failureBlock
{
    [self sendOperationForClass:klass andMethod:method andHeaders:headers andParams:params andBody:body andNewAPi:NO andSuccessBlock:successBlock andFailureBlock:failureBlock];
}

- (void)sendOperationForClass:(Class)klass
                    andMethod:(NSString *)method
                   andHeaders:(NSDictionary *)headers
                    andParams:(NSDictionary *)params
                      andBody:(NSData *)body
                    andNewAPi:(BOOL) isNewApi
              andSuccessBlock:(GOperationCompletionBlock)successBlock
              andFailureBlock:(SimpleErrorCompletionBlock)failureBlock;
{
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
    //avoiding request params to keep a strong reference of the objects of the params dictionary
    [requestParams addEntriesFromDictionary:[self copyParamsFromDictionary:params]];
    
    AFSuccessBlock requestSuccess = ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if(isNewApi)
        {
            successBlock(operation, responseObject);
        }
        else
        {
            NSNumber *isSuccess = [responseObject valueForKey:@"success"];
            
            if([isSuccess intValue] == 1)
            {
                successBlock(operation, responseObject);
            }
            else
            {
                // Log success false in Sentry
                NSString *message = [responseObject objectForKey:@"message"];
                NSMutableDictionary *additonalDict = [self apiDictToLogWithClass:klass WithParameters:params];
                [additonalDict setValue:method forKey:REQUEST_METHOD];
                [CommonFunction logApiwith:message additionalExtra:additonalDict];
                
                failureBlock([[NSCustomError alloc] initWithRequestSuccessFalseErrorWithStatusCode:@"" andMessage:message]);
            }
        }
    };
    
    AFFailureBlock requestFailure = ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        
    };
    
    //sending access token and client id by post
    NSMutableDictionary *accessTokenDict = [[NSMutableDictionary alloc] init];
    
    //modifying url path
    NSString *apiPath = [klass getAPIPathWithParams:requestParams];
    
    AFHTTPRequestOperation *requestOperation;
    
    if ([method isEqualToString:HTTP_GET])
    {
        NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithDictionary:accessTokenDict];
        [params addEntriesFromDictionary:requestParams];
        
        requestOperation = [[self apiManager] GET:apiPath parameters:params success:requestSuccess failure:requestFailure];
    }
    else if ([method isEqualToString:HTTP_POST] || [method isEqualToString:HTTP_PUT])
    {
        NSString *api_url = [[NSURL URLWithString:apiPath relativeToURL:[APIManager baseURLPath]] absoluteString];
        NSMutableURLRequest *request = [self.apiManager.requestSerializer requestWithMethod:method URLString:api_url parameters:requestParams error:nil];
        
        if(body)
        {
            [request setHTTPBody:body];
        }
        
        requestOperation = [self HTTPRequestOperationWithRequest:request success:requestSuccess failure:requestFailure];
        [[[self apiManager] operationQueue] addOperation:requestOperation];
    }
    else if ([method isEqualToString:HTTP_DELETE])
    {
        requestOperation = [[self apiManager] DELETE:apiPath parameters:accessTokenDict success:requestSuccess failure:requestFailure];
    }
    
    [requestOperation setQueuePriority:NSOperationQueuePriorityHigh];
    
    //log request
    if(SLING_DEBUG)
    {
        NSLog(@"%@",requestOperation.request.URL);
        NSLog(@"request body: %@",accessTokenDict);
    }
}

- (void) cancelAllRequestsForClass:(Class)klass
{
    NSString *matchString = [klass getAPIPath];

    for (NSOperation *operation in [self.apiManager.operationQueue operations])
    {
        if (![operation isKindOfClass:[AFHTTPRequestOperation class]])
        {
            continue;
        }
        
        NSURLRequest *request = [(AFHTTPRequestOperation *)operation request];
        NSString *queryString = request.URL.absoluteString;
        
        @try {
            if([queryString rangeOfString:matchString].location != NSNotFound)
            {
                if (![operation isCancelled])
                {
                    [operation cancel];
                }
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
     
    }
}

- (void) requestForURL:(NSString*) url
             withClass:(Class)Klass
             andMethod:(NSString *)method
           withHeaders:(NSMutableDictionary *)headers
        withParameters:(NSDictionary *)params
               andBody:(NSData *)postBody
       andSuccessBlock:(GOperationCompletionBlock)successBlock
       andFailureBlock:(SimpleErrorCompletionBlock)failureBlock
{
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
    //avoiding request params to keep a strong reference of the objects of the params dictionary
    [requestParams addEntriesFromDictionary:[self copyParamsFromDictionary:params]];
    
    AFSuccessBlock requestSuccess = ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        successBlock(operation, responseObject);
    };
    
    AFFailureBlock requestFailure = ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        failureBlock([[NSCustomError alloc] initWithError:error]);
    };
    
    AFHTTPRequestOperationManager *apiManager = [self getCustomApiManager:url withHeaders:headers withHTMLResponse:NO];
    AFHTTPRequestOperation *requestOperation;
    
    if ([method isEqualToString:HTTP_GET])
    {
        requestOperation = [apiManager GET:url parameters:params success:requestSuccess failure:requestFailure];
    }
    else if ([method isEqualToString:HTTP_POST])
    {
        NSMutableURLRequest *request = [apiManager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:requestParams error:nil];
        
        if(postBody)
        {
            [request setHTTPBody:postBody];
        }
        
        requestOperation = [apiManager HTTPRequestOperationWithRequest:request success:requestSuccess failure:requestFailure];
    }
    else
    {
        NSLog(@"unsupported method for absolute URL");
    }
    
    [requestOperation setQueuePriority:NSOperationQueuePriorityHigh];
    NSLog(@"request URL: %@",requestOperation.request.URL);
}

- (void) requestForURLWithHTMLResponse:(NSString *)url
                             withClass:(Class)Klass
                             andMethod:(NSString *)method
                           withHeaders:(NSMutableDictionary *)headers
                        withParameters:(NSDictionary *)params
                               andBody:(NSData *)postBody
                       andSuccessBlock:(GOperationCompletionBlock)successBlock
                       andFailureBlock:(SimpleErrorCompletionBlock)failureBlock
{
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
    //avoiding request params to keep a strong reference of the objects of the params dictionary
    [requestParams addEntriesFromDictionary:[self copyParamsFromDictionary:params]];
    
    AFSuccessBlock requestSuccess = ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        successBlock(operation, responseObject);
    };
    
    AFFailureBlock requestFailure = ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        failureBlock([[NSCustomError alloc] initWithError:error]);
    };
    
    AFHTTPRequestOperationManager *apiManager = [self getCustomApiManager:url withHeaders:headers withHTMLResponse:YES];
    AFHTTPRequestOperation *requestOperation;
    
    if ([method isEqualToString:HTTP_GET])
    {
        requestOperation = [apiManager GET:url parameters:params success:requestSuccess failure:requestFailure];
    }
    else if ([method isEqualToString:HTTP_POST])
    {
        NSMutableURLRequest *request = [apiManager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:requestParams error:nil];
        
        if(postBody)
        {
            [request setHTTPBody:postBody];
        }
        
        requestOperation = [apiManager HTTPRequestOperationWithRequest:request success:requestSuccess failure:requestFailure];
        [requestOperation setQueuePriority:NSOperationQueuePriorityHigh];
        
        [[apiManager operationQueue] addOperation:requestOperation];
    }
    else
    {
        NSLog(@"unsupported method for absolute URL");
    }
    
    NSLog(@"request URL: %@",requestOperation.request.URL);
}

- (AFHTTPRequestOperationManager *)getCustomApiManager:(NSString *) url
                                           withHeaders:(NSMutableDictionary *) headers
                                      withHTMLResponse:(BOOL) isHTMLResponse
{
    AFHTTPRequestOperationManager *apiManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
    
    if (isHTMLResponse)
    {
        NSMutableSet *contentSet = [[NSMutableSet alloc] initWithSet:[[apiManager responseSerializer] acceptableContentTypes]];
        [contentSet addObject:@"text/html"];
        [contentSet addObject:@"text/plain"];
        [[apiManager responseSerializer] setAcceptableContentTypes:contentSet];
    }
    
    for (id key in [headers allKeys])
    {
        [[apiManager requestSerializer] setValue:[headers objectForKey:key] forHTTPHeaderField:key];
    }
    
    return apiManager;
}

#pragma mark AFHTTPRequestOperationDelegate

- (NSString *)getAPIPath:(NSString *)apiPath WithQureyString:(NSString *)queryString
{
    if([apiPath rangeOfString:@"?"].location == NSNotFound)
    {
        apiPath = [apiPath stringByAppendingFormat:@"?%@", queryString];
    }
    else
    {
        apiPath = [apiPath stringByAppendingFormat:@"&%@", queryString];
    }
    return apiPath;
}

- (NSMutableDictionary *)apiDictToLogWithClass:(Class)Klass WithParameters:(NSDictionary *)params
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    // URL
    //modifying url path
    NSString *apiPath = [Klass getAPIPathWithParams:params];
    NSString *queryString = [CommonFunction getQueryStringFromDictionary:params];
    apiPath = [self getAPIPath:apiPath WithQureyString:queryString];
    
    [dict setValue:apiPath forKey:REQUEST_URL];
    [dict setValue:[APIManager getCurrentURLTarget] forKey:REQUEST_AUTHORITY];
    [dict setValue:[APIManager defaultHeaders] forKey:REQUEST_HEADERS];
    
    return dict;
}

- (NSDictionary *)copyParamsFromDictionary:(NSDictionary *)params
{
    NSMutableDictionary *deepCopy = [[NSMutableDictionary alloc] init];
    for (NSString *key in [params allKeys])
    {
        [deepCopy setObject:[params objectForKey:key] forKey:key];
    }
    return deepCopy;
}

// URL SWITCHING

+ (NSURL *)baseURLPath
{
    NSURLComponents *URLComponent = [[NSURLComponents alloc] init];
    
    [URLComponent setHost:[APIManager getCurrentURLTarget]];
    [URLComponent setPath:@"/"];
    
    if ([[APIManager getCurrentURLTarget] isEqualToString:API_LIVE_URL] ||
        [[APIManager getCurrentURLTarget] isEqualToString:API_STAGE_URL] ||
        [[APIManager getCurrentURLTarget] isEqualToString:API_POST_CHECKOUT_URL]
        )
    {
        URLComponent.scheme = @"https";
    }
    else
    {
        URLComponent.scheme = @"http";
    }
    
    // Override for local api
    
    if ([[APIManager getCurrentURLTarget] isEqualToString:API_LOCAL_URL])
    {
        [URLComponent setScheme:@"http"];
        [URLComponent setPort:@(8000)];
    }
    
    return [URLComponent URL];
}

+ (NSString *) getCurrentURLTarget
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:URL_TARGET])
    {
        return [[NSUserDefaults standardUserDefaults] objectForKey:URL_TARGET];
    }
    
    return [APIManager defaultURL];
}

+ (NSArray *) apiURLs
{
    return @[@"pre.grofer.it", @"ref.grofer.it", API_STAGE_URL, @"stage.grofer.it", API_LIVE_URL, @"api.grofer.it",API_POST_CHECKOUT_URL];
}

+ (NSString *) defaultURL
{
    if(SLING_DEBUG)
    {
        return API_STAGE_URL;
    }
    return API_LIVE_URL;
}

@end
