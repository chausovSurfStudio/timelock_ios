//
//  UIButton+TimeLockStyle.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 27.04.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "UIButton+TimeLockStyle.h"
#import "UIImage+Utilities.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIButton (TimeLockStyle)

- (void)setButtonWithBorderStyle {
    [self setBackgroundColor:[UIColor clearColor]];
    [self setBackgroundImage:[UIImage imageFromColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageFromColor:EXTRA_THEME_COLOR_PRESSED] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageFromColor:EXTRA_THEME_COLOR_PRESSED] forState:UIControlStateSelected];
    
    [self setTitleColor:BORDER_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    [self setTitleColor:BORDER_BUTTON_TEXT_COLOR_PRESSED forState:UIControlStateSelected];
    [self setTitleColor:BORDER_BUTTON_TEXT_COLOR_PRESSED forState:UIControlStateHighlighted];
    [self setTitleColor:BORDER_BUTTON_TEXT_COLOR_DISABLED forState:UIControlStateDisabled];
    
    [self.layer setBorderWidth:1.0f];
    [self.layer setBorderColor:EXTRA_THEME_COLOR.CGColor];
    
    self.titleLabel.font = BUTTON_FONT;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = CORNER_RADIUS;
}

- (void)setMainButtonStyle {
    [self setBackgroundColor:[UIColor clearColor]];
    [self setBackgroundImage:[UIImage imageFromColor:EXTRA_THEME_COLOR] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageFromColor:EXTRA_THEME_COLOR_PRESSED] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageFromColor:EXTRA_THEME_COLOR_PRESSED] forState:UIControlStateSelected];
    
    [self setTitleColor:MAIN_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    [self setTitleColor:MAIN_BUTTON_TEXT_COLOR_PRESSED forState:UIControlStateSelected];
    [self setTitleColor:MAIN_BUTTON_TEXT_COLOR_PRESSED forState:UIControlStateHighlighted];
    
    self.titleLabel.font = BUTTON_FONT;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = CORNER_RADIUS;
}

- (void)setWhiteButtonWithoutBorderStyle {
    [self setBackgroundColor:[UIColor clearColor]];
    [self setBackgroundImage:[UIImage imageFromColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageFromColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageFromColor:[UIColor whiteColor]] forState:UIControlStateSelected];
    
    [self setTitleColor:WHITE_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    [self setTitleColor:WHITE_BUTTON_TEXT_COLOR_PRESSED forState:UIControlStateSelected];
    [self setTitleColor:WHITE_BUTTON_TEXT_COLOR_PRESSED forState:UIControlStateHighlighted];
    
    self.titleLabel.font = BUTTON_FONT;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.clipsToBounds = YES;
}

@end
