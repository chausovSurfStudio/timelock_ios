//
//  TLUtils.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 01.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLUtils : NSObject

// Методы для работы с NSUserDefaults
/** Проверка на существование не пустой строки в словаре NSUSerDefaults по заданному ключу */
+ (BOOL)checkExistenceNotEmptyStringObjectForKey:(NSString *)key;

/** Установить значение по заданному ключу в словарь NSUserDefaults */
+ (void)setObjectToUserSettings:(id)object forKey:(NSString *)key;

/** Геттер для объекта из словаря NSUserDefaults */
+ (id)objectFromUserSettingsForKey:(NSString *)key;

@end
