//
//  CheckinTableViewCell.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 16.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "CheckinTableViewCell.h"
#import "Checkin.h"

@interface CheckinTableViewCell()

@property (nonatomic, strong) IBOutlet UILabel *checkinLabel;

@end

@implementation CheckinTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configStyle];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configWithCheckin:(Checkin *)checkin {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ru_RU_POSIX"]];
    [formatter setDateFormat:@"HH:mm"];
    NSString *dateString = [formatter stringFromDate:checkin.time];
    self.checkinLabel.text = dateString;
}

- (void)configStyle {
    self.checkinLabel.textColor = TEXT_COLOR;
    self.checkinLabel.font = CHECKIN_DESCRIPTION_FONT;
}

@end
