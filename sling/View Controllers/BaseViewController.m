//
//  GroferViewController.m
//  grofer-consumer
//
//  Created by Satyam Krishna on 17/12/14.
//  Copyright (c) 2014 GroferIt. All rights reserved.
//

#import "BaseViewController.h"
#import "Constants.h"
#import "AppDelegate.h"

@implementation BaseViewController
{
    NoResourceView *nrv;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

-(void) hideNoResourceView
{
    [nrv setHidden:YES];
}

-(void) handleError:(NSCustomError *)error
{
    if([SVProgressHUD isVisible])
    {
        [SVProgressHUD dismiss];
    }
    
    if ([error isCancelError])
    {
        
    }
    else if([error noInternet])
    {
        nrv = [CommonFunction noInternetResourceViewWithFrame:NO_RESOURCE_FRAME andDelegate:self];
        [[self view] addSubview:nrv];
        [nrv setHidden:NO];
    }
    else// if([error isServerError])
    {
        nrv = [CommonFunction noServerResourceViewWithFrame:NO_RESOURCE_FRAME andDelegate:self];
        [[self view] addSubview:nrv];
        [nrv setHidden:NO];
    }
}

@end
