//
//  TLUtils.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 01.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "TLUtils.h"

@implementation TLUtils

// Методы для работы с NSUserDefaults
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

@end
