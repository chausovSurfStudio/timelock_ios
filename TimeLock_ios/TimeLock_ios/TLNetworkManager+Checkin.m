//
//  TLNetwrokManager+Checkin.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 13.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "TLNetworkManager+Checkin.h"
#import "DataStorageManager+Checkin.h"

@implementation TLNetworkManager (Checkin)

- (void)getCheckinsPage:(NSInteger)page completion:(void (^)(BOOL success, id object))completion {
    NSString *url = [BASE_URL stringByAppendingString:[NSString stringWithFormat:CHECKINS_PAGE_PATH, page]];
    [self requestType:GET url:url parameters:nil completion:^(BOOL success, id result){
        if (success && [result isKindOfClass:[NSDictionary class]]) {
            [[DataStorageManager sharedDataStorage] saveCheckinsPage:result completion:^(BOOL success, id object) {
                completion(YES, object);
            }];
        } else {
            completion(NO, result);
        }
    }];
}

- (void)deleteCheckinWithID:(NSNumber *)checkinID completion:(void (^)(BOOL success, id object))completion {
    NSString *url = [BASE_URL stringByAppendingString:[NSString stringWithFormat:CHECKIN_WITH_ID_PATH, checkinID]];
    [self requestType:DELETE url:url parameters:nil completion:^(BOOL success, id result){
        if (success) {
            completion(YES, result);
        } else {
            completion(NO, result);
        }
    }];
}

- (void)updateCheckinWithID:(NSNumber *)checkinID date:(NSDate *)date completion:(void (^)(BOOL success, id object))completion {
    NSString *url = [BASE_URL stringByAppendingString:[NSString stringWithFormat:CHECKIN_WITH_ID_PATH, checkinID]];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ru_RU_POSIX"]];
    [formatter setDateFormat:serverDateFormat];
    NSString *dateString = [formatter stringFromDate:date];
    NSDictionary *params = @{@"date_string":dateString};
    [self requestType:PUT url:url parameters:params completion:^(BOOL success, id result){
        if (success) {
            completion(YES, result);
        } else {
            completion(NO, result);
        }
    }];
}

- (void)createCheckinWithDate:(NSDate *)date completion:(void (^)(BOOL success, id object))completion {
    NSString *url = [BASE_URL stringByAppendingString:CHECKIN_PATH];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ru_RU_POSIX"]];
    [formatter setDateFormat:serverDateFormat];
    NSString *dateString = [formatter stringFromDate:date];
    NSDictionary *params = @{@"date_string":dateString};
    [self requestType:POST url:url parameters:params completion:^(BOOL success, id result){
        if (success) {
            completion(YES, result);
        } else {
            completion(NO, result);
        }
    }];
}

@end
