//
//  TLMainViewController.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 27.04.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "TLMainViewController.h"
#import "TLNetworkManager+Post.h"

@interface TLMainViewController ()

@end

@implementation TLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"mainScreenNavBarTitle", nil);
    [self refresh];
}

- (void)refresh {
    [[TLNetworkManager sharedNetworkManager] postsRequestWithParam:nil completion:^(BOOL success, id object) {
        if (success) {
            NSLog(@"%@", object);
        }
    }];
}


@end
