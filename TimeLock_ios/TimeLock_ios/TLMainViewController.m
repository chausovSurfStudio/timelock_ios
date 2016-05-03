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


@interface TLMainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *posts;

@end

static NSString *identifier = @"postTableViewCell";

@implementation TLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"mainScreenNavBarTitle", nil);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PostTableViewCell" bundle:nil]  forCellReuseIdentifier:identifier];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self refresh];
}

- (void)refresh {
    [[TLNetworkManager sharedNetworkManager] postsRequestWithParam:nil completion:^(BOOL success, id object) {
        if (success) {
            self.posts = (NSArray *)object;
            [self.tableView reloadData];
        } else {
            NSLog(@"some error with posts");
        }
    }];
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Post *post = self.posts[indexPath.row];
    User *user = post.user;
    NSLog(@"открыть экран с описанием юзера с id %@", user.id_);
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    [cell configCellWithPost:self.posts[indexPath.row]];
    return cell;
}


@end
