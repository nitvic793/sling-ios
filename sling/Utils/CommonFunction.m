
////////////////////////////////////
//  CommonFunction.m
//  grofer-consumer
//
//  Created by Satyam Krishna on 07/12/14.
//  Copyright (c) 2014 GroferIt. All rights reserved.
//

#import "CommonFunction.h"
#import <sys/utsname.h>
#import "APIManager.h"

#import "LoginViewController.h"

#import "HomeTabViewController.h"
#import "ChatViewController.h"
#import "NoticeBoardViewController.h"
#import "ReviewViewController.h"
#import "SettingsViewController.h"

@implementation CommonFunction

+(void) printMethodTrace
{
    NSString *sourceString = [[NSThread callStackSymbols] objectAtIndex:1];
    NSCharacterSet *separatorSet = [NSCharacterSet characterSetWithCharactersInString:@" -[]+?.,"];
    NSMutableArray *array = [NSMutableArray arrayWithArray:[sourceString  componentsSeparatedByCharactersInSet:separatorSet]];
    [array removeObject:@""];
    
    NSLog(@"Stack = %@", [array objectAtIndex:0]);
    NSLog(@"Framework = %@", [array objectAtIndex:1]);
    NSLog(@"Memory address = %@", [array objectAtIndex:2]);
    NSLog(@"Class caller = %@", [array objectAtIndex:3]);
    NSLog(@"Function caller = %@", [array objectAtIndex:4]);
    NSLog(@"Line caller = %@", [array objectAtIndex:5]);
}

+(void) setupRemoteNotifications
{
    if ([CommonFunction isIOS8] || [CommonFunction isIOS9] )
    {
        UIUserNotificationType types = UIUserNotificationTypeBadge |UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *mySettings =[UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert];
    }
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [self imageWithColor:color withWidth:1.0f andHeight:1.0f];
}

+ (UIImage *)imageWithColor:(UIColor *)color withWidth:(CGFloat)width andHeight:(CGFloat)height
{
    return [self imageWithColor:color withWidth:width andHeight:height andAlpha:1];
}

+ (UIImage *)imageWithColor:(UIColor *)color andOpacity:(CGFloat)alpha
{
    return [self imageWithColor:color withWidth:1 andHeight:1 andAlpha:alpha];
}

+ (UIImage *)imageWithColor:(UIColor *)color withWidth:(CGFloat)width andHeight:(CGFloat)height andAlpha:(CGFloat)alpha
{
    
    CGFloat r, g, b, a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, width, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetAlpha(context, alpha);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(UIColor *) getRandomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

+(int)getRandomNumberBetween:(int)from to:(int)to
{
    return (int)from + arc4random() % (to-from+1);
}

+ (UIColor *) colorFromHexString:(NSString *)hexString
{
    if ([hexString length]>0)
    {
        @try {
            unsigned rgbValue = 0;
            NSScanner *scanner = [NSScanner scannerWithString:hexString];
            [scanner setScanLocation:1]; // bypass '#' character
            [scanner scanHexInt:&rgbValue];
            return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
            
        }
        @catch (NSException *exception) {
            return [UIColor blackColor];
        }

    }
    
    return [UIColor blackColor];

}

+(NSMutableString *)getFormattedDate:(NSString *)date andInDateFormat:(NSString *)informat andOutDateFormat:(NSString *)outformat
{
    NSArray* myDate = [date  componentsSeparatedByString:@" "];
    
    NSString* dateStamp = [myDate objectAtIndex:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:informat];
    NSDate *dateFromString = [dateFormatter dateFromString:dateStamp];
    [dateFormatter setDateFormat:outformat] ;
    NSMutableString *InDate = (NSMutableString *)[dateFormatter stringFromDate:dateFromString];
    
    return InDate;
}

+(NSString *)getStringFromDefaultDateFormat:(NSString *)dateStringFromApi ForFormat:(NSString *)requiredDateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:DEFAULT_DATE_FORMAT];
    NSDate *date = [dateFormatter dateFromString:dateStringFromApi];
    [dateFormatter setDateFormat:requiredDateFormat];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Kolkata"]];
    return [dateFormatter stringFromDate:date];
}

