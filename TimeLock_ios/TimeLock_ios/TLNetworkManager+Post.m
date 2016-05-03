//
//  TLNetworkManager+Post.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 03.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "TLNetworkManager+Post.h"
#import "DataStorageManager+Post.h"
#import "Const.h"
#import "TLUtils.h"

@implementation TLNetworkManager (Post)

- (void)postsRequestWithParam:(NSDictionary *)param completion:(void (^)(BOOL success, id object))completion {
    NSString *url = [BASE_URL stringByAppendingString:[NSString stringWithFormat:POST_PATH]];
    [self requestType:GET url:url parameters:param completion:^(BOOL success, id result){
        if (success && [result isKindOfClass:[NSDictionary class]]) {
            [[DataStorageManager sharedDataStorage] createAndSavePosts:result[@"posts"] completion:^(BOOL success, id object) {
                completion(success, object);
            }];
        } else {
            completion(NO, result);
        }
    }];
}

@end
