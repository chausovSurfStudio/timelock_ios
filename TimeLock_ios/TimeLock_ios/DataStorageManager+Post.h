//
//  DataStorageManager+Post.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 03.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "DataStorageManager.h"

@interface DataStorageManager (Post)

- (void)createAndSavePosts:(NSArray *)params completion:(void (^)(BOOL success, id object))completion;

@end
