//
//  CommonFunction.h
//  grofer-consumer
//
//  Created by Satyam Krishna on 07/12/14.
//  Copyright (c) 2014 GroferIt. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>
#import "NavigationHeaderView.h"
#import "FontIconMapping.h"
#import "SVProgressHUD.h"
#import <UIKit/UIKit.h>
#import "RavenClient.h"
#import "Appirater.h"
#import "DBManager.h"
#import "Constants.h"
#import "SlingUser.h"
#import "UIImageView+CommonFunction.h"
#import "APIManager.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define UIVIEW_HEIGHT(v)                            v.frame.size.height
#define UIVIEW_WIDTH(v)                             v.frame.size.width
#define UIVIEW_X(v)                                 v.frame.origin.x
#define UIVIEW_Y(v)                                 v.frame.origin.y

#define X(v)                                        v.frame.origin.x
#define Y(v)                                        v.frame.origin.y
#define H(v)                                        v.frame.size.height
#define W(v)                                        v.frame.size.width
#define BOTTOM(v)                                   (v.frame.origin.y + v.frame.size.height)
#define AFTER(v)                                    (v.frame.origin.x + v.frame.size.width)
#define CENTER_X(v)                                 v.center.x
#define CENTER_Y(v)                                 v.center.y
#define IMG(p)                                      [UIImage imageNamed:[NSString stringWithFormat: @"%@", p]]

#define ADD_HEIGHT_TO_VIEW_Y(view,y) [view setFrame:CGRectMake(X(view),Y(view)+y,W(view),H(view))];
#define UPDATE_FRAME_HEIGHT(view,h) [view setFrame:CGRectMake(X(view),Y(view),W(view),h)];
#define SET_VIEW_TO_CENTER(view,container) [view setFrame:CGRectMake((W(container)-W(view))/2,(H(container)-H(view))/2,W(view),H(view))];

typedef NS_ENUM(NSUInteger, iPhone) {
    iPhone4,
    iPhone5,
    iPhone6,
    iPhone6Plus
};

@interface CommonFunction : NSObject

+ (void) printMethodTrace;

+ (void) setupRemoteNotifications;

+ (UIColor *) getRandomColor;

+ (int)getRandomNumberBetween:(int)from to:(int)to;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color withWidth:(CGFloat)width andHeight:(CGFloat)height;

+ (UIImage *)imageWithColor:(UIColor *)color andOpacity:(CGFloat)alpha;

+ (UIImage *)imageWithColor:(UIColor *)color withWidth:(CGFloat)width andHeight:(CGFloat)height andAlpha:(CGFloat)alpha;

+ (UIColor *) colorFromHexString:(NSString *)hexString ;

+ (NSMutableString *)getFormattedDate:(NSString *)date andInDateFormat:(NSString *)informat andOutDateFormat:(NSString *)outformat;

+ (NSString *)getStringFromDefaultDateFormat:(NSString *)dateStringFromApi ForFormat:(NSString *)requiredDateFormat;

+ (NSString *)getStringFromDate:(NSDate *)date ForFormat:(NSString *)requiredDateFormat;

+ (NSString *)getTimeStringFromMilitary:(NSNumber *) timeNumber;

+ (NSString *)getWeekDayFromIndex:(NSNumber *) weekday;

+ (BOOL)checkIfString:(NSString*)string contains:(NSString *) other;

+ (NSString *)getAmountStringFor:(NSNumber *) amount;

+ (NSString *) getAmountStringWithSignsFor:(NSNumber *) amount;

+ (void) openAppStore;

+ (NSString*) getQueryStringFromDictionary: (NSDictionary *) dictionary;

#pragma mark - NSUserDefaults

+ (void) setUserLoggedIn;

+ (void) setUserLoggedOut;

+ (BOOL) isUserLoggedIn;

+ (void) logOutUser;


#pragma mark - UIViewController

+ (UINavigationController *) getNavigationControllerForViewController:(UIViewController *)viewController;

+ (UIViewController *) getLoginViewController;
// Home Tabs
+ (UIViewController *) getHomeTabViewController;
+ (UIViewController *) getChatViewController;
+ (UIViewController *) getNoticeBoardViewController;
+ (UIViewController *) getReviewViewController;
+ (UIViewController *) getSettingsViewController;

#pragma mark -  UIVIEWS

+ (void)shake:(UIView *)view withShakes:(int)shakes inDirection:(float)direction;
+ (void)addCardShadowToLayer:(CALayer *)layer;
+ (void)addStrongShadowToLayer:(CALayer *)layer;
+ (void)addTopShadowToLayer:(CALayer *)layer;
+ (void)addBottomShadowToLayer:(CALayer *)layer;
+ (void)label:(UILabel *)label animateTextChange:(NSString *)text withInterval:(CGFloat)interval withCompletion:(void (^)(void))completionBlock;
+ (void)label:(UILabel *)label animateAttributedTextChange:(NSAttributedString *)text withInterval:(CGFloat)interval withCompletion:(void (^)(void))completionBlock;
+ (void)label:(UILabel *)label animateTextChange:(NSString *)text withCompletion:(void (^)(void))completionBlock;
+ (void)label:(UILabel *)label animateAttributedTextChange:(NSAttributedString *)text withCompletion:(void (^)(void))completionBlock;
+ (void)addDiagonalLineToView:(UIView *)view withColor:(UIColor *)color withThickness:(double)thickness withViewFrame:(CGRect) frame;
+ (void)fadeView:(UIView *)view;

#pragma mark - Size Related

+(NSString *) deviceType;
+ (CGFloat) getPhoneWidth;
+ (CGFloat) getPhoneHeight;
+ (BOOL) isIOS7;
+ (BOOL) isIOS8;
+ (BOOL) isIOS9;
+ (iPhone) getIphoneType;
+ (CGFloat) isiPhone4;
+ (CGFloat) isiPhone5;
+ (CGFloat) isiPhone6;
+ (CGFloat) isiPhone6Plus;

#pragma mark - Location Related

+ (BOOL) isLocationPermissionAuthorized;
+ (BOOL) isLocationPermissionNotDetermined;
+ (BOOL) validateEmail:(NSString *) email;
+ (void) crashApp;
+ (BOOL) canMakeCall;

@end
