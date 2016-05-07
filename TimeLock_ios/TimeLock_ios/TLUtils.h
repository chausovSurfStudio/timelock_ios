//
//  TLUtils.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 01.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

@class MBProgressHUD;

@interface TLUtils : NSObject

// Методы для работы с NSUserDefaults
/** Проверка на существование не пустой строки в словаре NSUSerDefaults по заданному ключу */
+ (BOOL)checkExistenceNotEmptyStringObjectForKey:(NSString *)key;

/** Установить значение по заданному ключу в словарь NSUserDefaults */
+ (void)setObjectToUserSettings:(id)object forKey:(NSString *)key;

/** Геттер для объекта из словаря NSUserDefaults */
+ (id)objectFromUserSettingsForKey:(NSString *)key;

// Методы для работы с MBProgressHUD в контроллере
/** Метод показывает hud-view на переданном view */
+ (void)showHudView:(MBProgressHUD *)hud onView:(UIView *)view;

/** Убрать hud-view с выбранного view */
+ (void)hideHudView:(MBProgressHUD *)hud onView:(UIView *)view;

// Разное
/** Проверить существует ли строка и не пустая ли она */
+ (BOOL)checkExistenceOfString:(NSString *)string;

@end
