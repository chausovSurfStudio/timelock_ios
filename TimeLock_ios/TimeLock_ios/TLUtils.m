//
//  TLUtils.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 01.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "TLUtils.h"
#import <MBProgressHUD/MBProgressHUD.h>

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

@end
