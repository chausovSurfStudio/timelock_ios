//
//  SingleCheckinTableViewCell.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 14.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "SingleCheckinTableViewCell.h"
#import "Checkin.h"

static NSString * const shortTimeFormat = @"HH:mm:ss";

@interface SingleCheckinTableViewCell()

@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;

@end

@implementation SingleCheckinTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configLabelStyle];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configWithCheckin:(Checkin *)checkin isSolo:(BOOL)isSolo {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ru_RU_POSIX"]];
    [formatter setDateFormat:shortTimeFormat];
    NSString *timeString = [formatter stringFromDate:checkin.time];
    self.timeLabel.text = timeString;
    if (isSolo) {
        self.descriptionLabel.text = NSLocalizedString(@"soloCheckin", nil);
    } else {
        self.descriptionLabel.text = NSLocalizedString(@"oneMoreCheckin", nil);
    }
}

- (void)configLabelStyle {
    self.descriptionLabel.textColor = TEXT_COLOR;
    self.timeLabel.textColor = EXTRA_THEME_COLOR;
    self.descriptionLabel.font = SINGLE_CHECKIN_DESCRIPTION_FONT;
    self.timeLabel.font = SINGLE_CHECKIN_TIME_FONT;
}

@end
