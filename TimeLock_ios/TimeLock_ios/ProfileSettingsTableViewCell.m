//
//  ProfileSettingsTableViewCell.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 03.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "ProfileSettingsTableViewCell.h"
#import "UIButton+TimeLockStyle.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ProfileSettingsTableViewCell()

@property (nonatomic, strong) IBOutlet UIButton *changeProfileButton;
@property (nonatomic, strong) IBOutlet UIButton *exitButton;

@end

@implementation ProfileSettingsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.changeProfileButton setButtonWithBorderStyle];
    [self.exitButton setMainButtonStyle];
    [self.changeProfileButton setTitle:NSLocalizedString(@"changeProfileButtonTitle", nil) forState:UIControlStateNormal];
    [self.exitButton setTitle:NSLocalizedString(@"exitButtonTitle", nil) forState:UIControlStateNormal];
    [self configButton];
}

- (void)configButton {
    @weakify(self);
    [[self.changeProfileButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.delegate changeProfileButtonPressed];
    }];
    [[self.exitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.delegate exitButtonPressed];
    }];
}

@end
