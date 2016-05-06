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
    NSArray *array = [User MR_findAll];
    NSLog(@"COUNT = %ld", (unsigned long)array.count);
    User *user = [User MR_importFromObject:params];
    completion(YES, user);
}

@end
