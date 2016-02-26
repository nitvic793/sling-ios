//
//  SettingsViewController.m
//  Sling
//
//  Created by Satyam Krishna on 24/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingCell.h"

@implementation SettingsViewController
{
    NavigationHeaderView *headerView;
    UITableView *settingsTableView;
}

static NSString * cellIdentifier = @"SettingListCell";

-(id) init
{
    self = [super init];
    if (self)
    {
        [self setupViews];
    }
    return self;
}

-(void) setupViews
{
    [[self view] setBackgroundColor:UIColorFromRGB(LOADING_BG_COLOR)];
    [self createHeader];
    [self createSettingTableView];
}

- (void) createHeader
{
    headerView = [[NavigationHeaderView alloc] initMainHeaderWithParent:self WithTitle:NSLocalizedString(@"SETTINGS", nil) backButtonRequired:NO];
    [[self navigationItem] setBackBarButtonItem:[[UIBarButtonItem alloc]  initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil]];
    [[self navigationItem] setTitleView:headerView];
}

-(void) createSettingTableView
{
    settingsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [CommonFunction getPhoneWidth], H([self view]) - TAB_BAR_HEIGHT)];
    [settingsTableView setDelegate:self];
    [settingsTableView setDataSource:self];
    [settingsTableView setBackgroundColor:UIColorFromRGB(LOADING_BG_COLOR)];
    [settingsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [[self view] addSubview:settingsTableView];
}

#pragma mark - Table View Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, W(tableView), 35)];
    [header setBackgroundColor:UIColorFromRGB(LOADING_BG_COLOR)];
    
    UILabel *heading = [[UILabel alloc] initWithFrame:CGRectMake(SIDE_PADDING, 15, W(header), 20)];
    [heading setFont:FONT_BOLD_14];
    [header addSubview:heading];
    
    switch (section) {
        case 0:
            [heading setText:@"Requests"];
            break;
        case 1:
            [heading setText:@"Account Settings"];
            break;
        case 2:
            [heading setText:@"Feedback"];
            break;
    }
    
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SettingCell cellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 3;
    } else if (section == 2) {
        return 1;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell==nil)
    {
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if ([indexPath section] == 0) {
        switch ([indexPath row]) {
            case 0:
                [cell setText:@"View Class Requests"];
                break;
            case 1:
                [cell setText:@"Send request to join another class"];
                break;
        }
    } else if ([indexPath section] == 1) {
        switch ([indexPath row]) {
            case 0:
                [cell setText:@"Office Hours"];
                break;
            case 1:
                [cell setText:@"Set Office Hours"];
                break;
            case 2:
                [cell setText:@"My Profile"];
                break;
        }
    } else if ([indexPath section] == 2) {
        switch ([indexPath row]) {
            case 0:
                [cell setText:@"Send us Feedback"];
                break;
        }
    }
    
    return cell;
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


@end
