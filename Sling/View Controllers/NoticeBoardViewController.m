//
//  NoticeBoardViewController.m
//  Sling
//
//  Created by Satyam Krishna on 24/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "NoticeBoardViewController.h"
#import "NoticeBoardApi.h"

@implementation NoticeBoardViewController
{
    NavigationHeaderView *headerView;
    NoticeBoardApi *noticeBoardApi;
    BOOL areNoticesLoaded;
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
    areNoticesLoaded = NO;
}

-(void) setupViews
{
    [[self view] setBackgroundColor:UIColorFromRGB(LOADING_BG_COLOR)];
    [self createHeader];
}

- (void) createHeader
{
    headerView = [[NavigationHeaderView alloc] initMainHeaderWithParent:self WithTitle:NSLocalizedString(@"NOTICE_BOARD", nil) backButtonRequired:NO];
    [[self navigationItem] setBackBarButtonItem:[[UIBarButtonItem alloc]  initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil]];
    [[self navigationItem] setTitleView:headerView];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self makeAPICall];
}

#pragma mark - No Resource Delegate

-(void) makeAPICall
{
    if (!areNoticesLoaded) {
        if (!noticeBoardApi) {
            noticeBoardApi = [[NoticeBoardApi alloc] init];
            [noticeBoardApi fetchAllNoticesWithCompletion:^(NSCustomError *error) {
                if (error) {
                    [self handleError:error];
                } else {
                    
                }
            }];
        }
    }
}

#pragma mark - No Resource Delegate

-(void) noResourceButtonClicked:(NSUInteger)tag
{
    if(tag == NO_RESOURCE_INTERNET_TAG || tag == NO_RESOURCE_SERVER_TAG)
    {
        [self makeAPICall];
    }
}

@end
