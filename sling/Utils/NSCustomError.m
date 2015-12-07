//
//  NSCustomError.m
//  grofer-consumer
//
//  Created by Satyam Krishna on 17/02/15.
//  Copyright (c) 2015 GroferIt. All rights reserved.
//

#import "NSCustomError.h"
#import "CommonFunction.h"

@implementation NSCustomError
{
    BOOL internet_error;
    BOOL server_error;
    BOOL access_token_error;
    BOOL error_404;
    BOOL request_error;
    BOOL cancel_error;
}

@synthesize message;
@synthesize statusCode;

-(id) initWithError:(NSError *) error
{
    NSString *domain = @"";
    NSInteger code = 0;
    NSDictionary *userInfo = [[NSDictionary alloc] init];
    
    if (error)
    {
        if ([error domain])
            domain = [error domain];
        
        if ([error code])
            code = [error code];
        
        if ([error userInfo])
            userInfo = [error userInfo];
    }
    
    self = [super initWithDomain:domain code:code userInfo:userInfo];
    
    if(self)
    {
        [self initalizeVariable];
        
        if(code == kCFURLErrorNotConnectedToInternet || code == kCFURLErrorTimedOut || code == kCFURLErrorNetworkConnectionLost || code == kCFURLErrorCannotFindHost)
        {
            server_error   = NO;
            internet_error = YES;
        }
        
        if(code == kCFURLErrorBadServerResponse)
        {
            server_error = YES;
        }
        
        if(server_error && error)
        {
            [CommonFunction logApiwithError:error];
        }
        
        if (code == kCFURLErrorCancelled)
        {
            cancel_error = YES;
        }
    }
    return self;
}

-(void) initalizeVariable
{
    access_token_error = NO;
    server_error       = YES;
    internet_error     = NO;
    error_404          = NO;
    request_error      = NO;
    cancel_error       = NO;
    
    message    = @"";
    statusCode = @"";
}


-(id) initWith404Error
{
    self = [self initWithError:nil];
    if(self)
    {
        error_404    = YES;
        server_error = NO;
    }
    return self;
}

-(id) initWithRequestSuccessFalseErrorWithStatusCode:(NSString *) aStatusCode andMessage:(NSString *) aMessage
{
    self = [self initWithError:nil];
    if(self)
    {
        [self initalizeVariable];
        
        server_error   = NO;
        request_error  = YES;
        
        statusCode = aStatusCode;
        message    = aMessage;
    }
    return self;
}

-(id) initWithServerError
{
    self = [self initWithError:nil];
    if (self)
    {
        [self initalizeVariable];
    }
    return self;
}

-(BOOL) noInternet
{
    return internet_error;
}

-(BOOL) isServerError
{
    return server_error;
}

-(BOOL) is404Error
{
    return error_404;
}

-(BOOL) retakeNumber
{
    return access_token_error;
}

-(BOOL) isRequestError
{
    return request_error;
}

-(BOOL) isCancelError
{
    return cancel_error;
}
@end
