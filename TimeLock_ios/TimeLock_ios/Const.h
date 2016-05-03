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

#define NAVIGATION_BAR_COLOR    MAIN_BLUE_COLOR
#define TAB_BAR_COLOR           MAIN_RED_COLOR

#define MAIN_BLUE_COLOR     [UIColor colorWithRed:149/255.0 green:151/255.0  blue:150/255.0  alpha:1.0]
#define MAIN_GREEN_COLOR    [UIColor colorWithRed:113/255.0 green:122/255.0  blue:39/255.0  alpha:1.0]
#define MAIN_RED_COLOR      [UIColor colorWithRed:168/255.0 green:91/255.0  blue:111/255.0  alpha:1.0]

#define MAIN_BLUE_COLOR_PRESSED     [UIColor colorWithRed:49/255.0 green:44/255.0  blue:72/255.0  alpha:1.0]
#define MAIN_GREEN_COLOR_PRESSED    [UIColor colorWithRed:66/255.0 green:92/255.0  blue:50/255.0  alpha:1.0]
#define MAIN_RED_COLOR_PRESSED      [UIColor colorWithRed:105/255.0 green:59/255.0  blue:58/255.0  alpha:1.0]

#define GREEN_BUTTON_TEXT_COLOR     [UIColor whiteColor]
#define RED_BUTTON_TEXT_COLOR       [UIColor whiteColor]

// FONTS

#define BUTTON_FONT [UIFont fontWithName:@"PTSans-Bold" size:18]

// URL PATH

static NSString * const BASE_URL = @"http://127.0.0.1:5000/api/v1.0";

static NSString * const TOKEN_PATH = @"/token";
static NSString * const POST_PATH = @"/posts/";
static NSString * const CURRENT_USER_PATH = @"/users/";

// CONST STRING

static NSString * const needRelogin = @"needReloginNotification";
static NSString * const needRepeatRequest = @"needRepeatRequestNotification";

#endif
