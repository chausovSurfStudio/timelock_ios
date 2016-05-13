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

@end
