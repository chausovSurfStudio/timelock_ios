//
//  CheckinsGraphicsTableViewCell.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 14.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "CheckinsGraphicsTableViewCell.h"
#import "Checkin.h"

@interface CheckinsGraphicsTableViewCell()

@property (nonatomic, strong) IBOutlet UILabel *emptyDayLabel;
@property (nonatomic, strong) IBOutlet UIView *graphView;

@end

@implementation CheckinsGraphicsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configStyle];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configWithCheckins:(NSArray *)checkins {
    if (checkins.count == 0) {
        self.emptyDayLabel.hidden = NO;
        self.graphView.hidden = YES;
    } else {
        self.emptyDayLabel.hidden = YES;
        self.graphView.hidden = NO;
    }
}

- (void)configStyle {
    self.emptyDayLabel.textColor = TEXT_COLOR;
    self.emptyDayLabel.font = SINGLE_CHECKIN_DESCRIPTION_FONT;
    self.emptyDayLabel.text = NSLocalizedString(@"emptyDay", nil);
}

@end
