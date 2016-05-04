//
//  TLMainViewController.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 27.04.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "TLMainViewController.h"
#import "TLNetworkManager+Post.h"

#import "PostTableViewCell.h"
#import "User.h"
#import "Post.h"
#import "TLUtils.h"

#import "UIRefreshControl+Animation.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <MBProgressHUD/MBProgressHUD.h>


@interface TLMainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic,readwrite,strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSArray *posts;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

static NSString *identifier = @"postTableViewCell";

@implementation TLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"mainScreenNavBarTitle", nil);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PostTableViewCell" bundle:nil]  forCellReuseIdentifier:identifier];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    [self refresh];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)refresh {
    if (!self.posts || self.posts.count == 0) {
        [self showHudView];
    }
    [[TLNetworkManager sharedNetworkManager] postsRequestWithParam:nil completion:^(BOOL success, id object) {
        [self hideHudView];
        if (success) {
            self.posts = (NSArray *)object;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Post *post = self.posts[indexPath.row];
    User *user = post.user;
    NSLog(@"открыть экран с описанием юзера с id %@", user.userID);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    [cell configCellWithPost:self.posts[indexPath.row]];
    return cell;
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


@end
