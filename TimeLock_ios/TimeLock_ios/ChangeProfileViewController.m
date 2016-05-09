//
//  ChangeProfileViewController.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 08.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "ChangeProfileViewController.h"
#import "ChangeProfileResultTableViewCell.h"
#import "ChangeProfileDataTableViewCell.h"
#import "User.h"

#import "BarsAppearance.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ChangeProfileViewController () <UITableViewDelegate, UITableViewDataSource, ChangeProfileResultTableViewCellDelegate>

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

static NSString * const changeProfileResultCellIdentifier = @"changeProfileResultCellIdentifier";
static NSString * const changeProfileDataCellIdentifier = @"changeProfileDataCellIdentifier";

@implementation ChangeProfileViewController

- (instancetype)initWithUser:(User *)user {
    self = [super init];
    if (self) {
        self.user = user;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"changeProfileNavBarTitle", nil);
    [self decorateBackButton];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ChangeProfileResultTableViewCell" bundle:nil] forCellReuseIdentifier:changeProfileResultCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"ChangeProfileDataTableViewCell" bundle:nil] forCellReuseIdentifier:changeProfileDataCellIdentifier];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
        ChangeProfileDataTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:changeProfileDataCellIdentifier];
        [cell configWithUser:self.user];
        return cell;
    }
    ChangeProfileResultTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:changeProfileResultCellIdentifier];
    cell.delegate = self;
    return cell;
}

#pragma mark - ChangeProfileResultTableViewCellDelegate
- (void)saveResultButtonPressed {
    NSLog(@"save button prerssed");
}

- (void)cancelButtonPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
