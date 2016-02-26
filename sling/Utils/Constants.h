//
//  Constants.h
//  grofer-consumer
//
//  Created by Satyam Krishna on 07/12/14.
//  Copyright (c) 2014 GroferIt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UILabelCustomStyle.h"
#import "SlingSettings.h"
#import "NSCustomError.h"

// Completion blocks for API calls
typedef void (^GOperationCompletionBlock)(id responseObject);
typedef void (^SimpleErrorCompletionBlock)(NSCustomError *error);

// HTTP Terms
// Switched these to static strings to avoid build conflicts with AFNetworking 2.0 method names
static NSString *HTTP_GET = @"GET";
static NSString *HTTP_POST = @"POST";
static NSString *HTTP_PUT = @"PUT";
static NSString *HTTP_DELETE = @"DELETE";

@interface Constants : NSObject

#define DEFAULT_DATE_FORMAT   @"yyyy-MM-dd"

//********************API***********************

#define API_RETRY_COUNT 3
#define API_LIVE_URL @"sling-server.herokuapp.com"
#define API_STAGE_URL @"sling-server.herokuapp.com"


#define API_NA @"-NA-"

#define VERSION_NUMBER 1
#define VERSION_NAME   @"1.0"

#define NO_RESOURCE_INTERNET_TAG 101110046
#define NO_RESOURCE_SERVER_TAG   101110049
#define NO_RESOURCE_RETAKE_TAG   101110040


//********************* ENDS **************************

//********************default heights & widths of some views***********************

#define SEPARATOR_THINNEST           0.5f
#define SEPARATOR_THIN               1.0f
#define SEPARATOR_MODERATE           1.5f
#define SEPARATOR_NORMAL             2.0f
#define SEPARATOR_THICK              3.0f
#define SEPARATOR_THICKEST           4.0f

#define DRAWER_WIDTH                 250.0f
#define SIDE_PADDING                 15.0
#define SCROLLABLE_TAB_HEIGHT        40.0f
#define URC_LOW                      3.0
#define URC_MEDIUM                   5.0
#define NAVIGATION_BAR_HEIGHT        64.0
#define TAB_BAR_HEIGHT               49.0
#define MAIN_HEADER_HEIGHT           45.0f
#define MAIN_HEADER_SEPARATOR_HEIGHT SEPARATOR_THINNEST
#define TAB_BAR_HEIGHT               49.0
#define BUTTON_HEIGHT                45.0f

#define NOTIFICATION_PADDING         10.0f

#define STATUS_BAR_HEIGHT_ADDITION (SYSTEM_VERSION_LESS_THAN(@"7.0") ? 0.0f : 20.0f)
#define NO_RESOURCE_FRAME CGRectMake(0, 0,W([self view]), H([self view]))

#define RECENT_LOCATION_FETCH_COUNT 5.0f

#define NAV_BAR_ICON_WIDTH    25.0f
#define NAV_BAR_LEFT_PADDING  20.0f
#define NAV_BAR_RIGHT_PADDING -16.0f

#define GROFER_TIME_STEP 1800
#define TimeStamp [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]]

#define DAFAULT_KEYBOARD_HEIGHT 216

#define CORNER_RADIUS_SMALL 2.0f
#define CORNER_RADIUS_BIG 3.0f

//********************* ENDS **************************



//********************* NSNotification Constants **************************

#define NOTIFICATION_CATEGORY_UPDATED    @"notif_category_update"
#define NOTIFICATION_USER_CART_UPDATED   @"notif_user_update_cart"
#define NOTIFICATION_UPDATE_NAVIGATION   @"notif_update_notification_drawer"
#define NOTIFICATION_USER_LOGGED_IN      @"notif_user_logged_in"
#define NOTIFICATION_USER_LOGGED_OUT     @"notif_user_logged_out"
#define NOTIFICATION_USER_LOCATON_UP     @"notif_user_loc_update"
#define SHOW_LOCAL_NOTIFICATION          @"notif_show_local"
#define HIDE_LOCAL_NOTIFICATION          @"notif_hide_local"
#define CLICK_LOCAL_NOTIFICATION         @"notif_click_local"
#define SAVE_LOCAL_NOTIFICATION          @"notif_save_local"
#define CART_QUANTITY_NOTIFICATION       @"cart_quantity_changed"
#define CART_RELOAD_ON_UPDATE            @"CART_RELOAD"

