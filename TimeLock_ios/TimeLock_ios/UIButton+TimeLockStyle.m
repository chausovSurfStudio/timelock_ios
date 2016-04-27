//
//  UIButton+TimeLockStyle.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 27.04.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "UIButton+TimeLockStyle.h"
#import "UIImage+Utilities.h"
#import "Const.h"

@implementation UIButton (TimeLockStyle)

- (void)setMainGreenStyle {
    self.backgroundColor = [UIColor clearColor];
    [self setBackgroundImage:[UIImage imageFromColor:MAIN_GREEN_COLOR] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageFromColor:MAIN_GREEN_COLOR_PRESSED] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageFromColor:MAIN_GREEN_COLOR_PRESSED] forState:UIControlStateSelected];
    
    [self setTitleColor:GREEN_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    [self setTitleColor:GREEN_BUTTON_TEXT_COLOR forState:UIControlStateSelected];
    [self setTitleColor:GREEN_BUTTON_TEXT_COLOR forState:UIControlStateHighlighted];
    
    self.titleLabel.font = BUTTON_FONT;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5;
}

@end
