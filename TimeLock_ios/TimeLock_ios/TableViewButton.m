//
//  TableViewButton.m
//  okey
//
//  Created by Valery Sukovykh on 27/10/15.
//  Copyright © 2015 SurfStudio. All rights reserved.
//

#import "TableViewButton.h"

@implementation TableViewButton

- (void)awakeFromNib {
    self.delaysContentTouches = NO;
    for (UIView *currentView in self.subviews) {
        if ([currentView isKindOfClass:[UIScrollView class]]) {
            ((UIScrollView *)currentView).delaysContentTouches = NO;
            break;
        }
    }
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ([view isKindOfClass:UIButton.class]) {
        return YES;
    }
    
    return [super touchesShouldCancelInContentView:view];
}

@end
