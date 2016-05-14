//
//  NoteTableViewCell.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 14.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "NoteTableViewCell.h"
#import "Note.h"

@interface NoteTableViewCell()

@property (nonatomic, strong) IBOutlet UIView *backView;
@property (nonatomic, strong) IBOutlet UILabel *noteLabel;

@end

@implementation NoteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configStyle];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configWithNote:(Note *)note {
    self.noteLabel.text = note.body;
}

- (void)configStyle {
    self.backView.backgroundColor = EXTRA_THEME_COLOR;
    self.backView.layer.cornerRadius = 5.0f;
    self.noteLabel.textColor = TEXT_COLOR_LIGHT;
    self.noteLabel.font = NOTE_FONT;
}

@end
