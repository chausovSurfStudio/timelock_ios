//
//  CheckinsListViewController.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 16.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckinsListViewController : UIViewController

- (instancetype)initWithCheckins:(NSArray *)checkins date:(NSDate *)date completeion:(void (^)())completion;

@end
