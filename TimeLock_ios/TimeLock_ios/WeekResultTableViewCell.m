//
//  WeekResultTableViewCell.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 15.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "WeekResultTableViewCell.h"

@interface WeekResultTableViewCell()

@property (nonatomic, strong) IBOutlet UILabel *resultLabel;

@end

@implementation WeekResultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configWithTime:(NSNumber *)time {
    NSDictionary *dict = @{
                           NSForegroundColorAttributeName:TEXT_COLOR,
                           NSFontAttributeName:SECTION_HEADER_FONT,
                           };
    if (time && [time integerValue] != 0) {
        NSString *resultDescription = NSLocalizedString(@"weekResultExists", nil);
        NSString *resultTime = [TLUtils formatTimeStringForMinutes:time];
        NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", resultDescription, resultTime]
                                                                                   attributes:dict];
        [result addAttribute:NSFontAttributeName value:SECTION_HEADER_FONT_BOLD range:NSMakeRange(result.length - resultTime.length, resultTime.length)];
        self.resultLabel.attributedText = result;
    } else {
        NSAttributedString *result = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"weekResultEmpty", nil) attributes:dict];
        self.resultLabel.attributedText = result;
    }
}

@end