//********************* ENDS **************************



//********************* RELOAD VARIABLES **************************

#define RELOAD_ORDER                     @"reload_order"
#define RELOAD_FEED                      @"reload_feed"

//********************* ENDS **************************



//********************* NSUserDefaults Constants **************************

#define FIRST_RUN       @"user_first_run"
#define FIRST_LOCATION  @"user_first_location"
#define FIRST_ONBOARD   @"user_first_onboarding"
#define USER_LOGGED_IN  @"user_logged_in"
#define USER_IS_ADMIN   @"user_is_admin"
#define ACCESS_TOKEN    @"access_token"
#define AUTH_TOKEN      @"auth_token"
#define SLING_USER      @"sling_user"
#define USER_LATITUDE   @"latitude"
#define USER_LONGITUDE  @"longitude"
#define USER_LOCATION   @"location"
#define USER_LOC_OBJ    @"location_obj"
#define USER_CART_ID    @"user_cart_id"
#define INVENTORY_VER   @"inventory_version"
#define RELOAD_ACCESS   @"should_reload"
#define REFERRAL_CODE   @"referral_code"
#define NOTIFICATION_TS @"user_notification_ts"
#define DIALOG_LIST     @"simple_dialog_list"

//********************* ENDS **************************



//*********************Colors**************************

//#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00) >> 8))/255.0 blue:((float)((rgbValue) & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define GBL1                  0x111111
#define GBL2                  0x666666
#define GBL3                  0x999999
#define GBL4                  0xcccccc
#define GBL4_5                0xdddddd
#define GBL5                  0xeeeeee
#define GBL6                  0xf4f4f4
#define GBL7                  0xf6f6f6
#define GBL8                  0xfcfcfc

#define BLU1                  0x2c8196
#define BLU2                  0x3192aa
#define BLU3                  0x37a3be
#define BLU4                  0x45afc9
#define BLU5                  0x59b7cf
#define BLU6                  0x6dc0d5

#define GROFERS_ORANGE        0xE96125
#define GROFERS_ORANGE_P      0xde5416
#define GROFERS_BLUE          0x37a3be
#define GROFERS_BLUE_P        0x3192aa

#define DEFAULT_PLACEHOLDER_COLOR @"#f9d6bd"

#define PEACH                  0xFEFBF6
#define GROFERS_ORANGE_FADDED  0xffccb6

#define SEPARATOR_COLOR       GBL5
#define SEPARATOR_COLOR_LIGHT GBL4
#define LOADING_BG_COLOR      0xEDEDED
#define APPLE_SEP_COLOR       0xEFEFF4
#define WHITE_COLOR           0xFFFFFF
#define BLACK_COLOR           0x000000
#define GREEN_COLOR           0x69BC63
#define RED_COLOR             0xCC4C46
#define RED_COLOR_LIGHT      0xfcf2f1
#define DISABLE_RED_COLOR     0xCB4A44
#define GREY_COLOR            0xD0CECD
#define GREY_DARK             0xD0D0D0
#define FACEBOOK_BLUE         0x3B5998
#define WHATSAPP_GREEN        0xFF2E8A06
#define GOOGLE_RED            0xdd4b39
#define SEARCH_BAR_COLOR      0xBFBFC4
#define NOTIFICATION_COLOR    0x1a1a19
#define NOTIFICATION_COLOR_ICON_READ 0xc3c3c3
#define NOTIFICATION_BG_COLOR GBL6
#define MHS_COLOR             0x1C2224

