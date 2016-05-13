//
//  TLNetwrokManager+Checkin.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 13.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "TLNetworkManager.h"

@interface TLNetworkManager (Checkin)

- (void)getCheckinsPage:(NSInteger)page completion:(void (^)(BOOL success, id object))completion;

@end
