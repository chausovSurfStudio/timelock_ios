//
//  UIRereshControl+Utils.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 06.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "UIRefreshControl+Utils.h"
#import "UIRefreshControl+Animation.h"
#import <objc/runtime.h>

@implementation UIRefreshControl (Utils)

@dynamic refreshing;

-(void)setRefreshing:(BOOL)refreshing {
    if (refreshing == self.refreshing)
        return;
    if (refreshing)
        [self beginRefreshing];
    else
        [self smoothEndRefreshing];
}

@end


@implementation UIScrollView (RefreshControl)

- (UIRefreshControl *)manualRefreshControl {
    return objc_getAssociatedObject(self, @selector(manualRefreshControl));
}

- (void)setManualRefreshControl:(UIRefreshControl *)manualRefreshControl {
    if (manualRefreshControl == self.manualRefreshControl) return;
    [self.manualRefreshControl removeFromSuperview];
    objc_setAssociatedObject(self, @selector(manualRefreshControl), manualRefreshControl, OBJC_ASSOCIATION_RETAIN);
    if (manualRefreshControl)
        [self addSubview:manualRefreshControl];
}

@end