#define TABLE_CELL_SELECTED   GBL6
#define TABLE_CELL_DESELECTED WHITE_COLOR
#define NAV_BAR_COLOR         0x3C96F2
#define NAV_SEARCH_BCG_COLOR  0x262C2E
#define NAV_BAR_ITEMS_COLOR   WHITE_COLOR
#define TAB_BAR_BACKGROUND    0xF8F8F8


//********************* ENDS **************************



/*============================= Styles =======================================*/

#define TABLE_VIEW_SEPARATOR_COLOR GBL4
#define TABLE_VIEW_SEPARATOR_HEIGHT SEPARATOR_THINNEST

#define STYLE_H2 [[UILabelCustomStyle alloc] initWithFont : FONT_BOLD_15 color: UIColorFromRGB(ZDARK) allCaps : YES]
#define STYLE_H3 [[UILabelCustomStyle alloc] initWithFont : FONT_BOLD_12 color: [UIColor whiteColor] allCaps : YES]
#define STYLE_NAV_HEADER_TITLE [[UILabelCustomStyle alloc] initWithFont : FONT_BOLD_17 color : [UIColor whiteColor] allCaps : NO]

//********************* ENDS **************************



/*=============================Universal Fonts=======================================*/

#define FONT_BODY_SMALL                 [UIFont fontWithName:@"Roboto-Light" size:13]
#define FONT_BODY                       [UIFont fontWithName:@"Roboto-Light" size:14]

#define FONT_BODY_BOLD                  [UIFont fontWithName:@"Roboto-Regular" size:14]
#define FONT_BODY_BOLD_LARGE            FONT_BOLD_15

#define FONT_NAV_BAR_LABEL              [UIFont fontWithName:@"Roboto-Medium" size:16]

// BLACK FONTS

#define FONT_BLACK_8                 [UIFont fontWithName:@"Roboto-Medium" size:8]
#define FONT_BLACK_9                 [UIFont fontWithName:@"Roboto-Medium" size:9]
#define FONT_BLACK_10                [UIFont fontWithName:@"Roboto-Medium" size:10]
#define FONT_BLACK_11                [UIFont fontWithName:@"Roboto-Medium" size:11]
#define FONT_BLACK_12                [UIFont fontWithName:@"Roboto-Medium" size:12]
#define FONT_BLACK_13                [UIFont fontWithName:@"Roboto-Medium" size:13]
#define FONT_BLACK_14                [UIFont fontWithName:@"Roboto-Medium" size:14]
#define FONT_BLACK_15                [UIFont fontWithName:@"Roboto-Medium" size:15]
#define FONT_BLACK_16                [UIFont fontWithName:@"Roboto-Medium" size:16]
#define FONT_BLACK_17                [UIFont fontWithName:@"Roboto-Medium" size:17]
#define FONT_BLACK_18                [UIFont fontWithName:@"Roboto-Medium" size:18]
#define FONT_BLACK_19                [UIFont fontWithName:@"Roboto-Medium" size:19]
#define FONT_BLACK_20                [UIFont fontWithName:@"Roboto-Medium" size:20]
#define FONT_BLACK_22                [UIFont fontWithName:@"Roboto-Medium" size:22]
#define FONT_BLACK_24                [UIFont fontWithName:@"Roboto-Medium" size:24]
#define FONT_BLACK_26                [UIFont fontWithName:@"Roboto-Medium" size:26]
#define FONT_BLACK_32                [UIFont fontWithName:@"Roboto-Medium" size:32]
#define FONT_BLACK(X)                [UIFont fontWithName:@"Roboto-Medium" size:X]


// BOLD FONTS

