//
//  ChangeProfileViewController.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 08.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@interface ChangeProfileViewController : UIViewController

- (instancetype)initWithUser:(User *)user;

@end
