//
//  TLCheckinsViewController.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 27.04.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "TLCheckinsViewController.h"
#import "TLNetworkManager+Checkin.h"
#import "CheckinsGraphicsTableViewCell.h"
#import "SingleCheckinTableViewCell.h"
#import "NoteTableViewCell.h"
#import "WeekResultTableViewCell.h"

#import "UIRefreshControl+Utils.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface TLCheckinsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIView *topView;
@property (nonatomic, strong) IBOutlet UIView *borderView;
@property (nonatomic, strong) IBOutlet UILabel *topLabel;
@property (nonatomic, strong) IBOutlet UIButton *rightButton;
@property (nonatomic, strong) IBOutlet UIButton *leftButton;
@property (nonatomic, strong) IBOutlet UIScrollView *emptyScreenView;

@property (nonatomic, strong) NSDictionary *resultDict;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

static NSString *checkinsGraphicsIdentifier = @"checkinsGraphicsIdentifier";
static NSString *singleCheckinIdentifier = @"singleCheckinIdentifier";
static NSString *noteIdentifier = @"noteIdentifier";
static NSString *weekResultIdentifier = @"weekResultIdentifier";

@implementation TLCheckinsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"checkinsScreenNavBarTitle", nil);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CheckinsGraphicsTableViewCell" bundle:nil] forCellReuseIdentifier:checkinsGraphicsIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"SingleCheckinTableViewCell" bundle:nil] forCellReuseIdentifier:singleCheckinIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"NoteTableViewCell" bundle:nil] forCellReuseIdentifier:noteIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"WeekResultTableViewCell" bundle:nil] forCellReuseIdentifier:weekResultIdentifier];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.contentInsetBottom = 49;
    
    self.tableView.manualRefreshControl = [[UIRefreshControl alloc] init];
    for (UIRefreshControl *ptr in @[_tableView.manualRefreshControl,
                                    _emptyScreenView.manualRefreshControl]) {
        [ptr addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
        ptr.backgroundColor = [UIColor clearColor];
    }
    
    self.page = 1;
    [self configStyleOfTopView];
    [self configButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refresh];
}

- (void)refresh {
    if (!self.resultDict) {
        [self showHudView];
        self.tableView.hidden = YES;
        self.topView.hidden = YES;
        self.emptyScreenView.hidden = YES;
    }
    @weakify(self);
    [[TLNetworkManager sharedNetworkManager] getCheckinsPage:self.page completion:^(BOOL success, id object) {
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            @strongify(self);
            [self hideHudView];
            if (success) {
                self.resultDict = (NSDictionary *)object;
                [self refreshTopView];
                [self.tableView reloadData];
                self.tableView.hidden = NO;
                self.topView.hidden = NO;
                self.emptyScreenView.hidden = YES;
            } else {
                self.resultDict = nil;
                self.tableView.hidden = YES;
                self.topView.hidden = YES;
                self.emptyScreenView.hidden = NO;
            }
        }];
        for (UIScrollView *v in @[self.tableView, self.emptyScreenView])
            v.manualRefreshControl.refreshing = NO;
        [CATransaction commit];
    }];
}

- (void)configButton {
    @weakify(self);
    [[self.leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        self.page += 1;
        self.resultDict = nil;
        [self refresh];
    }];
    [[self.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        self.page -= 1;
        self.resultDict = nil;
        [self refresh];
    }];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return section == 0 ? nil : [TLUtils viewForheaderInCheckinsTableWithDate:[self dateForSection:section] andTime:[self timeForSection:section]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0.001f : CHECKINS_HEADER_HEIGHT;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return NO;
    }
    if ([self isRowWithGraphicsInIndexPath:indexPath]) {
        return YES;
    }
    if ([self isRowWithSingleCheckinInIndexPath:indexPath]) {
        return YES;
    }
    return NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    NSArray *checkins = self.resultDict[[self keyForSection:section]][0];
    NSArray *notes = self.resultDict[[self keyForSection:section]][1];
    NSInteger result = 0;
    if ([self needShowGraphicsInSection:section]) {
        result += 1;
    }
    if (checkins.count % 2 == 1) {
        result += 1;
    }
    if (notes.count > 0) {
        result += notes.count;
    }
    return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *checkins = self.resultDict[[self keyForSection:indexPath.section]][0];
    NSArray *notes = self.resultDict[[self keyForSection:indexPath.section]][1];
    if (indexPath.section == 0) {
        WeekResultTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:weekResultIdentifier];
        [cell configWithTime:self.resultDict[@"resultTime"]];
        return cell;
    }
    if (indexPath.row == 0) {
        if ([self needShowGraphicsInSection:indexPath.section]) {
            CheckinsGraphicsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:checkinsGraphicsIdentifier];
            [cell configWithCheckins:checkins];
            return cell;
        }
        if (checkins.count % 2 == 1) {
            SingleCheckinTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:singleCheckinIdentifier];
            [cell configWithCheckin:checkins.lastObject isSolo:(checkins.count == 1)];
            return cell;
        }
    }
    if ((checkins.count % 2 == 1) && (indexPath.row == 1)) {
        SingleCheckinTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:singleCheckinIdentifier];
        [cell configWithCheckin:checkins.lastObject isSolo:(checkins.count == 1)];
        return cell;
    }
    NSInteger index = indexPath.row;
    if ([self needShowGraphicsInSection:indexPath.section]) {
        index -= 1;
    }
    if (checkins.count % 2 == 1) {
        index -= 1;
    }
    NoteTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:noteIdentifier];
    [cell configWithNote:notes[index]];
    return cell;
}

