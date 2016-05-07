//
//  UserViewController.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 07.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "UserViewController.h"
#import "UserTopTableViewCell.h"
#import "UserFullNameTableViewCell.h"
#import "UserCompanyTableViewCell.h"
#import "User.h"

#import "UIRefreshControl+Utils.h"
#import "TLNetworkManager+User.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface UserViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSNumber *userID;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) User *user;

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIScrollView *emptyScreenView;

@property (nonatomic, strong) MBProgressHUD *hud;

@end

static NSString *topCellIdentifier = @"topCellIdentifier";
static NSString *fullNameCellIdentifier = @"fullNameCellIdentifier";
static NSString *companyNameCellIdentifier = @"companyNameCellIdentifier";

@implementation UserViewController

- (instancetype)initWithUserID:(NSNumber *)userID username:(NSString *)username {
    self = [super init];
    if (self) {
        self.userID = userID;
        self.username = username;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.username;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"UserTopTableViewCell" bundle:nil] forCellReuseIdentifier:topCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"UserFullNameTableViewCell" bundle:nil] forCellReuseIdentifier:fullNameCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"UserCompanyTableViewCell" bundle:nil] forCellReuseIdentifier:companyNameCellIdentifier];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.manualRefreshControl = [[UIRefreshControl alloc] init];
    for (UIRefreshControl *ptr in @[_tableView.manualRefreshControl,
                                    _emptyScreenView.manualRefreshControl]) {
        [ptr addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
        ptr.backgroundColor = [UIColor clearColor];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refresh];
}

- (void)refresh {
    if (!self.user) {
        [self showHudView];
        self.tableView.hidden = YES;
        self.emptyScreenView.hidden = YES;
    }
    @weakify(self);
    [[TLNetworkManager sharedNetworkManager] userProfileWithID:self.userID completion:^(BOOL success, id object) {
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            @strongify(self);
            [self hideHudView];
            if (success) {
                self.user = (User *)object;
                [self.tableView reloadData];
                self.tableView.hidden = NO;
                self.emptyScreenView.hidden = YES;
            } else {
                self.user = nil;
                self.tableView.hidden = YES;
                self.emptyScreenView.hidden = NO;
            }
        }];
        for (UIScrollView *v in @[self.tableView, self.emptyScreenView])
            v.manualRefreshControl.refreshing = NO;
        [CATransaction commit];
    }];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.user) {
        return 0;
    }
    if ([self userHaveName]) {
        return 3;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UserTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCellIdentifier];
        [cell configCellWithUser:self.user];
        return cell;
    } else if (indexPath.row == 1 && [self userHaveName]) {
        UserFullNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:fullNameCellIdentifier];
        [cell configCellWithUser:self.user];
        return cell;
    }
    UserCompanyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:companyNameCellIdentifier];
    [cell configCellWithUser:self.user];
    return cell;
}

#pragma mark - HUDView
- (void)showHudView {
    [TLUtils showHudView:self.hud onView:self.view];
}

- (void)hideHudView {
    [TLUtils hideHudView:self.hud onView:self.view];
}

#pragma mark - Others
- (BOOL)userHaveName {
    return ([TLUtils checkExistenceOfString:self.user.firstName] || [TLUtils checkExistenceOfString:self.user.lastName] || [TLUtils checkExistenceOfString:self.user.middleName]);
}


@end
