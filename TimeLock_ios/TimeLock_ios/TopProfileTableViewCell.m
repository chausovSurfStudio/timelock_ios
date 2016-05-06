//
//  TopProfileTableViewCell.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 03.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "TopProfileTableViewCell.h"
#import "User.h"
#import <UIImageView+AFNetworking.h>

@interface TopProfileTableViewCell()

@property (nonatomic, strong) IBOutlet UILabel *usernameLabel;
@property (nonatomic, strong) IBOutlet UIImageView *userAvatar;

@end

@implementation TopProfileTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configCellWithUser:(User *)user {
    [self.userAvatar setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:[UIImage imageNamed:@"user_placeholder.png"]];
    self.userAvatar.layer.cornerRadius = self.userAvatar.frame.size.width / 2;
    self.userAvatar.layer.masksToBounds = YES;
    self.usernameLabel.text = user.username;
}

@end
