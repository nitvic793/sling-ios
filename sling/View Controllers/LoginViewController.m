//
//  LoginViewController.m
//  Sling
//
//  Created by Prince S. Valluri on 1/20/16.
//  Copyright © 2016 Sling. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self view] setBackgroundColor:UIColorFromRGB(NAV_BAR_COLOR)];
}

-(BOOL) prefersStatusBarHidden
{
    return YES;
}

@end
