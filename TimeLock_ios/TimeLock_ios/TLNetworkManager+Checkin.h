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
- (void)deleteCheckinWithID:(NSNumber *)checkinID completion:(void (^)(BOOL success, id object))completion;
- (void)updateCheckinWithID:(NSNumber *)checkinID date:(NSDate *)date completion:(void (^)(BOOL success, id object))completion;
- (void)createCheckinWithDate:(NSDate *)date completion:(void (^)(BOOL success, id object))completion;

@end
