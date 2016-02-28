//
//  NoticeBoardViewController.m
//  Sling
//
//  Created by Satyam Krishna on 24/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "NoticeBoardViewController.h"
#import "NoticeBoardApi.h"
#import "NoticeCell.h"

@implementation NoticeBoardViewController
{
    NavigationHeaderView *headerView;
    NoticeBoardApi *noticeBoardApi;
    UITableView *noticeBoardTableView;
    NSMutableArray *notices;
    BOOL areNoticesLoaded;
}

static NSString * cellIdentifier = @"NoticeListCell";

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
    notices = [NSMutableArray array];
}

-(void) setupViews
{
    [[self view] setBackgroundColor:UIColorFromRGB(LOADING_BG_COLOR)];
    [self createHeader];
    [self createNoticeBoardTableView];
}

-(void) createHeader
{
    headerView = [[NavigationHeaderView alloc] initMainHeaderWithParent:self WithTitle:NSLocalizedString(@"NOTICE_BOARD", nil) backButtonRequired:NO];
    [[self navigationItem] setBackBarButtonItem:[[UIBarButtonItem alloc]  initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil]];
    [[self navigationItem] setTitleView:headerView];
}

-(void) createNoticeBoardTableView
{
    noticeBoardTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [CommonFunction getPhoneWidth], H([self view]) - TAB_BAR_HEIGHT)];
    [noticeBoardTableView setDelegate:self];
    [noticeBoardTableView setDataSource:self];
    [noticeBoardTableView setBackgroundColor:UIColorFromRGB(LOADING_BG_COLOR)];
    [noticeBoardTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [[self view] addSubview:noticeBoardTableView];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self makeAPICall];
}

#pragma mark - Table View Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, W(tableView), 0)];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] < [notices count]) {
        Notice *notice = [notices objectAtIndex:[indexPath row]];
        return [NoticeCell cellHeightForNotice:notice];
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [notices count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] < [notices count]) {
        Notice *notice = [notices objectAtIndex:[indexPath row]];
        NoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if(cell==nil) {
            cell = [[NoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        [cell updateCellForNotice:notice];
        
        return cell;
    }
    
    return [[STableViewCell alloc] init];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
    {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark - No Resource Delegate

-(void) makeAPICall
{
    if (!areNoticesLoaded) {
        [SVProgressHUD show];
        if (!noticeBoardApi) {
            noticeBoardApi = [[NoticeBoardApi alloc] init];
            [noticeBoardApi fetchAllNoticesWithCompletion:^(NSCustomError *error) {
                [SVProgressHUD dismiss];
                if (error) {
                    [self handleError:error];
                } else {
                    [notices removeAllObjects];
                    [notices addObjectsFromArray:[noticeBoardApi notices]];
                    [noticeBoardTableView reloadData];
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
