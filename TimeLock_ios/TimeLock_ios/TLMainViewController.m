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
#import "EmptyScreenView.h"

#import "UIRefreshControl+Utils.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <MBProgressHUD/MBProgressHUD.h>


@interface TLMainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIScrollView *emptyScreenView;

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
    if (!self.posts || self.posts.count == 0) {
        [self showHudView];
        self.tableView.hidden = YES;
        self.emptyScreenView.hidden = YES;
    }
    @weakify(self);
    [[TLNetworkManager sharedNetworkManager] postsRequestWithParam:nil completion:^(BOOL success, id object) {
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            @strongify(self);
            [self hideHudView];
            if (success) {
                self.posts = (NSArray *)object;
                [self.tableView reloadData];
                self.tableView.hidden = NO;
                self.emptyScreenView.hidden = YES;
            } else {
                self.posts = nil;
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
    [TLUtils showHudView:self.hud onView:self.view];
}

- (void)hideHudView {
    [TLUtils hideHudView:self.hud onView:self.view];
}


@end
