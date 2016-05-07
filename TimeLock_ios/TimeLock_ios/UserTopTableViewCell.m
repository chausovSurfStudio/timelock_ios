//
//  UserTopTableViewCell.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 07.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "UserTopTableViewCell.h"
#import "User.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface UserTopTableViewCell()

@property (nonatomic, strong) IBOutlet UIImageView *avatarImage;
@property (nonatomic, strong) IBOutlet UILabel *usernameLabel;
@property (nonatomic, strong) IBOutlet UIView *separatorView;

@end

@implementation UserTopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.usernameLabel.textColor = TEXT_COLOR;
    self.separatorView.backgroundColor = SEPARATOR_COLOR;
    self.avatarImage.layer.cornerRadius = self.avatarImage.width / 2;
    self.avatarImage.layer.masksToBounds = YES;
}

- (void)configCellWithUser:(User *)user {
    self.usernameLabel.text = user.username;
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:user.avatar]
                        placeholderImage:[UIImage imageNamed:@"user_placeholder.png"]
                                 options:SDWebImageRetryFailed
                               completed:nil];
}

@end