#define FONT_BOLD_8                 [UIFont fontWithName:@"Roboto-Regular" size:8]
#define FONT_BOLD_9                 [UIFont fontWithName:@"Roboto-Regular" size:9]
#define FONT_BOLD_10                [UIFont fontWithName:@"Roboto-Regular" size:10]
#define FONT_BOLD_11                [UIFont fontWithName:@"Roboto-Regular" size:11]
#define FONT_BOLD_12                [UIFont fontWithName:@"Roboto-Regular" size:12]
#define FONT_BOLD_13                [UIFont fontWithName:@"Roboto-Regular" size:13]
#define FONT_BOLD_14                [UIFont fontWithName:@"Roboto-Regular" size:14]
#define FONT_BOLD_15                [UIFont fontWithName:@"Roboto-Regular" size:15]
#define FONT_BOLD_16                [UIFont fontWithName:@"Roboto-Regular" size:16]
#define FONT_BOLD_17                [UIFont fontWithName:@"Roboto-Regular" size:17]
#define FONT_BOLD_18                [UIFont fontWithName:@"Roboto-Regular" size:18]
#define FONT_BOLD_19                [UIFont fontWithName:@"Roboto-Regular" size:19]
#define FONT_BOLD_20                [UIFont fontWithName:@"Roboto-Regular" size:20]
#define FONT_BOLD_22                [UIFont fontWithName:@"Roboto-Regular" size:22]
#define FONT_BOLD_24                [UIFont fontWithName:@"Roboto-Regular" size:24]
#define FONT_BOLD_26                [UIFont fontWithName:@"Roboto-Regular" size:26]
#define FONT_BOLD_32                [UIFont fontWithName:@"Roboto-Regular" size:32]
#define FONT_BOLD(X)                [UIFont fontWithName:@"Roboto-Regular" size:X]

// Regular fonts

#define FONT_REGULAR_1              [UIFont fontWithName:@"Roboto-Light" size:1]
#define FONT_REGULAR_8              [UIFont fontWithName:@"Roboto-Light" size:8]
#define FONT_REGULAR_9              [UIFont fontWithName:@"Roboto-Light" size:9]
#define FONT_REGULAR_10             [UIFont fontWithName:@"Roboto-Light" size:10]
#define FONT_REGULAR_11             [UIFont fontWithName:@"Roboto-Light" size:11]
#define FONT_REGULAR_12             [UIFont fontWithName:@"Roboto-Light" size:12]
#define FONT_REGULAR_12_5           [UIFont fontWithName:@"Roboto-Light" size:12.5]
#define FONT_REGULAR_13             [UIFont fontWithName:@"Roboto-Light" size:13]
#define FONT_REGULAR_14             [UIFont fontWithName:@"Roboto-Light" size:14]
#define FONT_REGULAR_15             [UIFont fontWithName:@"Roboto-Light" size:15]
#define FONT_REGULAR_16             [UIFont fontWithName:@"Roboto-Light" size:16]
#define FONT_REGULAR_17             [UIFont fontWithName:@"Roboto-Light" size:17]
#define FONT_REGULAR_18             [UIFont fontWithName:@"Roboto-Light" size:18]
#define FONT_REGULAR_19             [UIFont fontWithName:@"Roboto-Light" size:19]
#define FONT_REGULAR_20             [UIFont fontWithName:@"Roboto-Light" size:20]
#define FONT_REGULAR_21             [UIFont fontWithName:@"Roboto-Light" size:21]
#define FONT_REGULAR_22             [UIFont fontWithName:@"Roboto-Light" size:22]
#define FONT_REGULAR_23             [UIFont fontWithName:@"Roboto-Light" size:23]
#define FONT_REGULAR_24             [UIFont fontWithName:@"Roboto-Light" size:24]
#define FONT_REGULAR_25             [UIFont fontWithName:@"Roboto-Light" size:25]
#define FONT_REGULAR_30             [UIFont fontWithName:@"Roboto-Light" size:30]
#define FONT_REGULAR(X)             [UIFont fontWithName:@"Roboto-Light" size:X]

#define FONT_ICON(X)                [UIFont fontWithName:@"ios" size:X]

//********************* ENDS **************************


// ****************** ADMIN SWITCHES ********************

#define URL_TARGET @"urlTarget"
#define DISABLE_IMAGES @"disableImages"

@end
