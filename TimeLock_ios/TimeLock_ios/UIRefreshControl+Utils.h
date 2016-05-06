//
//  UIRereshControl+Utils.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 06.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIRefreshControl (Utils)

@property (nonatomic,readwrite) BOOL refreshing;

@end

@interface UIScrollView (RefreshControl)

@property (nonatomic,readwrite,strong) UIRefreshControl *manualRefreshControl;

@end
