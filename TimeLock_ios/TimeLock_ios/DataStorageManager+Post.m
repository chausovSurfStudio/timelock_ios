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
    [Post MR_truncateAll];
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext){
        for (NSDictionary *dict in params) {
            Post *post = [Post MR_createEntityInContext:localContext];
            
            post.id_ = [dict safeGetLongLongNumberFromStringByKey:@"id"];
            post.body = [dict safeGetStringByKey:@"body"];
            post.timestamp = [dict safeGetDateFromStringByKey:@"timestamp" andDateFormat:dateFormatString];
            
            NSDictionary *authorDict = dict[@"author"];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_ == %@", authorDict[@"id"]];
            User *user = [[[User MR_findAllWithPredicate:predicate] firstObject] MR_inContext:localContext];
            if (!user) {
                user = [User MR_createEntityInContext:localContext];
            }
            user.id_        = [authorDict safeGetLongLongNumberFromStringByKey:@"id"];
            user.firstName  = [authorDict safeGetStringByKey:@"first_name"];
            user.lastName   = [authorDict safeGetStringByKey:@"last_name"];
            user.middleName = [authorDict safeGetStringByKey:@"middle_name"];
            user.username   = [authorDict safeGetStringByKey:@"username"];
            user.companyName = [authorDict safeGetStringByKey:@"company_name"];
            user.avatar     = [authorDict safeGetStringByKey:@"avatar"];
                
            post.user = user;
            [user addPostsObject:post];
        }
    } completion:^(BOOL success, NSError *error) {
        if(success || (!success && !error)) {
            completion(YES, [Post MR_findAllSortedBy:@"timestamp" ascending:NO]);
        }
        else completion(success, error);
    }];
}

@end
