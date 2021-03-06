//
//  Const.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 27.04.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#ifndef timelock_Const_h
#define timelock_Const_h

// COLOR

#define NAVIGATION_BAR_COLOR    MAIN_THEME_COLOR
#define TAB_BAR_COLOR           EXTRA_THEME_COLOR

#define MAIN_THEME_COLOR    [UIColor colorWithRed:74/255.0 green:74/255.0  blue:74/255.0  alpha:1.0]            //серый
#define EXTRA_THEME_COLOR   [UIColor colorWithRed:189/255.0 green:89/255.0  blue:0/255.0  alpha:1.0]            //оранжевый
#define GREEN_COLOR         [UIColor colorWithRed:24/255.0 green:152/255.0  blue:31/255.0  alpha:1.0]

#define MAIN_THEME_COLOR_PRESSED    [UIColor colorWithRed:74/255.0 green:74/255.0  blue:74/255.0  alpha:0.7]
#define EXTRA_THEME_COLOR_PRESSED   [UIColor colorWithRed:229/255.0 green:129/255.0  blue:70/255.0  alpha:1.0]

#define BORDER_BUTTON_TEXT_COLOR            TEXT_COLOR
#define BORDER_BUTTON_TEXT_COLOR_PRESSED    TEXT_COLOR_LIGHT
#define BORDER_BUTTON_TEXT_COLOR_DISABLED   TEXT_COLOR_EXTRA
#define MAIN_BUTTON_TEXT_COLOR              TEXT_COLOR_LIGHT
#define MAIN_BUTTON_TEXT_COLOR_PRESSED      TEXT_COLOR_LIGHT
#define WHITE_BUTTON_TEXT_COLOR             EXTRA_THEME_COLOR
#define WHITE_BUTTON_TEXT_COLOR_PRESSED     [EXTRA_THEME_COLOR colorWithAlphaComponent:0.6f]

#define ALERT_ERROR_COLOR   [UIColor colorWithRed:199./255 green:30./255 blue:30./255 alpha:0.9]
#define ALERT_INFO_COLOR    [UIColor colorWithRed:54./255 green:210./255 blue:159./255 alpha:1.0]

#define TEXT_COLOR          [UIColor colorWithRed:43./255 green:43./255 blue:43./255 alpha:0.9]
#define TEXT_COLOR_EXTRA    [UIColor colorWithRed:113./255 green:113./255 blue:113./255 alpha:0.9]
#define TEXT_COLOR_LIGHT    [UIColor whiteColor]

#define TEXT_FIELD_TEXT_COLOR   TEXT_COLOR
#define TEXT_FIELD_TINT_COLOR   MAIN_THEME_COLOR

#define SEPARATOR_COLOR         [UIColor colorWithRed:173/255.0 green:173/255.0  blue:173/255.0  alpha:1.0]
#define HIGHLIGHTED_CELL_COLOR  [UIColor colorWithRed:217/255.0 green:217/255.0  blue:217/255.0  alpha:1.0]

// FONTS

#define BUTTON_FONT             [UIFont fontWithName:@"PTSans-Bold" size:18]
#define COMPANY_NAME_FONT       [UIFont fontWithName:@"PTSans-Regular" size:16]
#define COMPANY_NAME_FONT_BOLD  [UIFont fontWithName:@"PTSans-Bold" size:17]
#define SECTION_HEADER_FONT             [UIFont fontWithName:@"PTSans-Regular" size:16]
#define SECTION_HEADER_FONT_BOLD        [UIFont fontWithName:@"PTSans-Bold" size:16]
#define SINGLE_CHECKIN_DESCRIPTION_FONT [UIFont fontWithName:@"PTSans-Regular" size:15]
#define SINGLE_CHECKIN_TIME_FONT        [UIFont fontWithName:@"PTSans-Bold" size:17]
#define NOTE_FONT                       [UIFont fontWithName:@"PTSans-Regular" size:15]
#define CHECKIN_DESCRIPTION_FONT        [UIFont fontWithName:@"PTSans-Regular" size:18]
#define CHECKIN_DESCRIPTION_FONT_BOLD   [UIFont fontWithName:@"PTSans-Bold" size:18]
#define EMPTY_CHECKINS_LIST_FONT        [UIFont fontWithName:@"PTSans-Regular" size:18]
#define UTILITY_BUTTON_FONT             [UIFont fontWithName:@"PTSans-Bold" size:16]
#define TEXT_FIELD_FONT                 [UIFont fontWithName:@"PTSans-Regular" size:14]

// URL PATH

//static NSString * const BASE_URL = @"http://127.0.0.1:5000/api/v1.0";
static NSString * const BASE_URL = @"https://422c3290.ngrok.io/api/v1.0";

static NSString * const TOKEN_PATH = @"/token";
static NSString * const POST_PATH = @"/posts/";
static NSString * const CURRENT_USER_PATH = @"/users/";
static NSString * const USER_PATH = @"/users/%@";
static NSString * const CHECKINS_PAGE_PATH = @"/checkins/?page=%ld";
static NSString * const CHECKIN_WITH_ID_PATH = @"/checkins/%@";
static NSString * const CHECKIN_PATH = @"/checkins/";

// CONST STRING

static NSString * const needRelogin = @"needReloginNotification";
static NSString * const needRepeatRequest = @"needRepeatRequestNotification";

static NSString * const mondayString = @"monday";
static NSString * const tuesdayString = @"tuesday";
static NSString * const wednesdayString = @"wednesday";
static NSString * const thursdayString = @"thursday";
static NSString * const fridayString = @"friday";
static NSString * const saturdayString = @"saturday";
static NSString * const sundayString = @"sunday";
static NSString * const resultTimeString = @"resultTime";

static NSString * const serverDateFormat = @"dd.MM.yyyy HH:mm:ss";

// IPHONE

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)


#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH <= 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

// OTHER

static NSInteger const LEFT_OFFSET = 15;
static NSInteger const TOP_OFFSET = 20;

static NSInteger const NAVIGATION_BAR_HEIGHT = 64;
static CGFloat const CHECKINS_HEADER_HEIGHT = 60.0f;

static CGFloat const CORNER_RADIUS = 5.0f;

#endif
