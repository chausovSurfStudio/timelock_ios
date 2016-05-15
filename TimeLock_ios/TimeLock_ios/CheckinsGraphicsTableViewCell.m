//
//  CheckinsGraphicsTableViewCell.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 14.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "CheckinsGraphicsTableViewCell.h"
#import "GraphView.h"
#import "Checkin.h"

@interface CheckinsGraphicsTableViewCell() <GraphViewDataSource>

@property (nonatomic, strong) IBOutlet UILabel *emptyDayLabel;
@property (nonatomic, strong) IBOutlet GraphView *graphView;
@property (nonatomic, strong) NSArray *checkins;

@end

@implementation CheckinsGraphicsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configStyle];
    self.graphView.dataSource = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    self.graphView.backgroundColor = highlighted ? HIGHLIGHTED_CELL_COLOR : [UIColor whiteColor];
}

- (void)configWithCheckins:(NSArray *)checkins {
    if (checkins.count == 0) {
        self.emptyDayLabel.hidden = NO;
        self.graphView.hidden = YES;
    } else {
        self.emptyDayLabel.hidden = YES;
        self.graphView.hidden = NO;
    }
    self.checkins = checkins;
    [self.graphView setNeedsDisplay];
}

- (void)configStyle {
    self.emptyDayLabel.textColor = TEXT_COLOR;
    self.emptyDayLabel.font = SINGLE_CHECKIN_DESCRIPTION_FONT;
    self.emptyDayLabel.text = NSLocalizedString(@"emptyDay", nil);
}

#pragma mark - GraphViewDataSource
- (NSArray *)checkinsForGraphView {
    return self.checkins;
}

@end
