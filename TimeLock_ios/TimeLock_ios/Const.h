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

#define MAIN_THEME_COLOR_PRESSED    [UIColor colorWithRed:74/255.0 green:74/255.0  blue:74/255.0  alpha:0.7]
#define EXTRA_THEME_COLOR_PRESSED   [UIColor blackColor]

#define BORDER_BUTTON_TEXT_COLOR            TEXT_COLOR
#define BORDER_BUTTON_TEXT_COLOR_PRESSED    TEXT_COLOR_LIGHT
#define MAIN_BUTTON_TEXT_COLOR              TEXT_COLOR_LIGHT
#define MAIN_BUTTON_TEXT_COLOR_PRESSED      TEXT_COLOR_LIGHT

#define ALERT_ERROR_COLOR   [UIColor colorWithRed:199./255 green:30./255 blue:30./255 alpha:0.9]
#define ALERT_INFO_COLOR    [UIColor colorWithRed:54./255 green:210./255 blue:159./255 alpha:1.0]

#define TEXT_COLOR          [UIColor colorWithRed:43./255 green:43./255 blue:43./255 alpha:0.9]
#define TEXT_COLOR_EXTRA    [UIColor colorWithRed:113./255 green:113./255 blue:113./255 alpha:0.9]
#define TEXT_COLOR_LIGHT    [UIColor whiteColor]

#define TEXT_FIELD_TEXT_COLOR   TEXT_COLOR
#define TEXT_FIELD_TINT_COLOR   MAIN_THEME_COLOR

#define SEPARATOR_COLOR [UIColor colorWithRed:173/255.0 green:173/255.0  blue:173/255.0  alpha:1.0]

// FONTS

#define BUTTON_FONT [UIFont fontWithName:@"PTSans-Bold" size:18]
#define COMPANY_NAME_FONT       [UIFont fontWithName:@"PTSans-Regular" size:16]
#define COMPANY_NAME_FONT_BOLD  [UIFont fontWithName:@"PTSans-Bold" size:17]

// URL PATH

static NSString * const BASE_URL = @"http://127.0.0.1:5000/api/v1.0";
//static NSString * const BASE_URL = @"http://1d6dfd94.ngrok.io/api/v1.0";

static NSString * const TOKEN_PATH = @"/token";
static NSString * const POST_PATH = @"/posts/";
static NSString * const CURRENT_USER_PATH = @"/users/";
static NSString * const USER_PATH = @"/users/%@";

// CONST STRING

static NSString * const needRelogin = @"needReloginNotification";
static NSString * const needRepeatRequest = @"needRepeatRequestNotification";

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

static NSInteger const NAVIGATION_BAR_HEIGHT  = 64;

#endif
