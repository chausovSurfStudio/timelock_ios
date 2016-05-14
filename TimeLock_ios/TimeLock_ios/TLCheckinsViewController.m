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

@implementation TLCheckinsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"checkinsScreenNavBarTitle", nil);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CheckinsGraphicsTableViewCell" bundle:nil] forCellReuseIdentifier:checkinsGraphicsIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"SingleCheckinTableViewCell" bundle:nil] forCellReuseIdentifier:singleCheckinIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"NoteTableViewCell" bundle:nil] forCellReuseIdentifier:noteIdentifier];
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
    return [TLUtils viewForheaderInCheckinsTableWithDate:[self dateForSection:section]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CHECKINS_HEADER_HEIGHT;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
    self.topLabel.font = SECTION_HEADER_FONT_BOLD;
    self.topLabel.textAlignment = NSTextAlignmentCenter;
    
    self.rightButton.backgroundColor = [UIColor clearColor];
    self.leftButton.backgroundColor = [UIColor clearColor];
}

- (void)refreshTopView {
    NSDate *monday = [self dateForSection:0];
    NSDate *sunday = [self dateForSection:6];
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
    switch (section) {
        case 0:
            return self.resultDict[mondayString][2];
            break;
        case 1:
            return self.resultDict[tuesdayString][2];
            break;
        case 2:
            return self.resultDict[wednesdayString][2];
            break;
        case 3:
            return self.resultDict[thursdayString][2];
            break;
        case 4:
            return self.resultDict[fridayString][2];
            break;
        case 5:
            return self.resultDict[saturdayString][2];
            break;
        case 6:
            return self.resultDict[sundayString][2];
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)keyForSection:(NSInteger)section {
    switch (section) {
        case 0:
            return mondayString;
            break;
        case 1:
            return tuesdayString;
            break;
        case 2:
            return wednesdayString;
            break;
        case 3:
            return thursdayString;
            break;
        case 4:
            return fridayString;
            break;
        case 5:
            return saturdayString;
            break;
        case 6:
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

@end