+(NSString *)getStringFromDate:(NSDate *)date ForFormat:(NSString *)requiredDateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setAMSymbol:@"AM"];
    [dateFormatter setPMSymbol:@"PM"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Kolkata"]];
    [dateFormatter setDateFormat:requiredDateFormat];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)getTimeStringFromMilitary:(NSNumber *) timeNumber
{
    int time = [timeNumber intValue];
    
    int hour = time / 100;
    int min = time % 100;
    
    NSString *am_pm;
    
    
    if (hour >= 12)
    {
        hour = hour - 12;
        am_pm = NSLocalizedString(@"PM", nil);
    }
    else
    {
        am_pm = NSLocalizedString(@"AM", nil);
    }
  
    if (hour == 0)
    {
        hour = 12;
    }

    return [[NSString stringWithFormat:@"%2d:%02d %@",hour,min,am_pm] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (NSString *)getWeekDayFromIndex:(NSNumber *) weekday
{
    switch ([weekday intValue])
    {
        case 0:
            return NSLocalizedString(@"SUN", nil);
            break;
        case 1:
            return NSLocalizedString(@"MON", nil);
            break;
        case 2:
            return NSLocalizedString(@"TUE", nil);
            break;
        case 3:
            return NSLocalizedString(@"WED", nil);
            break;
        case 4:
            return NSLocalizedString(@"THU", nil);
            break;
        case 5:
            return NSLocalizedString(@"FRI", nil);
            break;
        case 6:
            return NSLocalizedString(@"SAT", nil);
            break;
        case 7:
            return NSLocalizedString(@"TODAY", nil);
            break;
        case 8:
            return NSLocalizedString(@"TOMORROW", nil);
            break;
        case 9:
            return NSLocalizedString(@"DAY_AFTER", nil);
            break;
        default:
            return @"";
            break;
    }
    return @"";
}


+ (BOOL) checkIfString:(NSString*)string contains:(NSString *) other
{
    NSRange range = [string rangeOfString:other];
    return range.length != 0;
}

+(NSString *) getAmountStringFor:(NSNumber *) amount
{
    if ([amount doubleValue]==0)
    {
        return [NSString stringWithFormat:@"%@0",FONT_ICON_RUPEE];
    }
    else if ([amount doubleValue]>0)
    {
        return [NSString stringWithFormat:@"%@%@",FONT_ICON_RUPEE,[amount stringValue]];
    }
    else
    {
        return [NSString stringWithFormat:@"-%@%@",FONT_ICON_RUPEE,[@(-amount.doubleValue) stringValue]];
    }
}

+(NSString *) getAmountStringWithSignsFor:(NSNumber *) amount
{
    if ([amount doubleValue]==0)
    {
        return [NSString stringWithFormat:@"%@0",FONT_ICON_RUPEE];
    }
    else if ([amount doubleValue]>0)
    {
        return [NSString stringWithFormat:@"+ %@%@",FONT_ICON_RUPEE,[amount stringValue]];
    }
    else
    {
        return [NSString stringWithFormat:@"- %@%@",FONT_ICON_RUPEE,[@(-amount.doubleValue) stringValue]];
    }
}

+ (NSString*) getQueryStringFromDictionary: (NSDictionary *) dictionary
{
    NSMutableArray *parts = [NSMutableArray array];
    
    for (id key in dictionary)
    {
        id value = [dictionary objectForKey: key];
        NSString *part = [NSString stringWithFormat: @"%@=%@", urlEncode(key), urlEncode(value)];
        [parts addObject: part];
    }
    
    return [parts componentsJoinedByString: @"&"];
}

static NSString *toString(id object)
{
    return [NSString stringWithFormat: @"%@", object];
}


static NSString *urlEncode(id object)
{
    NSString *string = toString(object);
    return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

+(void) openAppStore
{
    NSString *iTunesLink = @"https://itunes.apple.com/us/app/apple-store/id960335206";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
}

#pragma mark - NSUserDefaults

+ (void) setUserLoggedIn
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:USER_LOGGED_IN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_LOGGED_IN object:nil];
}

+ (void) setUserLoggedOut
{
    //[CommonFunction deleteGroferUser];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:USER_LOGGED_IN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_LOGGED_OUT object:nil];
}

+ (BOOL) isUserLoggedIn
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:USER_LOGGED_IN];
}

