//
//  CheckinsListViewController.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 16.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "CheckinsListViewController.h"
#import "CheckinTableViewCell.h"
#import "BarsAppearance.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface CheckinsListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) void (^completion)();
@property (nonatomic, strong) NSArray *checkins;
@property (nonatomic, strong) NSDate *date;

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIView *emptyScreenView;
@property (nonatomic, strong) IBOutlet UILabel *emptyLabel;
@property (nonatomic, strong) IBOutlet UIButton *addButton;

@end

static NSString *checkinIdentifier = @"checkinIdentifier";

@implementation CheckinsListViewController

- (instancetype)initWithCheckins:(NSArray *)checkins date:(NSDate *)date completeion:(void (^)())completion {
    self = [super init];
    if (self) {
        self.completion = completion;
        self.date = date;
        self.checkins = checkins;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitleWithDate:self.date];
    [self decorateBackButton];
    [self.tableView registerNib:[UINib nibWithNibName:@"CheckinTableViewCell" bundle:nil] forCellReuseIdentifier:checkinIdentifier];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.contentInsetBottom = 49;
    [self configEmptyScreen];
    [self configButton];
    [self refresh];
}

- (void)setNavigationTitleWithDate:(NSDate *)date {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ru_RU_POSIX"]];
    [formatter setDateFormat:@"EEEE, d MMMM, yyyy"];
    NSString *dateString = [formatter stringFromDate:date];
    self.navigationItem.title = [dateString capitalizedString];
}

- (void)refresh {
    if (self.checkins && self.checkins.count > 0) {
        self.tableView.hidden = NO;
        self.emptyScreenView.hidden = YES;
    } else {
        self.tableView.hidden = YES;
        self.emptyScreenView.hidden = NO;
    }
}

#pragma mark - Config
- (void)configEmptyScreen {
    self.emptyLabel.textColor = TEXT_COLOR;
    self.emptyLabel.font = EMPTY_CHECKINS_LIST_FONT;
    self.emptyLabel.text = NSLocalizedString(@"emptyCheckinsList", nil);
    self.emptyLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)configButton {
    @weakify(self);
    [[self.addButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"add button pressed");
    }];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.checkins.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CheckinTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:checkinIdentifier];
    [cell configWithCheckin:self.checkins[indexPath.row]];
    return cell;
}

#pragma mark - Others
- (void)complete {
    if (self.completion) {
        self.completion();
    }
}

@end
