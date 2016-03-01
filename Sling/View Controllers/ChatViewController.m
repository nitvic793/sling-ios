//
//  ChatViewController.m
//  Sling
//
//  Created by Satyam Krishna on 24/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "ChatViewController.h"
#import <Quickblox/Quickblox.h>
#import <QMServices.h>

@implementation ChatViewController
{
    NavigationHeaderView *headerView;
}

static int segmentContainerHeight = 50;

#pragma mark - Views Setup

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
    [QBSettings setAccountKey:SLING_CHAT_ACCOUNT_KEY];
}

-(void) setupViews
{
    [self setupChat];
    
    [[self view] setBackgroundColor:UIColorFromRGB(LOADING_BG_COLOR)];
    [self createHeader];
    [self createSegmentView];
}

- (void) createHeader
{
    headerView = [[NavigationHeaderView alloc] initMainHeaderWithParent:self WithTitle:NSLocalizedString(@"CHAT", nil) backButtonRequired:NO];
    [[self navigationItem] setBackBarButtonItem:[[UIBarButtonItem alloc]  initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil]];
    [[self navigationItem] setTitleView:headerView];
}

-(void) createSegmentView
{
    UIView *segmentViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [CommonFunction getPhoneWidth], segmentContainerHeight)];
    [segmentViewContainer setBackgroundColor:UIColorFromRGB(NAV_BAR_COLOR)];
    
    UISegmentedControl *chatSegmentControl = [[UISegmentedControl alloc] initWithItems:@[@"Recent",@"Teachers",@"Parents"]];
    [chatSegmentControl setFrame:CGRectMake((W(segmentViewContainer) - W(chatSegmentControl))/2, 0, W(chatSegmentControl), H(chatSegmentControl))];
    
    [segmentViewContainer addSubview:chatSegmentControl];
    [[self view] addSubview:segmentViewContainer];
}

#pragma mark - Table View setup

#pragma mark - Chat Logic

-(void) setupChat
{
    QBUUser *user = [[QBUUser alloc] init];

    user.email = @"satyamkrishna92@gmail.com";
    user.login = @"satyamkrishna";
    user.password = @"satyamkrishna";
    
    [[QMServicesManager instance] logInWithUser:user completion:^(BOOL success, NSString *errorMessage) {
        NSLog(@"%@",errorMessage);
    }];
}











@end