+ (void) logOutUser
{
    // Save Device Token For Next Login
    //NSString *deviceToken = [[GroferUser sharedUser] deviceToken];
    
    //[CommonFunction deleteGroferUser];
    [CommonFunction setUserLoggedOut];
}


#pragma mark - UIViewControllers

+ (UIViewController *) getLoginViewController
{
    LoginViewController *controller = [[LoginViewController alloc] init];
    return [CommonFunction getNavigationControllerForViewController:controller];
}

// Home Tabs

+ (UIViewController *) getHomeTabViewController
{
    HomeTabViewController *hvc = [[HomeTabViewController alloc] init];
    return [CommonFunction getNavigationControllerForViewController:hvc];
}

+ (UIViewController *) getChatViewController
{
    ChatViewController *cvc = [[ChatViewController alloc] init];
    return cvc;
}

+ (UIViewController *) getNoticeBoardViewController
{
    NoticeBoardViewController *nvc = [[NoticeBoardViewController alloc] init];
    return nvc;
}

+ (UIViewController *) getReviewViewController
{
    ReviewViewController *rvc = [[ReviewViewController alloc] init];
    return rvc;
}

+ (UIViewController *) getSettingsViewController
{
    SettingsViewController *svc = [[SettingsViewController alloc] init];
    return svc;
}


#pragma mark -  Navigation Controller

+ (UINavigationController *) getNavigationControllerForViewController:(UIViewController*) vc
{
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [navigationController setNavigationBarHidden:NO];
    [[navigationController navigationBar] setTintColor:UIColorFromRGB(WHITE_COLOR)];
    [[navigationController navigationBar] setBarTintColor:UIColorFromRGB(NAV_BAR_COLOR)];
    [[navigationController navigationBar] setBarStyle:UIBarStyleBlack];
    [[navigationController navigationBar] setTranslucent:NO];
    [[navigationController navigationBar] setBackgroundImage:[CommonFunction imageWithColor:UIColorFromRGB(NAV_BAR_COLOR)] forBarMetrics:UIBarMetricsDefault];
    [[navigationController navigationBar] setShadowImage:[[UIImage alloc] init]];
    [[navigationController navigationBar] setBackIndicatorImage:IMG(@"back_arrow.png")];
    
    return navigationController;
}

#pragma mark - Size Related

+(NSString*) deviceName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+ (CGFloat) getPhoneWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat) getPhoneHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

+ (iPhone) getIphoneType
{
    if ([CommonFunction isiPhone4])
    {
        return iPhone4;
    }
    else if ([CommonFunction isiPhone5])
    {
        return iPhone5;
    }
    else if ([CommonFunction isiPhone6])
    {
        return iPhone6;
    }
    else
    {
        return iPhone6Plus;
    }
}
+ (CGFloat) isiPhone4
{
    if([UIScreen mainScreen].bounds.size.height == 480)
    {
        return YES;
    }
    return NO;
}

+ (CGFloat) isiPhone5
{
    if([UIScreen mainScreen].bounds.size.height == 568)
    {
        return YES;
    }
    return NO;
}

+ (CGFloat) isiPhone6
{
    if([UIScreen mainScreen].bounds.size.height == 667)
    {
        return YES;
    }
    return NO;
}

+ (CGFloat) isiPhone6Plus
{
    if([UIScreen mainScreen].bounds.size.height == 736)
    {
        return YES;
    }
    return NO;
}

