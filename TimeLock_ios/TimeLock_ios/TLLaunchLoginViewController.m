//
//  TLLaunchLoginViewController.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 27.04.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "TLLaunchLoginViewController.h"
#import "Const.h"
#import "TLUtils.h"
#import "UIButton+TimeLockStyle.h"
#import "TLNetworkManager+Authorization.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "FrameAccessor.h"

static const CGFloat ANIMATION_DURATION = 0.5f;

@interface TLLaunchLoginViewController ()

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIView *loginView;
@property (nonatomic, strong) IBOutlet UITextField *emailTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) IBOutlet UIButton *loginButton;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *loginViewTopConstraint;

@end

@implementation TLLaunchLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configButtons];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configStyle];
    [self configTitles];
    self.loginView.alpha = 0.0f;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:ANIMATION_DURATION
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.titleLabel.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:ANIMATION_DURATION
                                               delay:0
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              self.loginView.alpha = 1.0f;
                                              self.loginView.top = 100;
                                          }
                                          completion:^(BOOL finished) {
                                              self.loginViewTopConstraint.constant = 100;
                                          }];
                     }];
}

- (void)complete {
    if (self.completion)
        self.completion();
    self.completion = nil;
}

- (void)configStyle {
    self.view.backgroundColor = MAIN_THEME_COLOR;
    self.loginView.backgroundColor = MAIN_THEME_COLOR;
    [self.loginButton setMainButtonStyle];
    self.emailTextField.tintColor = TEXT_FIELD_TINT_COLOR;
    self.passwordTextField.tintColor = TEXT_FIELD_TINT_COLOR;
    self.emailTextField.textColor = TEXT_FIELD_TEXT_COLOR;
    self.passwordTextField.textColor = TEXT_FIELD_TEXT_COLOR;
    
}

- (void)configTitles {
    self.loginButton.titleLabel.text = NSLocalizedString(@"loginButton", nil);
    self.emailTextField.placeholder = NSLocalizedString(@"emailPlaceholder", nil);
    self.passwordTextField.placeholder = NSLocalizedString(@"passwordPlaceholder", nil);
}

- (void)configButtons {
    @weakify(self);
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        @weakify(self);
        [TLUtils setObjectToUserSettings:self.emailTextField.text forKey:@"email"];
        [TLUtils setObjectToUserSettings:self.passwordTextField.text forKey:@"password"];
        [TLUtils setObjectToUserSettings:needRelogin forKey:needRelogin];
        [[TLNetworkManager sharedNetworkManager] authorizationRequestParam:nil completion:^(BOOL success, id object) {
            @strongify(self);
            [TLUtils setObjectToUserSettings:nil forKey:needRelogin];
            if (success && [object isKindOfClass:[NSDictionary class]]) {
                [TLUtils setObjectToUserSettings:object[@"token"] forKey:@"token"];
                NSLog(@"token = %@", [TLUtils objectFromUserSettingsForKey:@"token"]);
                [self complete];
            } else {
                NSLog(@"baaaad");
            }
        }];
    }];
}

@end
