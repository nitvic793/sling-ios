//
//  LoginViewController.m
//  Sling
//
//  Created by Prince S. Valluri on 1/20/16.
//  Copyright © 2016 Sling. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginApi.h"

#define LOGO_WIDTH 100.0
#define LOGO_HEIGHT 50.0
#define TEXT_FIELD_WIDTH 250.0
#define TEXT_FIELD_HEIGHT 40.0
#define BUTTON_WIDTH 100.0
//#define BUTTON_HEIGHT 50.0

@interface LoginViewController () {
    UITextField *usernameField;
    UITextField *passwordField;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self view] setBackgroundColor:UIColorFromRGB(NAV_BAR_COLOR)];
    
    // for iPhone4
//    [self.navigationController setNavigationBarHidden:YES];
    
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(CENTER_X(self.view) - LOGO_WIDTH/2, 2 * SIDE_PADDING, LOGO_WIDTH, LOGO_HEIGHT)];
    [logoView setImage:[UIImage imageNamed:@"PLACEHOLDER_LOGO"]];
    [logoView setBackgroundColor:[UIColor blackColor]];
    
    usernameField = [[UITextField alloc] initWithFrame:CGRectMake(CENTER_X(self.view) - TEXT_FIELD_WIDTH/2, BOTTOM(logoView) + 2 * SIDE_PADDING, TEXT_FIELD_WIDTH, TEXT_FIELD_HEIGHT)];
    [usernameField setBackgroundColor:UIColorFromRGB(GBL6)];
    [usernameField.layer setCornerRadius:CORNER_RADIUS_SMALL];
    [usernameField setPlaceholder:@"Username"];
    [usernameField setTextAlignment:NSTextAlignmentCenter];
    
    passwordField = [[UITextField alloc] initWithFrame:CGRectMake(CENTER_X(self.view) - TEXT_FIELD_WIDTH/2, BOTTOM(usernameField) + SIDE_PADDING, TEXT_FIELD_WIDTH, TEXT_FIELD_HEIGHT)];
    [passwordField setBackgroundColor:UIColorFromRGB(GBL6)];
    [passwordField.layer setCornerRadius:CORNER_RADIUS_SMALL];
    [passwordField setPlaceholder:@"Password"];
    [passwordField setSecureTextEntry:YES];
    [passwordField setTextAlignment:NSTextAlignmentCenter];
    
    UIButton *continueButton = [[UIButton alloc] initWithFrame:CGRectMake(CENTER_X(self.view) - BUTTON_WIDTH/2, BOTTOM(passwordField) + 2 * SIDE_PADDING, BUTTON_WIDTH, BUTTON_HEIGHT)];
    [continueButton.layer setBorderColor:UIColorFromRGB(WHITE_COLOR).CGColor];
    [continueButton.layer setBorderWidth:1.0];
    [continueButton.layer setCornerRadius:CORNER_RADIUS_SMALL];
    [continueButton setTitle:@"Continue" forState:UIControlStateNormal];
    [continueButton.titleLabel setTextColor:UIColorFromRGB(WHITE_COLOR)];
    [continueButton setBackgroundColor:[UIColor clearColor]];
    [continueButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:logoView];
    [self.view addSubview:usernameField];
    [self.view addSubview:passwordField];
    [self.view addSubview:continueButton];
}

- (void) loginButtonClicked:(id)sender {
    [SVProgressHUD show];
    
    SlingUser *user = [[SlingUser alloc] init];
    [user setMobile:[usernameField text]];
    [user setPassword:[passwordField text]];
    [SVProgressHUD show];
    LoginApi *loginApi = [[LoginApi alloc] init];
    [loginApi loginWithUser:user withCompletion:^(NSCustomError *error) {
        if (error) {
        
        } else {
            
        }
    }];
}

-(BOOL) prefersStatusBarHidden
{
    return YES;
}

@end