+ (BOOL) isIOS7
{
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0") && SYSTEM_VERSION_LESS_THAN(@"8.0"))
        return YES;
    return NO;
}

+ (BOOL) isIOS8
{
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0") && SYSTEM_VERSION_LESS_THAN(@"9.0"))
        return YES;
    return NO;
}

+ (BOOL) isIOS9
{
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
        return YES;
    return NO;
}

+(NSString*) deviceType
{
    struct utsname systemInfo;

    uname(&systemInfo);

    NSString* code = [NSString stringWithCString:systemInfo.machine
    encoding:NSUTF8StringEncoding];

    static NSDictionary* deviceNamesByCode = nil;

    if (!deviceNamesByCode)
    {
        deviceNamesByCode = @{
                              @"i386"      :@"Simulator",
                              @"iPod1,1"   :@"iPod Touch",      // (Original)
                              @"iPod2,1"   :@"iPod Touch",      // (Second Generation)
                              @"iPod3,1"   :@"iPod Touch",      // (Third Generation)
                              @"iPod4,1"   :@"iPod Touch",      // (Fourth Generation)
                              @"iPhone1,1" :@"iPhone",          // (Original)
                              @"iPhone1,2" :@"iPhone",          // (3G)
                              @"iPhone2,1" :@"iPhone",          // (3GS)
                              @"iPad1,1"   :@"iPad",            // (Original)
                              @"iPad2,1"   :@"iPad 2",          //
                              @"iPad3,1"   :@"iPad",            // (3rd Generation)
                              @"iPhone3,1" :@"iPhone 4",        // (GSM)
                              @"iPhone3,3" :@"iPhone 4",        // (CDMA/Verizon/Sprint)
                              @"iPhone4,1" :@"iPhone 4S",       //
                              @"iPhone5,1" :@"iPhone 5",        // (model A1428, AT&T/Canada)
                              @"iPhone5,2" :@"iPhone 5",        // (model A1429, everything else)
                              @"iPad3,4"   :@"iPad",            // (4th Generation)
                              @"iPad2,5"   :@"iPad Mini",       // (Original)
                              @"iPhone5,3" :@"iPhone 5c",       // (model A1456, A1532 | GSM)
                              @"iPhone5,4" :@"iPhone 5c",       // (model A1507, A1516, A1526 (China), A1529 | Global)
                              @"iPhone6,1" :@"iPhone 5s",       // (model A1433, A1533 | GSM)
                              @"iPhone6,2" :@"iPhone 5s",       // (model A1457, A1518, A1528 (China), A1530 | Global)
                              @"iPhone7,1" :@"iPhone 6 Plus",   //
                              @"iPhone7,2" :@"iPhone 6",        //
                              @"iPad4,1"   :@"iPad Air",        // 5th Generation iPad (iPad Air) - Wifi
                              @"iPad4,2"   :@"iPad Air",        // 5th Generation iPad (iPad Air) - Cellular
                              @"iPad4,4"   :@"iPad Mini",       // (2nd Generation iPad Mini - Wifi)
                              @"iPad4,5"   :@"iPad Mini"        // (2nd Generation iPad Mini - Cellular)
                              };
    }

    NSString* deviceName = [deviceNamesByCode objectForKey:code];

    if (!deviceName)
    {
        // Not found on database. At least guess main device type from string contents:

        if ([code rangeOfString:@"iPod"].location != NSNotFound)
        {
            deviceName = @"iPod Touch";
        }
        else if([code rangeOfString:@"iPad"].location != NSNotFound)
        {
            deviceName = @"iPad";
        }
        else if([code rangeOfString:@"iPhone"].location != NSNotFound)
        {
            deviceName = @"iPhone";
        }
    }

    return deviceName;
}

+ (BOOL) isLocationPermissionAuthorized
{
    return ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse);
}

+ (BOOL) isLocationPermissionNotDetermined
{
    return ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined);
}

+(BOOL) validateEmail:(NSString *) email
{
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [emailTest evaluateWithObject:email];
}

