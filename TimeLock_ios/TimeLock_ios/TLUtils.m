//
//  TLUtils.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 01.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "TLUtils.h"
#import <MBProgressHUD/MBProgressHUD.h>

static CGFloat const sadImageSize = 32.0f;
static CGFloat const timeLabelWidth = 50.0f;
static CGFloat const timeLabelHeight = 21.0f;

@implementation TLUtils

#pragma mark - NSUserDefaults
// Проверка на существование не пустой строки в словаре NSUSerDefaults по заданному ключу
+ (BOOL)checkExistenceNotEmptyStringObjectForKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:key] && ![[defaults objectForKey:key] isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
}

// Установить значение по заданному ключу в словарь NSUserDefaults
+ (void)setObjectToUserSettings:(id)object forKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (key) {
        [defaults setObject:object forKey:key];
        [defaults synchronize];
    } else {
        NSLog(@"key is null");
    }
}

// Геттер для объекта из словаря NSUserDefaults
+ (id)objectFromUserSettingsForKey:(NSString *)key {
    if (key) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        return [defaults objectForKey:key];
    } else {
        return nil;
    }
}

#pragma mark - HUD-view
// Метод показывает hud-view на переданном view
+ (void)showHudView:(MBProgressHUD *)hud onView:(UIView *)view {
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.color = [UIColor clearColor];
        hud.activityIndicatorColor = [UIColor grayColor];
    }
}

// Убрать hud-view с выбранного view
+ (void)hideHudView:(MBProgressHUD *)hud onView:(UIView *)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
    hud = nil;
}

#pragma mark - Others
// Проверить существует ли строка и не пустая ли она
+ (BOOL)checkExistenceOfString:(NSString *)string {
    return (string && ![string isEqualToString:@""]);
}

// View для хэдэра секций в таблице чекинов
+ (UIView *)viewForheaderInCheckinsTableWithDate:(NSDate *)date andTime:(NSNumber *)time {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CHECKINS_HEADER_HEIGHT)];
    view.backgroundColor = MAIN_THEME_COLOR;
    if (date) {
        NSDateFormatter *formatter = [NSDateFormatter new];
        [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ru_RU_POSIX"]];
        [formatter setDateFormat:@"EEEE, d MMMM, yyyy"];
        NSString *dateString = [formatter stringFromDate:date];
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_OFFSET, TOP_OFFSET, SCREEN_WIDTH - 2 * LEFT_OFFSET, 21)];
        NSDictionary *attributes = @{
                                     NSForegroundColorAttributeName: TEXT_COLOR_LIGHT,
                                     NSFontAttributeName: SECTION_HEADER_FONT,
                                     };
        NSMutableAttributedString *attributedDateString = [[NSMutableAttributedString alloc] initWithString:[dateString capitalizedString] attributes:attributes];
        [attributedDateString addAttribute:NSForegroundColorAttributeName value:EXTRA_THEME_COLOR range:NSMakeRange(0, 1)];
        [attributedDateString addAttribute:NSFontAttributeName value:SECTION_HEADER_FONT_BOLD range:NSMakeRange(0, 1)];
        dateLabel.attributedText = attributedDateString;
        [view addSubview:dateLabel];
    }
    if (time && [time integerValue] != 0) {
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - LEFT_OFFSET - timeLabelWidth,
                                                                       (CHECKINS_HEADER_HEIGHT - timeLabelHeight) / 2.0,
                                                                       timeLabelWidth,
                                                                       timeLabelHeight)];
        timeLabel.textColor = TEXT_COLOR_LIGHT;
        timeLabel.font = SECTION_HEADER_FONT_BOLD;
        timeLabel.text = [TLUtils formatTimeStringForMinutes:time];
        timeLabel.textAlignment = NSTextAlignmentRight;
        [view addSubview:timeLabel];
    } else {
        UIImageView *sadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - LEFT_OFFSET - sadImageSize,
                                                                                  (CHECKINS_HEADER_HEIGHT - sadImageSize) / 2.0,
                                                                                  sadImageSize,
                                                                                  sadImageSize)];
        sadImageView.image = [UIImage imageNamed:@"ic_white_sad_smile.png"];
        [view addSubview:sadImageView];
    }
    
    return view;
}

// Возращает строку в формате 4:05, на вход подается количество минут
+ (NSString *)formatTimeStringForMinutes:(NSNumber *)value {
    NSInteger minutes = [value integerValue];
    NSInteger hours = minutes / 60;
    minutes = minutes % 60;
    return [NSString stringWithFormat:@"%ld:%02ld", (long)hours, (long)minutes];
}

@end
