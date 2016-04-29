//
//  TLNetworkManager+Authorization.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 29.04.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "TLNetworkManager.h"
  
@interface TLNetworkManager (Authorization)

- (void)authorizationRequestParam:(NSDictionary *)param completion:(void (^)(BOOL success, id object))completion;

@end
