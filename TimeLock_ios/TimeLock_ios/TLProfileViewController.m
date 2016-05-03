//
//  TLProfileViewController.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 27.04.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "TLProfileViewController.h"
#import "TopProfileTableViewCell.h"
#import "ProfileSettingsTableViewCell.h"
#import "User.h"

#import "TLUtils.h"
#import "TLNetworkManager+Authorization.h"
#import "TLNetworkManager+Post.h"
#import "UIRefreshControl+Animation.h"
#import "AppDelegate.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface TLProfileViewController () <UITableViewDelegate, UITableViewDataSource, ProfileSettingsTableViewCellDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic,readwrite,strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

static NSString * const topCellIdentifier = @"topCellIdentifier";
static NSString * const settingsCellIdentifier = @"settingsCellIdentifier";

@implementation TLProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"profileScreenNavBarTitle", nil);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TopProfileTableViewCell" bundle:nil]  forCellReuseIdentifier:topCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"ProfileSettingsTableViewCell" bundle:nil]  forCellReuseIdentifier:settingsCellIdentifier];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

- (void)viewWillAppear:(BOOL)animated {
    [self refresh];
}

- (void)refresh {
    if (!self.user) {
        [self showHudView];
    }
    [[TLNetworkManager sharedNetworkManager] currentUserProfileWithCompletion:^(BOOL success, id object) {
        [self hideHudView];
        if (success) {
            self.user = (User *)object;
            [self.tableView reloadData];
            [self.refreshControl smoothEndRefreshing];
        } else {
            NSLog(@"some error with posts");
        }
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        TopProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCellIdentifier];
        [cell configCellWithUser:self.user];
        return cell;
    } else {
        ProfileSettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingsCellIdentifier];
        cell.delegate = self;
        return cell;
    }
}



#pragma mark - HUDView
- (void)showHudView {
    self.tableView.hidden = YES;
    [TLUtils showHudView:self.hud onView:self.view];
}

- (void)hideHudView {
    self.tableView.hidden = NO;
    [TLUtils hideHudView:self.hud onView:self.view];
}

#pragma mark - ProfileSettingsTableViewCellDelegate
- (void)changeProfileButtonPressed {
    NSLog(@"changeProfileButtonPressed");
}

- (void)exitButtonPressed {
    [TLUtils setObjectToUserSettings:nil forKey:@"token"];
    [TLUtils setObjectToUserSettings:nil forKey:@"email"];
    [TLUtils setObjectToUserSettings:nil forKey:@"password"];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate openLaunchLoginScreen];
}

@end
