//
//  DataStorageManager+Checkin.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 13.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "DataStorageManager.h"

@interface DataStorageManager (Checkin)

- (void)saveCheckinsPage:(NSDictionary *)dict completion:(void (^)(BOOL success, id object))completion;

@end
