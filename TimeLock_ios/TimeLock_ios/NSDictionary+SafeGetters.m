//
//  NSDictionary+SafeGetStringValueByKey.m
//  okey
//
//  Created by Ольферук Александр on 08/10/15.
//  Copyright (c) 2015 SurfStudio. All rights reserved.
//

#import "NSDictionary+SafeGetters.h"

@implementation NSDictionary (SafeGetters)

-(NSString *)safeGetStringByKey:(NSString *)key {
    return [self safeGetStringByKey:key defaultValue:@""];
}

-(NSString *)safeGetStringByKey:(NSString *)key defaultValue:(NSString *)value {
    if (self[key] && self[key] != [NSNull null] && [self[key] isKindOfClass:[NSString class]]) {
        return self[key];
    }
    return value;
}

-(NSArray *)safeGetArrayByKey:(NSString *)key {
    if (self[key] != [NSNull null] && [self[key] isKindOfClass:[NSArray class]]) {
        return self[key];
    }
    return nil;
}

-(NSNumber *)safeGetDoubleNumberFromStringByKey:(NSString *)key {
    NSString *data = [self safeGetStringByKey:key];
    if ([data isEqualToString:@""]) {
        return nil;
    }
    return @([data doubleValue]);
}

- (NSNumber *)safeGetLongLongNumberFromStringByKey:(NSString *)key {
    if (self[key] && self[key] != [NSNull null]) {
        return @([self[key] longLongValue]);
    }
    return nil;
}

-(NSDate *)safeGetDateFromStringByKey:(NSString *)key andDateFormat:(NSString *)dateFormat {
    NSString *s = [self safeGetStringByKey:key];
    if ([s isEqualToString:@""]) {
        return nil;
    }
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ru_RU_POSIX"]];
    [formatter setDateFormat:dateFormat];
    return [formatter dateFromString:s];
}

@end
