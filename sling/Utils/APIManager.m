//
//  GAPIManager.m
//  grofer-consumer
//
//  Created by Prince Shekhar Valluri on 20/05/15.
//  Copyright (c) 2015 GroferIt. All rights reserved.
//

#import "APIManager.h"
#import "Constants.h"
#import "BaseObject.h"
#import "CommonFunction.h"

typedef void (^AFResponseBlock)(NSURLResponse *response, id responseObject, NSError *error);

@implementation APIManager

+ (APIManager *)sharedManager
{
    static APIManager *_sharedApiManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
      {
          _sharedApiManager = [[APIManager alloc] init];
          _sharedApiManager.apiManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[APIManager baseURLPath]];
          
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
    NSMutableDictionary *headerDict = [[NSMutableDictionary alloc] init];
    
    if([CommonFunction isUserLoggedIn] && [[CommonFunction getUserAccessToken] length] > 0)
    {
        [headerDict setObject:[CommonFunction getUserAccessToken] forKey:API_USER_ACCESS_TOKEN];
    }
    
    [headerDict setObject:@"consumer_ios" forKey:@"app_client"];
    [headerDict setObject:[NSString stringWithFormat:@"%d",VERSION_NUMBER] forKey:@"app_version"];
    [headerDict setObject:@"gzip" forKey:@"Accept-Encoding"];
    [headerDict setObject:[[UIDevice currentDevice] systemVersion] forKey:@"device_os"];
    
    switch ([CommonFunction getIphoneType])
    {
        case iPhone4:
        case iPhone5:
            [headerDict setObject:@"2x" forKey:@"screen_density"];
            break;
        case iPhone6:
            [headerDict setObject:@"2.5x" forKey:@"screen_density"];
            break;
        case iPhone6Plus:
            [headerDict setObject:@"3x" forKey:@"screen_density"];
            break;
        default:
            [headerDict setObject:@"3x" forKey:@"screen_density"];
            break;
    }
    
    return headerDict;
}

- (NSURLSessionDataTask *)sendOperationForURL:(NSString *) apiPath
                                    andMethod:(NSString *)method
                                   andHeaders:(NSDictionary *)headers
                                    andParams:(NSDictionary *)params
                                      andBody:(NSData *)body
                              andSuccessBlock:(GOperationCompletionBlock)successBlock
                              andFailureBlock:(SimpleErrorCompletionBlock)failureBlock;
{
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
    //avoiding request params to keep a strong reference of the objects of the params dictionary
    [requestParams addEntriesFromDictionary:[self copyParamsFromDictionary:params]];
    
    AFResponseBlock requestPostBlock = ^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSInteger statusCode = 0;
            NSHTTPURLResponse *httpResponse = [[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey];
            if (httpResponse) {
                statusCode = [httpResponse statusCode];
            }
            
            failureBlock([[NSCustomError alloc] initWithError:error]);
        } else {
            successBlock(responseObject);
        }
    };
   
    NSString *api_url = [[NSURL URLWithString:apiPath relativeToURL:[APIManager baseURLPath]] absoluteString];
    NSMutableURLRequest *request = [self.apiManager.requestSerializer requestWithMethod:method URLString:api_url parameters:requestParams error:nil];
    
    if(body) {
        [request setHTTPBody:body];
    }
    
    NSURLSessionDataTask *task = [[self apiManager] dataTaskWithRequest:request completionHandler:requestPostBlock];
    [task resume];
    
    NSLog(@"%@",[[NSURL URLWithString:apiPath relativeToURL:[APIManager baseURLPath]] absoluteString]);
    
    return task;
}

#pragma mark - Absolute URL ( JSON / HTML )

- (NSURLSessionDataTask *)requestForURL:(NSString*) url
                              withClass:(Class)Klass
                              andMethod:(NSString *)method
                            withHeaders:(NSMutableDictionary *)headers
                         withParameters:(NSDictionary *)params
                                andBody:(NSData *)postBody
                       withHTMLResponse:(BOOL)isHTMLResponse
                        andSuccessBlock:(GOperationCompletionBlock)successBlock
                        andFailureBlock:(SimpleErrorCompletionBlock)failureBlock
{
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
    //avoiding request params to keep a strong reference of the objects of the params dictionary
    [requestParams addEntriesFromDictionary:[self copyParamsFromDictionary:params]];
    
    AFResponseBlock requestPostBlock = ^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            failureBlock([[NSCustomError alloc] initWithError:error]);
        } else {
            successBlock(responseObject);
        }
    };
    
    AFHTTPSessionManager *apiManager = [self getCustomApiManager:url withHeaders:headers withHTMLResponse:isHTMLResponse];
    
    NSMutableURLRequest *request = [apiManager.requestSerializer requestWithMethod:method URLString:url parameters:requestParams error:nil];
    
    if(postBody) {
        [request setHTTPBody:postBody];
    }
    
    NSURLSessionDataTask *task = [apiManager dataTaskWithRequest:request completionHandler:requestPostBlock];
    [task resume];
    
    NSLog(@"request URL: %@",url);
    
    return task;
}

- (AFHTTPSessionManager *)getCustomApiManager:(NSString *) url
                                  withHeaders:(NSMutableDictionary *) headers
                             withHTMLResponse:(BOOL) isHTMLResponse
{
    AFHTTPSessionManager *apiManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
    
    if (isHTMLResponse) {
        NSMutableSet *contentSet = [[NSMutableSet alloc] initWithSet:[[apiManager responseSerializer] acceptableContentTypes]];
        [contentSet addObject:@"text/html"];
        [contentSet addObject:@"text/plain"];
        [[apiManager responseSerializer] setAcceptableContentTypes:contentSet];
    }
    
    for (id key in [headers allKeys]) {
        [[apiManager requestSerializer] setValue:[headers objectForKey:key] forHTTPHeaderField:key];
    }
    
    return apiManager;
}

#pragma mark - AFHTTPRequestOperationDelegate

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
        [[APIManager getCurrentURLTarget] isEqualToString:API_STAGE_URL])
    {
        URLComponent.scheme = @"https";
    }
    else
    {
        URLComponent.scheme = @"http";
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
    return @[API_STAGE_URL, API_LIVE_URL];
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
