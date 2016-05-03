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

static NSString * const dateFormatString = @"dd.MM.yyyy HH:mm:ss";

@implementation DataStorageManager (Post)

- (void)createAndSavePosts:(NSArray *)params completion:(void (^)(BOOL success, id object))completion {
    NSArray *storedPosts = [Post MR_findAll];
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext){
        for (NSDictionary *dict in params) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_ == %@", dict[@"id"]];
            Post *post = [[[storedPosts filteredArrayUsingPredicate:predicate] firstObject] MR_inContext:localContext];
            if (!post) {
                post = [Post MR_createEntityInContext:localContext];
            }
            
            post.id_ = [dict safeGetLongLongNumberFromStringByKey:@"id"];
            post.body = [dict safeGetStringByKey:@"body"];
            post.timestamp = [dict safeGetDateFromStringByKey:@"timestamp" andDateFormat:dateFormatString];
            [self createAndSaveUser:dict[@"author"] completion:^(BOOL success, id object) {
                if (success) {
                    User *user = [(User *)object MR_inContext:localContext];
                    post.user = user;
                    [user addPostsObject:post];
                } else {
                    post.user = nil;
                }
            }];
        }
    } completion:^(BOOL success, NSError *error) {
        if(success || (!success && !error)) {
            completion(YES, [Post MR_findAllSortedBy:@"timestamp" ascending:NO]);
        }
        else completion(success, error);
    }];
}

@end
