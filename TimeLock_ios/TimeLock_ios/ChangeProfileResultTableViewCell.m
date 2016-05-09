//
//  ChangeProfileResultTableViewCell.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 08.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "ChangeProfileResultTableViewCell.h"
#import "UIButton+TimeLockStyle.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation ChangeProfileResultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.saveButton setButtonWithBorderStyle];
    [self.cancelButton setMainButtonStyle];
    [self.saveButton setTitle:NSLocalizedString(@"saveButtonTitle", nil) forState:UIControlStateNormal];
    [self.cancelButton setTitle:NSLocalizedString(@"cancelButtonTitle", nil) forState:UIControlStateNormal];
    [self configButton];
}

- (void)configButton {
    @weakify(self);
    [[self.saveButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.delegate saveResultButtonPressed];
    }];
    [[self.cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.delegate cancelButtonPressed];
    }];
}

@end
