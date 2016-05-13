//
//  TLCheckinsViewController.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 27.04.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "TLCheckinsViewController.h"
#import "TLNetworkManager+Checkin.h"

#import "UIRefreshControl+Utils.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface TLCheckinsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIScrollView *emptyScreenView;

@property (nonatomic, strong) NSDictionary *checkins;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

static NSString *identifier = @"postTableViewCell";

@implementation TLCheckinsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"checkinsScreenNavBarTitle", nil);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PostTableViewCell" bundle:nil]  forCellReuseIdentifier:identifier];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.manualRefreshControl = [[UIRefreshControl alloc] init];
    for (UIRefreshControl *ptr in @[_tableView.manualRefreshControl,
                                    _emptyScreenView.manualRefreshControl]) {
        [ptr addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
        ptr.backgroundColor = [UIColor clearColor];
    }
    
    self.page = 1;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refresh];
}

- (void)refresh {
    if (YES) {
        [self showHudView];
        self.tableView.hidden = YES;
        self.emptyScreenView.hidden = YES;
    }
    @weakify(self);
    [[TLNetworkManager sharedNetworkManager] getCheckinsPage:self.page completion:^(BOOL success, id object) {
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            @strongify(self);
            [self hideHudView];
            if (success) {
                self.checkins = (NSDictionary *)object;
                [self.tableView reloadData];
                self.tableView.hidden = NO;
                self.emptyScreenView.hidden = YES;
            } else {
                self.checkins = nil;
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
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
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
