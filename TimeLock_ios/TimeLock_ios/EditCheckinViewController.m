//
//  EditCheckinViewController.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 16.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "EditCheckinViewController.h"
#import "Checkin.h"

#import "UIButton+TimeLockStyle.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface EditCheckinViewController ()

@property (nonatomic, strong) Checkin *checkin;
@property (nonatomic, strong) void (^completion)();

@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) IBOutlet UIButton *saveButton;
@property (nonatomic, strong) IBOutlet UIButton *cancelButton;
@property (nonatomic, strong) IBOutlet UIView *firstSeparatorView;
@property (nonatomic, strong) IBOutlet UIView *secondSeparatorView;
@property (nonatomic, strong) IBOutlet UIView *backWhiteView;

@end

@implementation EditCheckinViewController

- (instancetype)initWithCheckin:(Checkin *)checkin completion:(void (^)())completion {
    self = [super init];
    if (self) {
        self.checkin = checkin;
        self.completion = completion;
    }
    return self;
}

- (instancetype)initToCreateNewCheckinWithCompletion:(void (^)())completion {
    self = [super init];
    if (self) {
        self.checkin = nil;
        self.completion = completion;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configStyle];
    [self configButton];
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
        self.datePicker.date = [NSDate date];
    }
}

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

- (void)saveChanges {
    if (self.checkin && self.checkin.checkinID) {
        NSLog(@"изменяем чекин");
        [self complete];
    } else {
        NSLog(@"создаем чекин");
        [self complete];
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
