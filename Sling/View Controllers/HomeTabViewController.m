//
//  HomeTabViewController.m
//  Sling
//
//  Created by Satyam Krishna on 24/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "HomeTabViewController.h"

@implementation HomeTabViewController
{
    NSMutableArray *vcArray;
}

-(id) init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupTabBarExperience];
    [self setDelegate:self];
}

-(void)setupTabBarExperience
{
    [self setViewControllers:nil];
    vcArray = [[NSMutableArray alloc] initWithArray:@[
                                                      [CommonFunction getNoticeBoardViewController],
                                                      [CommonFunction getChatViewController],
                                                      [CommonFunction getReviewViewController],
                                                      [CommonFunction getSettingsViewController]
                                                    ]];
    [self setViewControllers:vcArray];
    [self setSelectedIndex:0];
    
    [self.tabBar setFrame:CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y, self.tabBar.frame.size.width, 49)];
    [self.tabBar setTranslucent:NO];
    [self.tabBar setTintColor:UIColorFromRGB(GBL8)];
    
    [(UITabBarItem *)[self.tabBar.items objectAtIndex:0] setTitle:NSLocalizedString(@"NOTICE_BOARD", nil)];
    [(UITabBarItem *)[self.tabBar.items objectAtIndex:1] setTitle:NSLocalizedString(@"CHAT", nil)];
    [(UITabBarItem *)[self.tabBar.items objectAtIndex:2] setTitle:NSLocalizedString(@"STUDENT_REVIEWS", nil)];
    [(UITabBarItem *)[self.tabBar.items objectAtIndex:3] setTitle:NSLocalizedString(@"SETTINGS", nil)];
    
}

@end
