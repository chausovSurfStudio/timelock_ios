//
//  BarAppearance.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 27.04.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "BarsAppearance.h"
#import <UIKit/UIKit.h>

@implementation UIViewController (BarsAppearance)

+ (void)load {
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.translucent = NO;
    navBar.barTintColor = NAVIGATION_BAR_COLOR;
    navBar.tintColor = [UIColor whiteColor];
    navBar.titleTextAttributes = @{
                                   NSForegroundColorAttributeName:[UIColor whiteColor],
                                   NSFontAttributeName: [UIFont fontWithName:@"PTSans-Bold" size:18],
                                   };
    
    UITabBar *tabBar = [UITabBar appearance];
    tabBar.tintColor = TAB_BAR_COLOR;
}

-(void)popFromNavigationController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)decorateBackButton {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icBack"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(popFromNavigationController)];
    self.navigationItem.leftBarButtonItem = backButton;
}

@end
