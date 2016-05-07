//
//  EmptyScreenView.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 06.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "EmptyScreenView.h"
#import "UIRefreshControl+Utils.h"
#import "Const.h"

@interface EmptyScreenView()

@property (nonatomic, readwrite, strong) IBOutlet UIView *contents;
@property (nonatomic, strong) IBOutlet UILabel *errorText;
@property (nonatomic, strong) IBOutlet UILabel *helpInfoLabel;

@end

@implementation EmptyScreenView

-(void)awakeFromNib {
    [super awakeFromNib];
    self.errorText.textColor = TEXT_COLOR;
    self.helpInfoLabel.textColor = TEXT_COLOR;
    self.alwaysBounceVertical = YES;
    self.clipsToBounds = YES;
    if (_xibName)
        [[NSBundle mainBundle] loadNibNamed:_xibName owner:self options:nil];
    if (_contents) {
        [self addSubview:_contents];
        _contents.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    self.manualRefreshControl = [[UIRefreshControl alloc] init];
}

@end
