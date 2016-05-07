//
//  TLNetworkManager+User.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 07.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "TLNetworkManager.h"

@interface TLNetworkManager (User)

- (void)userProfileWithID:(NSNumber *)userID completion:(void (^)(BOOL success, id object))completion;

@end
