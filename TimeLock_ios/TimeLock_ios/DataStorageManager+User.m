//
//  DataStorageManager+User.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 03.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "DataStorageManager+User.h"
#import "User.h"
#import "NSDictionary+SafeGetters.h"

#import <MagicalRecord/MagicalRecord.h>

@implementation DataStorageManager (User)

- (void)createAndSaveUsers:(NSArray *)params completion:(void (^)(BOOL success, id object))completion {
    
}

- (void)createAndSaveUser:(NSDictionary *)params completion:(void (^)(BOOL success, id object))completion {
    NSArray *storedUsers = [User MR_findAll];
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_ == %@", params[@"id"]];
        User *user = [[[storedUsers filteredArrayUsingPredicate:predicate] firstObject] MR_inContext:localContext];
        if (!user) {
            user = [User MR_createEntityInContext:localContext];
        }
        [self storeInfoFromDict:params forUser:user];
    } completion:^(BOOL success, NSError *error) {
        if(success || (!success && !error)) {
            completion(YES, [User MR_findFirstByAttribute:@"id_" withValue:params[@"id"]]);
        }
        else completion(success, error);
    }];
}

- (void)storeInfoFromDict:(NSDictionary *)dict forUser:(User *)user {
    user.id_        = [dict safeGetLongLongNumberFromStringByKey:@"id"];
    user.firstName  = [dict safeGetStringByKey:@"first_name"];
    user.lastName   = [dict safeGetStringByKey:@"last_name"];
    user.middleName = [dict safeGetStringByKey:@"middle_name"];
    user.username   = [dict safeGetStringByKey:@"username"];
    user.companyName = [dict safeGetStringByKey:@"company_name"];
    user.avatar     = [dict safeGetStringByKey:@"avatar"];
}

@end