+ (void)shake:(UIView *)view withShakes:(int)shakes inDirection:(float)direction
{
    [UIView animateWithDuration:0.05 animations:^
     {
         view.transform = CGAffineTransformMakeTranslation(5 * direction, 0);
     }
                     completion:^(BOOL finished)
     {
         if(shakes <= 0)
         {
             view.transform = CGAffineTransformIdentity;
             return;
         }
         [CommonFunction shake:view withShakes:shakes-1 inDirection:direction*-1];
     }];
}

+ (void)addCardShadowToLayer:(CALayer *)layer
{
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 0.15;
    layer.shadowRadius = 0.75;
    layer.shadowOffset = CGSizeMake(0.5f, 0.5f);
    [layer setMasksToBounds:NO];
}

+ (void)addStrongShadowToLayer:(CALayer *)layer
{
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 0.4;
    layer.shadowRadius = 1.2;
    layer.shadowOffset = CGSizeMake(0, 0);
    [layer setMasksToBounds:NO];
}

+ (void)addTopShadowToLayer:(CALayer *)layer
{
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 0.15;
    layer.shadowRadius = 0.75;
    layer.shadowOffset = CGSizeMake(0, -1.0f);
    [layer setMasksToBounds:NO];
}

+ (void)addBottomShadowToLayer:(CALayer *)layer
{
    [layer setShadowColor:UIColorFromRGB(GBL4).CGColor];
    [layer setShadowOffset: CGSizeMake(2, 2)];
    [layer setShadowOpacity:0.4];
    [layer setMasksToBounds:NO];
}

+ (void)label:(UILabel *)label animateTextChange:(NSString *)text withCompletion:(void (^)(void))completionBlock
{
    [CommonFunction label:label animateTextChange:text withInterval:0.2 withCompletion:completionBlock];
}

+ (void)label:(UILabel *)label animateTextChange:(NSString *)text withInterval:(CGFloat)interval withCompletion:(void (^)(void))completionBlock
{
    [UIView animateWithDuration:interval animations:^{
        label.alpha = 0.0;
    } completion:^(BOOL finished) {
        label.text = text;
        [UIView animateWithDuration:interval animations:^{
            label.alpha = 1.0;
            completionBlock();
        }];
    }];
}

+ (void)label:(UILabel *)label animateAttributedTextChange:(NSAttributedString *)text withCompletion:(void (^)(void))completionBlock
{
    [CommonFunction label:label animateAttributedTextChange:text withInterval:0.2 withCompletion:completionBlock];
}

+ (void)label:(UILabel *)label animateAttributedTextChange:(NSAttributedString *)text withInterval:(CGFloat)interval withCompletion:(void (^)(void))completionBlock
{
    [UIView animateWithDuration:interval animations:^{
        label.alpha = 0.0;
    } completion:^(BOOL finished) {
        [label setAttributedText:text];
        [UIView animateWithDuration:interval animations:^{
            label.alpha = 1.0;
            completionBlock();
        }];
    }];
}

+ (void) addDiagonalLineToView:(UIView *)view withColor:(UIColor *)color withThickness:(double)thickness withViewFrame:(CGRect)frame
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(frame.size.width, frame.size.height)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [color CGColor];
    shapeLayer.lineWidth = thickness;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    
    [view.layer addSublayer:shapeLayer];
}

+ (void)fadeView:(UIView *)view
{
    UIView *fadeView = [[UIView alloc] initWithFrame:view.bounds];
    [fadeView setBackgroundColor:UIColorFromRGBWithAlpha(WHITE_COLOR, 0.7)];
    [view addSubview:fadeView];
}

+ (void) crashApp
{
    
}


+ (BOOL) canMakeCall
{
    if([[UIDevice currentDevice].model isEqualToString:@"iPhone"])
    {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]])
        {
            NSLog(@"Device can make call or send message");
            return YES;
        }
        else
        {
            NSLog(@"Device can not make call or send message");
        }
    }
    else
    {
        NSLog(@"Device can not make call or send message");
    }

    return NO;
}

@end