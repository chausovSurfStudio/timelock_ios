//
//  PostTableViewCell.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 03.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "PostTableViewCell.h"
#import "Post.h"
#import "User.h"
#import "Const.h"

#import <UIImageView+AFNetworking.h>
#import "FrameAccessor.h"

@interface PostTableViewCell()

@property (nonatomic, strong) IBOutlet UIImageView *userAvatar;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UILabel *postTextLabel;
@property (nonatomic, strong) IBOutlet UILabel *usernameLabel;

@end

@implementation PostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.timeLabel.textColor = TEXT_COLOR_EXTRA;
    self.usernameLabel.textColor = TEXT_COLOR;
    self.postTextLabel.textColor = TEXT_COLOR;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configCellWithPost:(Post *)post {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ru_RU_POSIX"]];
    [formatter setDateFormat:@"dd.MM.yyyy HH:mm"];
    self.timeLabel.text = [formatter stringFromDate:post.timestamp];
    self.postTextLabel.text = post.body;
    [self.userAvatar setImageWithURL:[NSURL URLWithString:post.user.avatar]];
    self.userAvatar.layer.cornerRadius = self.userAvatar.width / 2;
    self.userAvatar.layer.masksToBounds = YES;
    self.usernameLabel.text = post.user.username;
}

@end
