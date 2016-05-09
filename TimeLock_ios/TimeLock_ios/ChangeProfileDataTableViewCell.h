//
//  ChangeProfileDataTableViewCell.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 08.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@interface ChangeProfileDataTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UITextField *usernameTextField;
@property (nonatomic, strong) IBOutlet UITextField *lastNameTextField;
@property (nonatomic, strong) IBOutlet UITextField *firstNameTextField;
@property (nonatomic, strong) IBOutlet UITextField *middleNameTextField;

- (void)configWithUser:(User *)user;

@end
