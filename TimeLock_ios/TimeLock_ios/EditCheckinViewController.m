//
//  EditCheckinViewController.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 16.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "EditCheckinViewController.h"
#import "Checkin.h"
#import "AlertViewController.h"

#import "UIButton+TimeLockStyle.h"
#import "TLNetworkManager+Checkin.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface EditCheckinViewController ()

@property (nonatomic, strong) Checkin *checkin;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) void (^completion)();

@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) IBOutlet UIButton *saveButton;
@property (nonatomic, strong) IBOutlet UIButton *cancelButton;
@property (nonatomic, strong) IBOutlet UIView *firstSeparatorView;
@property (nonatomic, strong) IBOutlet UIView *secondSeparatorView;
@property (nonatomic, strong) IBOutlet UIView *backWhiteView;

@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) IBOutlet UIView *hudView;

@end

@implementation EditCheckinViewController

- (instancetype)initWithCheckin:(Checkin *)checkin completion:(void (^)())completion {
    self = [super init];
    if (self) {
        self.checkin = checkin;
        self.date = nil;
        self.completion = completion;
    }
    return self;
}

- (instancetype)initToCreateNewCheckinWithDate:(NSDate *)date completion:(void (^)())completion {
    self = [super init];
    if (self) {
        self.checkin = nil;
        self.date = date;
        self.completion = completion;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configStyle];
    [self configButton];
    self.hudView.hidden = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(simpleComplete)];
    [self.view addGestureRecognizer:tapGesture];
    self.datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"ru_RU_POSIX"];
    self.datePicker.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.checkin && self.checkin.time) {
        self.datePicker.date = self.checkin.time;
    } else {
        NSDate *currentDate = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *needDateComponents = [calendar components: NSUIntegerMax fromDate:self.date];
        NSDateComponents *currerntDateComponents = [calendar components: NSUIntegerMax fromDate:currentDate];
        [needDateComponents setHour:currerntDateComponents.hour];
        [needDateComponents setMinute:currerntDateComponents.minute];
        [needDateComponents setSecond:currerntDateComponents.second];
        NSDate *newDate = [calendar dateFromComponents:needDateComponents];
        self.datePicker.date = newDate;
    }
}

#pragma mark - Config
- (void)configStyle {
    [self.cancelButton setWhiteButtonWithoutBorderStyle];
    [self.saveButton setWhiteButtonWithoutBorderStyle];
    [self.cancelButton setTitle:NSLocalizedString(@"cancelButtonTitle", nil) forState:UIControlStateNormal];
    [self.saveButton setTitle:NSLocalizedString(@"saveButtonTitle", nil) forState:UIControlStateNormal];
    self.firstSeparatorView.backgroundColor = SEPARATOR_COLOR;
    self.secondSeparatorView.backgroundColor = SEPARATOR_COLOR;
    self.backWhiteView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    self.backWhiteView.layer.cornerRadius = 5.0f;
    [self.view setBackgroundColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.95f]];
}

- (void)configButton {
    @weakify(self);
    [[self.cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self simpleComplete];
    }];
    [[self.saveButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self saveChanges];
    }];
}

#pragma mark - HUDView
- (void)showHudView {
    self.hudView.hidden = NO;
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [TLUtils showHudView:self.hud onView:self.hudView];
}

- (void)hideHudView {
    self.hudView.hidden = YES;
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    [TLUtils hideHudView:self.hud onView:self.hudView];
}

#pragma mark - Actions
- (void)saveChanges {
    [self showHudView];
    if (self.checkin && self.checkin.checkinID) {
        @weakify(self);
        [[TLNetworkManager sharedNetworkManager] updateCheckinWithID:self.checkin.checkinID date:self.datePicker.date completion:^(BOOL success, id object) {
            @strongify(self);
            [self hideHudView];
            if (success) {
                [[AlertViewController sharedInstance] showInfoAlert:NSLocalizedString(@"successUpdateCheckin", nil) animation:YES autoHide:YES];
                [self complete];
            } else {
                // ошибка обработается на уровне запроса, экран не будет закрыт
            }
        }];
    } else {
        @weakify(self);
        [[TLNetworkManager sharedNetworkManager] createCheckinWithDate:self.datePicker.date completion:^(BOOL success, id object) {
            @strongify(self);
            [self hideHudView];
            if (success) {
                [[AlertViewController sharedInstance] showInfoAlert:NSLocalizedString(@"successCreateCheckin", nil) animation:YES autoHide:YES];
                [self complete];
            } else {
                // ошибка обработается на уровне запроса, экран не будет закрыт
            }
        }];
    }
}

- (void)complete {
    if (self.completion) {
        self.completion();
    }
    self.completion = nil;
}

- (void)simpleComplete {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
