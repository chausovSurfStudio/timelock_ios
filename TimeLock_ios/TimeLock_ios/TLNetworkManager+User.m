//
//  TLNetworkManager+User.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 07.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "TLNetworkManager+User.h"
#import "DataStorageManager+User.h"

@implementation TLNetworkManager (User)

- (void)userProfileWithID:(NSNumber *)userID completion:(void (^)(BOOL success, id object))completion {
    NSString *url = [BASE_URL stringByAppendingString:[NSString stringWithFormat:USER_PATH, userID]];
    [self requestType:GET url:url parameters:nil completion:^(BOOL success, id result){
        if (success && [result isKindOfClass:[NSDictionary class]]) {
            [[DataStorageManager sharedDataStorage] createAndSaveUser:result completion:^(BOOL success, id object) {
                completion(success, object);
            }];
        } else {
            completion(NO, result);
        }
    }];
}

@end
