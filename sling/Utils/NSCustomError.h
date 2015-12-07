//
//  NSCustomError.h
//  grofer-consumer
//
//  Created by Satyam Krishna on 17/02/15.
//  Copyright (c) 2015 GroferIt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCustomError : NSError

@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSString *statusCode;

-(id) initWith404Error;
-(id) initWithRequestSuccessFalseErrorWithStatusCode:(NSString *) aStatusCode andMessage:(NSString *) aMessage;
-(id) initWithError:(NSError *) error;
-(id) initWithServerError;

-(BOOL) is404Error;
-(BOOL) noInternet;
-(BOOL) isServerError;
-(BOOL) retakeNumber;
-(BOOL) isRequestError;
-(BOOL) isCancelError;


@end
