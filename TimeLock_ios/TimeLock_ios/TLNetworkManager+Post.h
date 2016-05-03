//
//  TLNetworkManager+Post.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 03.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "TLNetworkManager.h"

@interface TLNetworkManager (Post)

- (void)postsRequestWithParam:(NSDictionary *)param completion:(void (^)(BOOL success, id object))completion;

@end
