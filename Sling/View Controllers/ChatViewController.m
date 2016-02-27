//
//  ChatViewController.m
//  Sling
//
//  Created by Satyam Krishna on 24/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "ChatViewController.h"
#import <Quickblox/Quickblox.h>

@implementation ChatViewController
{
    NavigationHeaderView *headerView;
}

-(id) init
{
    self = [super init];
    if (self)
    {
        [self initalizeVariables];
        [self setupViews];
    }
    return self;
}

- (void) initalizeVariables
{
    [QBSettings setApplicationID:SLING_CHAT_APPLICATION_ID];
    [QBSettings setAuthKey:SLING_CHAT_AUTH_KEY];
    [QBSettings setAuthSecret:SLING_CHAT_AUTH_SECRET];
}

-(void) setupViews
{
    [[self view] setBackgroundColor:UIColorFromRGB(LOADING_BG_COLOR)];
    [self createHeader];
}

- (void) createHeader
{
    headerView = [[NavigationHeaderView alloc] initMainHeaderWithParent:self WithTitle:NSLocalizedString(@"CHAT", nil) backButtonRequired:NO];
    [[self navigationItem] setBackBarButtonItem:[[UIBarButtonItem alloc]  initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil]];
    [[self navigationItem] setTitleView:headerView];
}

@end
