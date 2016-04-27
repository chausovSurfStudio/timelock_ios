//
//  TLLaunchLoginViewController.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 27.04.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLLaunchLoginViewController : UIViewController

@property (nonatomic, readwrite, copy) void (^completion)();

@end
