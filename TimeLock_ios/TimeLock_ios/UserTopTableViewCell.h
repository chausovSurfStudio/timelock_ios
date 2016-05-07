//
//  UserTopTableViewCell.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 07.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@interface UserTopTableViewCell : UITableViewCell

- (void)configCellWithUser:(User *)user;

@end
