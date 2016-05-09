//
//  ChangeProfileDataTableViewCell.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 08.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "ChangeProfileDataTableViewCell.h"
#import "User.h"

@implementation ChangeProfileDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.usernameTextField.placeholder = NSLocalizedString(@"usernamePlaceholder", nil);
    self.lastNameTextField.placeholder = NSLocalizedString(@"lastNamePlaceholder", nil);
    self.firstNameTextField.placeholder = NSLocalizedString(@"firstNamePlaceholder", nil);
    self.middleNameTextField.placeholder = NSLocalizedString(@"middleNamePlaceholder", nil);
    
    self.usernameTextField.textColor = TEXT_COLOR;
    self.lastNameTextField.textColor = TEXT_COLOR;
    self.firstNameTextField.textColor = TEXT_COLOR;
    self.middleNameTextField.textColor = TEXT_COLOR;
    
    self.usernameTextField.tintColor = MAIN_THEME_COLOR;
    self.lastNameTextField.tintColor = MAIN_THEME_COLOR;
    self.firstNameTextField.tintColor = MAIN_THEME_COLOR;
    self.middleNameTextField.tintColor = MAIN_THEME_COLOR;
}

- (void)configWithUser:(User *)user {
    if ([TLUtils checkExistenceOfString:user.username]) {
        self.usernameTextField.text = user.username;
    }
    if ([TLUtils checkExistenceOfString:user.lastName]) {
        self.lastNameTextField.text = user.lastName;
    }
    if ([TLUtils checkExistenceOfString:user.firstName]) {
        self.firstNameTextField.text = user.firstName;
    }
    if ([TLUtils checkExistenceOfString:user.middleName]) {
        self.middleNameTextField.text = user.middleName;
    }
}

@end
