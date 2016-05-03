//
//  UIRefreshControl+Animation.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 03.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "UIRefreshControl+Animation.h"

@implementation UIRefreshControl (Animation)

- (void)smoothEndRefreshing {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self endRefreshing];
    });
}

@end
