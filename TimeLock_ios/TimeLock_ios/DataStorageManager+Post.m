//
//  DataStorageManager+Post.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 03.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "DataStorageManager+Post.h"
#import "DataStorageManager+User.h"
#import "Post.h"
#import "User.h"
#import "NSDictionary+SafeGetters.h"

#import <MagicalRecord/MagicalRecord.h>

@implementation DataStorageManager (Post)

- (void)createAndSavePosts:(NSArray *)params completion:(void (^)(BOOL success, id object))completion {
    NSArray *array = [Post MR_findAll];
    NSLog(@"COUNT = %ld", (unsigned long)array.count);
    for (NSDictionary *dict in params) {
        [Post MR_importFromObject:dict];
    }
    completion(YES, [Post MR_findAllSortedBy:@"timestamp" ascending:NO]);
}

@end
