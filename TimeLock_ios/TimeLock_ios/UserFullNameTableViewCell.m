//
//  UserFullNameTableViewCell.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 07.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "UserFullNameTableViewCell.h"
#import "User.h"

@interface UserFullNameTableViewCell()

@property (nonatomic, strong) IBOutlet UILabel *lastNamePlaceholderLabel;
@property (nonatomic, strong) IBOutlet UILabel *lastNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *firstNamePlaceholderLabel;
@property (nonatomic, strong) IBOutlet UILabel *firstNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *middleNamePlaceholderLabel;
@property (nonatomic, strong) IBOutlet UILabel *middleNameLabel;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *firstNameViewHeightConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *lastNameViewHeightConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *middleNameViewHeightConstraint;
@property (nonatomic, strong) IBOutlet UIView *separatorView;

@end

@implementation UserFullNameTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.firstNameLabel.textColor = TEXT_COLOR;
    self.lastNameLabel.textColor = TEXT_COLOR;
    self.middleNameLabel.textColor = TEXT_COLOR;
    self.firstNamePlaceholderLabel.textColor = EXTRA_THEME_COLOR;
    self.middleNamePlaceholderLabel.textColor = EXTRA_THEME_COLOR;
    self.lastNamePlaceholderLabel.textColor = EXTRA_THEME_COLOR;
    
    self.firstNamePlaceholderLabel.text = NSLocalizedString(@"firstNamePlaceholder", nil);
    self.middleNamePlaceholderLabel.text = NSLocalizedString(@"middletNamePlaceholder", nil);
    self.lastNamePlaceholderLabel.text = NSLocalizedString(@"lastNamePlaceholder", nil);
    
    self.separatorView.backgroundColor = SEPARATOR_COLOR;
}

- (void)configCellWithUser:(User *)user {
    if ([TLUtils checkExistenceOfString:user.lastName]) {
        self.lastNameLabel.text = user.lastName;
        self.lastNameViewHeightConstraint.constant = 36;
    } else {
        self.lastNameViewHeightConstraint.constant = 0;
    }
    if ([TLUtils checkExistenceOfString:user.firstName]) {
        self.firstNameLabel.text = user.firstName;
        self.firstNameViewHeightConstraint.constant = 36;
    } else {
        self.firstNameViewHeightConstraint.constant = 0;
    }
    if ([TLUtils checkExistenceOfString:user.middleName]) {
        self.middleNameLabel.text = user.middleName;
        self.middleNameViewHeightConstraint.constant = 36;
    } else {
        self.middleNameViewHeightConstraint.constant = 0;
    }
}

@end
