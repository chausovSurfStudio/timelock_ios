//
//  TLNetworkManager+Authorization.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 29.04.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "TLNetworkManager+Authorization.h"
#import "Const.h"
#import "TLUtils.h"

@implementation TLNetworkManager (Authorization)

- (void)authorizationRequestParam:(NSDictionary *)param completion:(void (^)(BOOL success, id object))completion {
    [TLUtils setObjectToUserSettings:nil forKey:@"token"];
    NSString *url = [BASE_URL stringByAppendingString:[NSString stringWithFormat:TOKEN_PATH]];
    [self requestType:GET url:url parameters:param completion:^(BOOL success, id result){
        if (success && [result isKindOfClass:[NSDictionary class]]) {
            completion(YES, result);
        } else {
            completion(NO, result);
        }
    }];
}

@end