#pragma mark - TopView
- (void)configStyleOfTopView {
    self.topView.backgroundColor = MAIN_THEME_COLOR;
    self.borderView.backgroundColor = MAIN_THEME_COLOR;
    
    [self.borderView.layer setBorderColor:EXTRA_THEME_COLOR.CGColor];
    [self.borderView.layer setCornerRadius:CORNER_RADIUS];
    [self.borderView.layer setBorderWidth:1.0f];
    self.borderView.clipsToBounds = YES;
    
    self.topLabel.textColor = TEXT_COLOR_LIGHT;
    self.topLabel.font = SECTION_HEADER_FONT;
    self.topLabel.textAlignment = NSTextAlignmentCenter;
    
    self.rightButton.backgroundColor = [UIColor clearColor];
    self.leftButton.backgroundColor = [UIColor clearColor];
}

- (void)refreshTopView {
    NSDate *monday = [self dateForSection:1];
    NSDate *sunday = [self dateForSection:7];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ru_RU_POSIX"]];
    [formatter setDateFormat:@"d MMMM"];
    NSString *mondayDateString = [formatter stringFromDate:monday];
    NSString *sundayDateString = [formatter stringFromDate:sunday];
    self.topLabel.text = [NSString stringWithFormat:@"%@ - %@", [mondayDateString capitalizedString], [sundayDateString capitalizedString]];
}

#pragma mark - HUDView
- (void)showHudView {
    [TLUtils showHudView:self.hud onView:self.view];
}

- (void)hideHudView {
    [TLUtils hideHudView:self.hud onView:self.view];
}

#pragma mark - Others
- (NSDate *)dateForSection:(NSInteger)section {
    // нулевая секция отведена под результат недели
    switch (section) {
        case 1:
            return self.resultDict[mondayString][2];
            break;
        case 2:
            return self.resultDict[tuesdayString][2];
            break;
        case 3:
            return self.resultDict[wednesdayString][2];
            break;
        case 4:
            return self.resultDict[thursdayString][2];
            break;
        case 5:
            return self.resultDict[fridayString][2];
            break;
        case 6:
            return self.resultDict[saturdayString][2];
            break;
        case 7:
            return self.resultDict[sundayString][2];
            break;
        default:
            return nil;
            break;
    }
}

- (NSNumber *)timeForSection:(NSInteger)section {
    NSNumber *time = self.resultDict[[self keyForSection:section]][3];
    if (time) {
        return time;
    }
    return @(0);
}

- (NSString *)keyForSection:(NSInteger)section {
    // нулевая секция отведена под результат недели
    switch (section) {
        case 1:
            return mondayString;
            break;
        case 2:
            return tuesdayString;
            break;
        case 3:
            return wednesdayString;
            break;
        case 4:
            return thursdayString;
            break;
        case 5:
            return fridayString;
            break;
        case 6:
            return saturdayString;
            break;
        case 7:
            return sundayString;
            break;
        default:
            return mondayString;
            break;
    }
}

- (BOOL)needShowGraphicsInSection:(NSInteger)section {
    NSArray *checkins = self.resultDict[[self keyForSection:section]][0];
    return (checkins.count == 0 || checkins.count >= 2);
}

- (BOOL)isRowWithGraphicsInIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.row == 0 && [self needShowGraphicsInSection:indexPath.section]);
}

- (BOOL)isRowWithSingleCheckinInIndexPath:(NSIndexPath *)indexPath {
    NSArray *checkins = self.resultDict[[self keyForSection:indexPath.section]][0];
    if (indexPath.row == 0 && checkins.count == 1) {
        return YES;
    } else if ((checkins.count % 2 == 1) && (indexPath.row == 1)) {
        return YES;
    }
    return NO;
}

@end
